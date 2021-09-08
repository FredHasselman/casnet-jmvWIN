

# State Space Grids ------


#' Import GrdWare files
#'
#' @param gwf_name Name of the GridWare project file. A directory named \code{../gwf_name_trjs} must be present at the location of the project file.
#' @param returnOnlyData Just return the data, do not return a list object with data, variable info and preferences.
#' @param saveLongFormat Save the long format trajectory data as a \code{.csv} file in the same location as \code{gwf_name}
#'
#' @return A data frame containing State Space Grid trajectories, or a list object with additional info.
#' @export
#'
ssg_gwf2long <- function(gwf_name, delta_t = 0.01,returnOnlyData = TRUE, saveLongFormat = FALSE){
  gwf_lines <- readr::read_lines(gwf_name)

  var_list_b <- which(grepl("<Config>", gwf_lines, fixed = TRUE))+1
  var_list_e <- which(grepl("MinReturns", gwf_lines, fixed = TRUE))-1

  Nvars   <- length(gwf_lines[var_list_b:var_list_e])
  MaxCols <-  max(plyr::laply(as.list(gwf_lines[var_list_b:var_list_e]), function(li){length(strsplit(li,"\t")[[1]])}))

  var_list <- as.list(gwf_lines[var_list_b:var_list_e])
  varinfo <-   plyr::ldply(var_list, function(li){
    tmp <- strsplit(li,"\t")[[1]]
    dat<- tibble::as_tibble(data.frame(var.name = tmp[3],
                                       var.role = tmp[1],
                                       var.type = tmp[2]))
    if(dat$var.type%in%"integer"|dat$var.role%in%"state"){
      dat$min <- tmp[4]
      dat$max <- tmp[5]
    } else {
      dat$min <- NA
      dat$max <- NA
    }
    if(dat$var.type%in%"categorical"){
      Bvals <- 4
    } else {
      Bvals <- 6
    }
    Evals <- length(tmp)-Bvals
    Nvals <- length(tmp[Bvals:(Bvals+Evals)])
    dat2 <- tibble::as_tibble(matrix(NA,ncol=MaxCols-NCOL(dat), dimnames = list(NULL,paste0("value",1:(MaxCols-NCOL(dat))))))
    if(length(tmp)>3){
      dat2[1,1:Nvals] <- tmp[Bvals:(Bvals+Evals)]
    }
    return(cbind.data.frame(dat,dat2))
  })
  varinfo <- tibble::as_tibble(varinfo)

  conf_list_b <- which(grepl("MinReturns", gwf_lines, fixed = TRUE))
  conf_list_e <- which(grepl("</Config>", gwf_lines, fixed = TRUE))-1
  conf_list <-  readr::read_tsv(paste0(c("setting\tvalue",gwf_lines[conf_list_b:conf_list_e]),collapse = "\n"))

  traj_list_b <- which(grepl("<Trajectories>", gwf_lines, fixed = TRUE))+1
  traj_list_e <- which(grepl("</Trajectories>", gwf_lines, fixed = TRUE))-1
  traj_list <- readr::read_tsv(paste0(gwf_lines[traj_list_b:traj_list_e],collapse = "\n"))

  state_vars <- sum(varinfo$var.role=="state")+1
  dirname <- paste0(gsub(".gwf","",gwf_name,fixed = TRUE),"_trjs")
  if(dir.exists(dirname)){
    trj_data <- dir(dirname, pattern = "([.]trj)$", full.names =TRUE, include.dirs = FALSE)
    names(trj_data) <-  dir(dirname, pattern = "([.]trj)$", full.names =FALSE, include.dirs = FALSE)

    suppressMessages(suppressWarnings(data_long <- plyr::ldply(trj_data, function(p){
      tmp <- readr::read_tsv(p)
      for(l in 1:(NROW(tmp)-1)){
        return(data.frame(time = seq(from = tmp$Onset[l],to = (tmp$Onset[l+1]-delta_t), by = delta_t), tmp[l,-1]))
      }
    }, .id = "Filename"))
    )
    suppressMessages(suppressWarnings(data_long <- dplyr::left_join(x = data_long,traj_list,by="Filename")))


    attr(data_long,"Preferences") <-  conf_list
    attr(data_long,"Variable definitions") <-  varinfo
  }

  if(returnOnlyData){
    return(data_long)
  } else {
    return(list(variable_config = varinfo,
                settings_config = conf_list,
                trajectories_list  = traj_list,
                data_long          = data_long))
  }
}


#' ssg_winnowing
#'
#' @param durations durations frame
#' @param screeCut cutoff
#' @param timeLimit Stop the procedure after this time limit isn seconds (default = `120`)
#'
#' @return attractor frame
#' @export
#'
ssg_winnowing <- function(durations, screeCut, timeLimit = 120){

  durations$duration.time[is.na(durations$duration.time)] <- 0
  winnowing <- durations %>% dplyr::filter(duration.time>0)
  Ncells <- NROW(winnowing)
  winnowingList <- scree <- heterogeneity <- list()
  removed <- 0
  run <- 1
  exp <- sum(winnowing$duration.time, na.rm = TRUE)/NROW(winnowing)
  #obs <- winnowing$duration.time-exp
  heterogeneity[[run]] <- sum((winnowing$duration.time-exp)^2 / exp, na.rm = TRUE) / NROW(winnowing)
  scree[[run]] <- 1
  removed <- Ncells - NROW(winnowing)
  winnowingList[[run]] <- winnowing

  while(removed!=(Ncells-1)){
    run <- run +1

    winnowing <- winnowing %>% dplyr::filter(duration.time>min(winnowing$duration.time, na.rm = TRUE))
    removed <- Ncells - NROW(winnowing)
    exp <- sum(winnowing$duration.time, na.rm = TRUE)/NROW(winnowing)

    heterogeneity[[run]] <- sum((winnowing$duration.time-exp)^2 / exp, na.rm = TRUE) / NROW(winnowing)
    scree[[run]]         <-  (heterogeneity[[run-1]]-heterogeneity[[run]])/heterogeneity[[run-1]]
    winnowingList[[run]] <- winnowing
  }

  useRun <- which(unlist(scree)<.5)[1]

  return(list(
    useRun = which(unlist(scree)<screeCut)[1],
    attractors = winnowingList[[useRun]],
    scree = scree,
    heterogeneity = heterogeneity
  )
  )
}


#' Factor labels
#'
#' @param observed_Ncat obsN
#' @param observed_labels obsL
#' @param expected_Ncat expN
#' @param expected_labels expL
#' @param varname varname
#'
#' @return character vector
#' @export
#'
factor_obs_exp <- function(observed_Ncat, observed_labels, expected_Ncat=0, expected_labels="", varname = ""){

  LABS <- ""
  warningMessage <- ""
  if(expected_Ncat>0){

    if(expected_Ncat==observed_Ncat){
      if(!identical(sort(observed_labels),sort(expected_labels))){
        #  warningMessage <- paste0("User defined and observed state labels are different. User defined labels will be used.")
        newN <- sum(expected_labels%in%observed_labels, na.rm = TRUE)
        if(newN < observed_Ncat){
          warningMessage <- paste("Different user defined state labels from those observed. New user defined labels will be added.")
          LABS  <- expected_labels[!expected_labels%in%observed_labels]
          LABS0 <- observed_labels[observed_labels%in%expected_labels]
          origin <- "expected"
          code <-  paste0("c('",paste0(LABS0, collapse="','"),"','",paste0(LABS, collapse="','"),"')")
        }
      } else {
        LABS <- observed_labels
        origin <- "observed"
        code <- paste0("factor(",varname,", levels = c('",paste0(LABS, collapse="','"),"'))")
      }
    }

    if(expected_Ncat<observed_Ncat){
      warningMessage <- paste("Fewer user defined state labels than observed. Observed labels will be used.")
      LABS <- observed_labels
      origin <- "observed"
      code <- paste0("factor(",varname,", levels = c('",paste0(LABS, collapse="','"),"'))")
    }
    if(expected_Ncat>observed_Ncat){
      newN <- sum(expected_labels%in%observed_labels, na.rm = TRUE)
      if(newN <observed_Ncat){
        warningMessage <- paste("More user defined state labels than observed. New user defined labels will be added.")
        LABS  <- expected_labels[!expected_labels%in%observed_labels]
        LABS0 <- observed_labels[observed_labels%in%expected_labels]
        origin <- "expected"
        code <-  paste0("c('",paste0(LABS0, collapse="','"),"','",paste0(LABS, collapse="','"),"')")
      } else {
        warningMessage <- paste("More user defined state labels than observed. User defined labels will be used.")
        LABS <- expected_labels
        origin <- "expected"
        code <- paste0("factor(",varname,", levels = c('",paste0(LABS, collapse="','"),"'))")
      }
    }
  } else {
    LABS <- observed_labels
    origin <- "observed"
    code <- paste0("factor(",varname,", levels = c('",paste0(LABS, collapse="','"),"'))")
  }
  attr(LABS,"varname") <- varname
  attr(LABS,"warningMessage") <- warningMessage
  attr(LABS,"origin") <- origin
  attr(LABS,"code") <- code
  return(LABS)
}
