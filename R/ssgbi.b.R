
# This file is a generated template, your changes will not be overwritten

# if(!any(plyr::is.discrete(data[[y1]]))){
#   if(is.factor(data[[y1]])){
#     v1_type_ori <- "factor"
#   } else {
#     v1_type_ori <- "character"
#   }
#   data[[y1]] <- as.numeric_discrete(data[[y1]])  #ts_symbolic(data[[y1]])
#   v1_type_tra <- "named numeric"
#
# } else {
#
# if(is.wholenumber(data[[y1]])){
#   v1_type_ori <- "discrete numeric"
#   data[[y1]] <- as.factor(factor(data[[y1]], ordered = TRUE))
#
#
# } else {
#   data[[y1]] <- ts_discrete(data[[y1]])
#   v1_discretised <- "yes"
# }

# LABS_v1 <- factor_obs_exp(varname = "data[[y1]]", observed_Ncat = v1_Nlabels_obs, expected_Ncat = v1_Nlabels_usr, observed_labels = v1_labels_obs, expected_labels = v1_labels_usr)
#
# # if(grepl("^(c\\(levels\\()",attributes(LABS_v1)$code)){
# #   eval(parse(text = paste0("levels(data[[y1]]) <- ", attributes(LABS_v1)$code)))
# # } else {
# #   eval(parse(text = paste0("data[[y1]] <- ", attributes(LABS_v1)$code)))
# # }
#
# if(LABS_v1!=""){
#   y1_ready <- TRUE
# }
# warningMessage1 <- attributes(LABS_v1)$warningMessage
# if(warningMessage1==""){
#   warningMessage1 <- paste("Variable",y1,"has",v1_Nlabels_obs,"unique categories.")
# }
#
# LABS_v2 <- factor_obs_exp(varname = "data[[y2]]", observed_Ncat = v2_Nlabels_obs, expected_Ncat = v2_Nlabels_usr, observed_labels = v2_labels_obs, expected_labels = v2_labels_usr)
#
# # if(grepl("^(c\\(levels\\()",attributes(LABS_v2)$code)){
# #   eval(parse(text = paste0("levels(data[[y2]]) <- ", attributes(LABS_v2)$code)))
# # } else {
# #   eval(parse(text = paste0("data[[y2]] <- ", attributes(LABS_v2)$code)))
# # }
#
# if(LABS_v2!=""){
#   y2_ready <- TRUE
# }
# warningMessage2 <- attributes(LABS_v2)$warningMessage
# if(warningMessage2==""){
#   warningMessage2 <- paste("Variable",y2,"has",v2_Nlabels_obs,"unique categories.")
# }
#
# if(v1_Nlabels_usr==0 & v1_Nstates_usr>0){
#   v1_Nlabels_usr <- v1_Nstates_usr
# }
# if(v1_Nlabels_usr>0 & v1_Nstates_usr==0){
#   v1_Nlabels_usr -> v1_Nstates_usr
# }
# if(v2_Nlabels_usr==0&v2_Nstates_usr>0){
#   v2_Nlabels_usr <- v2_Nstates_usr
# }
# if(v2_Nlabels_usr>0&v2_Nstates_usr==0){
#   v2_Nlabels_usr -> v2_Nstates_usr
# }


ssgBIClass <- if (requireNamespace('jmvcore')) R6::R6Class(
  "ssgBIClass",
  inherit = ssgBIBase,
  private = list(
    .run = function() {

      if (is.null(self$options$y1)|is.null(self$options$y2)){
        return(FALSE)
      }

      y1_ready <- FALSE
      y2_ready <- FALSE

      data <- self$data
      data <- na.omit(data)
      # v1_type_ori <- v2_type_ori <- NA
      # v1_type_tra <- v2_type_tra <- NA
      # v1_discretised <- v2_discretised <- "no"

      # Variable 1 ----
      y1 <- self$options$y1
      v1 <- as.numeric_discrete(data[[y1]])

      # Get labels in data (obs, if any)
      v1_labels_obs <- LABS_v1 <- unique(names(v1))
      v1_Nlabels_obs <- v1_Nstates_usr <- length(v1_labels_obs)

      # Get number of categories
      if(length(self$options$v1_labels)>0){
       v1_labels      <- self$options$v1_labels
       v1_labels_usr  <- strsplit(x = v1_labels,split = "[,]")[[1]]
       v1_Nlabels_usr <- length(v1_labels_usr)
      } else {
        v1_labels_usr <- ""
        v1_Nlabels_usr <- 0
      }
      v1_Nstates_usr <- self$options$v1_Nstates

      # Variable 2 ----
      y2 <- self$options$y2
      v2 <- as.numeric_discrete(data[[y2]])

      # Get labels in data (obs, if any)
      v2_labels_obs  <- LABS_v2 <- unique(names(v2))
      v2_Nlabels_obs <- v2_Nstates_usr <- length(v2_labels_obs)

      if(length(self$options$v2_labels)>0){
      v2_labels      <- self$options$v2_labels
      v2_labels_usr  <- strsplit(x = v2_labels, split = "[,]")[[1]]
      v2_Nlabels_usr <- length(v2_labels_usr)
      } else {
        v2_labels_usr <- ""
        v2_Nlabels_usr <- 0
      }
      v2_Nstates_usr <- self$options$v2_Nstates

      # if(v1_Nlabels_usr>0&v1_Nstates_usr>0){
      #   if(v1_Nlabels_usr!=v1_Nstates_usr){
      #     jmvcore::reject(jmvcore::format('Number of user defined states and number of user defined state labels mismatch for {}',y1))
      #   }}
      #
      # if(v2_Nlabels_usr>0&v2_Nstates_usr>0){
      #   if(v2_Nlabels_usr!=v2_Nstates_usr){
      #     jmvcore::reject(jmvcore::format('Number of user defined states and number of user defined state labels mismatch for {}',y2))
      #   }}

      warningMessage1a <- paste("Variable",y1,"contains",v1_Nlabels_obs,"unique states")
      warningMessage1b <- paste("- if more states were possible, please specify missing categories!")
      warningMessage2a <- paste("Variable",y2,"contains",v2_Nlabels_obs,"unique states")
      warningMessage2b <- paste("- if more states were possible, please specify missing categories!")

      NLABS_V1 <- v1_Nlabels_obs + v1_Nlabels_usr
      if(self$options$v1_Nstates>0){
        if(v1_Nstates_usr<v1_Nstates_obs){
          jmvcore::reject(jmvcore::format('Number of user defined states and number of observed states mismatch for {}',y1))
        }
        if(v1_Nstates_usr>v1_Nstates_obs){
          warningMessage1b <- paste("-", v1_Nstates_usr, "were expected, please specify labels for",(v1_Nstates_usr-v1_Nstates_obs),"missing states!")
        }
        if(NLABS_V1==v1_Nlabels_obs){
          warningMessage1b <- paste("-", v1_Nstates_usr, "were expected,",v1_Nlabels_obs,"were provided.")
          LABS_v1 <- c(v1_labels_obs, v2_labels_usr)
        }
        y1_ready <- TRUE
      }

      NLABS_V2 <- v2_Nlabels_obs + v2_Nlabels_usr
      if(self$options$v2_Nstates>0){
        if(v2_Nstates_usr<v2_Nstates_obs){
          jmvcore::reject(jmvcore::format('Number of user defined states and number of observed states mismatch for {}',y2))
        }
        if(v2_Nstates_usr>v2_Nstates_obs){
          warningMessage2b <- paste("-", v2_Nstates_usr, "were expected, please specify labels for",(v2_Nstates_usr-v2_Nstates_obs),"missing states!")
        }
        if(NLABS_V2==v2_Nstates_usr){
          warningMessage2b <- paste("-", v2_Nstates_usr, "were expected,",v2_Nlabels_obs,"were provided.")
          LABS_v2 <- c(v2_labels_obs, v2_labels_usr)
        }
        y2_ready <- TRUE
      }

      self$results$warnings$setContent(paste(paste(warningMessage1a,warningMessage1b),
                                             paste(warningMessage2a,warningMessage2b),sep="\n"))



      if(all(y1_ready,y2_ready)){
      #

      #
        COORD_v1 <- seq_along(LABS_v1)
        COORD_v2 <- seq_along(LABS_v2)


        y1.levels <- sort(unique(paste(v1)))
        if(length(y1.levels)<length(LABS_v1)){
          y1.levels <- c(y1.levels,LABS_v1[(1+length(y1.levels)):length(LABS_v1)])
        }
        y1vec <- as.numeric(factor(v1,levels = y1.levels, labels = COORD_v1))
        data[[y1]] <- factor(v1,levels = COORD_v1, labels = LABS_v1)

        y2.levels <- sort(unique(v2))
        if(length(y2.levels)<length(LABS_v2)){
          y2.levels <- c(y2.levels,LABS_v2[(1+length(y2.levels)):length(LABS_v2)])
        }
        y2vec <- as.numeric(factor(v2,levels = y2.levels, labels = COORD_v2))
        data[[y2]] <- factor(v2,levels = COORD_v2, labels = LABS_v2)

        rm(y1vec,y2vec)

        data[[y1]] <- factor(data[[y1]],labels=LABS_v1)
        data[[y2]] <- factor(data[[y2]],labels=LABS_v2)

         # SSG
        ssg <- matrix(data = 0, nrow = NLABS_V1,ncol= NLABS_V2, dimnames = list(LABS_v1,LABS_v2))
        dlist <-list(LABS_v1,LABS_v2)
        names(dlist) <- c(y1,y2)

        ssg_freq <- arrayInd(which(ssg==0),.dim = dim(ssg), .dimnames = dlist,useNames = TRUE)
        ssg_freq$combi <- interaction(LABS_v1,LABS_v2)

        # Expected Grid ----
        ssg      <- data.frame(expand.grid(y1=LABS_v1,y2=LABS_v2),expand.grid(y1=COORD_v1,y2=COORD_v2))
        colnames(ssg) <- c(y1,y2,paste0("COORD.",y1),paste0("COORD.",y2))
        ssg$cell <- paste0(ssg[,1],".",ssg[,2])
        ssg$loc <- paste0("[",ssg[,3],",",ssg[,4],"]")
        ssg$value <- NA
        for(i in seq_along(ssg$cell)){
          ssg$value[ssg$cell%in%ssg$cell[i]] <- i%%2
        }
        ssg$value <- factor(ssg$value)

        # Time variable ----
        t <- self$options$time
        if(!is.null(t)){
          data[[t]] <- jmvcore::toNumeric(data[[t]])
          tNA <- is.na(data[[t]])
        } else {
          t   <- "Time (generated)"
          tNA <- 0
        }

        # Handle Trajectories and Waves ----
        SSG_cell_obs   <- factor(paste0(data[[y1]],".",data[[y2]]))
        SSG_cell_unobs <- ssg$cell[!ssg$cell%in%SSG_cell_obs]

        if(is.null(self$options$trajectories)){
          traj_ID <- c("A")
          trajectories <- "One"
        } else {
          trajectories <- self$options$trajectories
          data[[trajectories]] <- as.factor(data[[trajectories]])
          traj_ID      <- unique(data[[trajectories]])
        }
        if(is.null(self$options$waves)){
          wave_ID <- c("0")
          waves <- "None"
        } else {
          waves    <- self$options$waves
          data[[waves]] <- as.factor(data[[waves]])
          wave_ID  <- unique(data[[waves]])
        }

        SSG_traj <- list()
        cnt <- 0
        for(traj in traj_ID){
          if(is.null(self$options$trajectories)){
            trajs <- rep(TRUE,NROW(data))
          } else {
            trajs <- data[[trajectories]]%in%traj
          }
          for(wav in wave_ID){
            if(is.null(self$options$waves)){
              wavs <- rep(TRUE,NROW(data))
            } else {
              wavs <- data[[waves]]%in%wav
            }

            cnt <- cnt+1

            cell_obs   <- factor(paste0(data[[y1]][trajs&wavs],".",data[[y2]][trajs&wavs]))
            cell_unobs <- ssg$cell[!ssg$cell%in%cell_obs]

            if(t%in%"Time (generated)"){
              tvec <- seq_along(data[[y1]][trajs&wavs])
            } else {
              tvec <- as.numeric(data[[t]][trajs&wavs])
            }

            durations       <- ts_duration(cell_obs, timeVec = tvec)
            durations$Trajectory = traj
            durations$Wave = wav
            durations$value <- NA
            durations$value <- factor(plyr::laply(durations$y,function(t){as.numeric(paste(ssg$value[ssg$cell%in%t]))}))

            durations$x.from <- plyr::laply(durations$y,function(t){as.numeric(ssg[,3][ssg$cell%in%t])})
            durations$y.from <- plyr::laply(durations$y,function(t){as.numeric(ssg[,4][ssg$cell%in%t])})
            durations$y1 <- factor(plyr::laply(strsplit(paste(durations$y),"[.]"),function(n1){n1[1]})) #, labels = LABS_v1)
            durations$y2 <- factor(plyr::laply(strsplit(paste(durations$y),"[.]"),function(n1){n1[2]})) #, labels = LABS_v2)

            ssg_obs <- durations %>% dplyr::group_by(y) %>% dplyr::summarise(Trajectory = traj,
                                                                             Wave       = wav,
                                                                             Nvisits  = n(),
                                                                             Nreturns = Nvisits-1,
                                                                             MNduration = mean(duration.time),
                                                                             SDduration = stats::sd(duration.time),
                                                                             Nevents = sum(duration.samples),
                                                                             MNevent = sum(duration.time)/sum(duration.samples),
                                                                             SDevent = stats::sd(duration.samples/duration.samples),
                                                                             MNreturn = 0,
                                                                             SDreturn =0)


            SSG_traj[[cnt]] <- list(cell_obs = cell_obs,
                                    cell_unobs = cell_unobs,
                                    durations = durations,
                                    ssg_obs = ssg_obs)

          } # traj
        } # wav

        names(SSG_traj) <- paste0(traj_ID,"_",wave_ID,".trj")

        TStable <- self$results$tblTS

        if(is.factor(data[[y1]])|is.character(data[[y1]])){
          if(is.factor(data[[y1]])&is.ordered(data[[y1]])){
            y1.vlevel <- "Ordered categorical"
          } else {
            y1.vlevel <- "Unordered categorical"
          }
        }
        if(is.numeric(data[[y1]])){
          y1.vlevel <- typeof(data[[y1]])
        }
        if(is.factor(data[[y2]])|is.character(data[[y2]])){
          if(is.factor(data[[y2]])&is.ordered(data[[y2]])){
            y2.vlevel <- "Ordered categorical"
          } else {
            y2.vlevel <- "Unordered categorical"
          }
        }
        if(is.numeric(data[[y2]])){
          y2.vlevel <- typeof(data[[y2]])
        }

        # Time Series table ----
        TStable$setRow(rowNo=1,
                       values=list(
                         var = y1,
                         vlevel = y1.vlevel,
                         N   = NROW(na.omit(data[[y1]])),
                         na  = sum(is.na(data[[y1]])),
                         uni_obs = v1_Nlabels_obs,
                         uni_exp = v1_Nlabels_usr,
                         discretised = v1_discretised)
        )

        TStable$setRow(rowNo=2,
                       values=list(
                         var = y2,
                         vlevel = y2.vlevel,
                         N   = NROW(na.omit(data[[y2]])),
                         na  = sum(is.na(data[[y2]])),
                         uni_obs = v2_Nlabels_obs,
                         uni_exp = v2_Nlabels_usr,
                         discretised = v2_discretised)
        )

        # Grid table ----

        SSG_obs  <- plyr::ldply(SSG_traj, function(ssgl){ssgl$ssg_obs})
        SSG_obs$Trajectory <- factor(SSG_obs$Trajectory)
        SSG_obs$Wave <- factor(SSG_obs$Wave)
        traj_max <- plyr::ldply(SSG_traj, function(ssgl){max(ssgl$durations$t.end, na.rm = TRUE)})

        SSGtable <- self$results$tblSSG
        SSGtable$setRow(rowNo=1,
                        values=list(
                          Ntraj = length(unique(SSG_obs$Trajectory)),
                          Nwave = length(unique(SSG_obs$Wave)),
                          MNtrajDuration = mean(traj_max$V1, na.rm = TRUE),
                          SDtrajDuration = stats::sd(traj_max$V1, na.rm = TRUE),
                          uni_NstatesSSG = length(unique(SSG_cell_obs)),
                          uni_expSSG     = NROW(ssg$cell),
                          uni_unobsSSG   = length(unique(SSG_cell_unobs)),
                          Nreturns = sum(SSG_obs$Nreturns[SSG_obs$Nreturns>=self$options$MinReturns], na.rm = TRUE))
        )

        # Trajectories table ----

        traj_data <- plyr::ldply(SSG_traj, function(ssgl){ssgl$durations})
        # traj_data$Trajectory <- factor(traj_data$Trajectory)
        # traj_data$Wave <- factor(traj_data$Wave)
        traj_data <- traj_data %>% dplyr::group_by(Trajectory,Wave) %>% dplyr::summarise(TRAJduration = max(t.end, na.rm = TRUE),
                                                                                         TRAJvisited = length(unique(y)),
                                                                                         NeventsTRAJ = sum(duration.samples, na.rm = TRUE),
                                                                                         MNeventTRAJ = mean(duration.time, na.rm = TRUE),
                                                                                         SDeventTRAJ = stats::sd(duration.time, na.rm = TRUE)
        )

        traj_data_state <- SSG_obs %>% dplyr::group_by(Trajectory,Wave) %>% dplyr::summarise(TRAJvisited    = sum(Nvisits, na.rm = TRUE),
                                                                                             MNdurationTRAJ = mean(MNduration, na.rm = TRUE),
                                                                                             SDdurationTRAJ = stats::sd(MNduration, na.rm = TRUE))

        SSGtableTrajectories <- self$results$tblSSGtrajectories
        for (j in seq_along(traj_data$Trajectory)){
          SSGtableTrajectories$addRow(j,
                                      values=list(
                                        TRAJid = traj_data$Trajectory[j],
                                        TRAJwave = traj_data$Wave[j],
                                        TRAJduration = traj_data$TRAJduration[j],
                                        TRAJvisited = traj_data_state$TRAJvisited[j],
                                        MNdurationTRAJ = traj_data_state$MNdurationTRAJ[j],
                                        SDdurationTRAJ = traj_data_state$SDdurationTRAJ[j],
                                        NeventsTRAJ = traj_data$NeventsTRAJ[j],
                                        MNeventTRAJ = traj_data$MNeventTRAJ[j],
                                        SDeventTRAJ = traj_data$SDeventTRAJ[j],
                                        MNreturnTRAJ = 0,
                                        SDreturnTRAJ = 0
                                      ))
        }

        # States table ----
        SSGtableStates <- self$results$tblSSGstates

        for (s in seq_along(SSG_obs$y)){
          SSGtableStates$addRow(s,
                                values=list(
                                  stateName = paste(ssg_obs$y[s]),
                                  Nvisits = ssg_obs$Nvisits[s],
                                  Nreturns = ssg_obs$Nreturns[s],
                                  MNduration = ssg_obs$MNduration[s],
                                  SDduration = ssg_obs$SDduration[s],
                                  Nevents = ssg_obs$Nevents[s],
                                  MNevent = ssg_obs$MNevent[s],
                                  SDevent = ssg_obs$SDevent[s],
                                  MNreturn = ssg_obs$MNreturn[s],
                                  SDreturn = ssg_obs$MNduration[s]
                                ))
        }

        SSG_attr  <- plyr::ldply(SSG_traj, function(ssgl){ssgl$durations})
        SSG_attr$Trajectory <- factor(SSG_attr$Trajectory)
        SSG_attr$Wave       <- factor(SSG_attr$Wave)
        SSG_attr$duration.time[is.na(SSG_attr$duration.time)] <- 0

        if(is.null(self$options$trajectories)){
          traj_vec <- 1
        } else {
          traj_vec <-data[[trajectories]]
        }

        if(is.null(self$options$waves)){
          wav_vec <- 1
        } else {
          wav_vec <- data[[waves]]
        }

        if(is.null(self$options$time)){
          tvec <- seq_along(NROW(data))
        } else {
          tvec <- data[[self$options$time]]
        }


        tsData <- data.frame(t  = tvec,
                             y1 = data[[y1]],
                             y2 = data[[y2]],
                             combi = paste0(data[[y1]],".",data[[y2]]),#SSG_cell_obs,
                             Trajectory = traj_vec,
                             Waves = wav_vec)


        if(self$options$doWinnowing){
            screeCut <- self$options$screeCut
            attractors <- ssg_winnowing(durations = SSG_attr,screeCut = screeCut)

            ssg_attr <- attractors$attractors %>%
              dplyr::group_by(y) %>%
              dplyr::summarise(Trajectory = traj,
                               Wave       = wav,
                               Nvisits = n(),
                               Nreturns = Nvisits-1,
                               MNduration = mean(duration.time),
                               SDduration = stats::sd(duration.time),
                               Nevents = sum(duration.samples),
                               MNevent = sum(duration.time)/sum(duration.samples),
                               SDevent = stats::sd(duration.samples/duration.samples),
                               MNreturn = 0,
                               SDreturn =0)

            # Attractors table ----
            SSGtableAttractors <- self$results$tblSSGattractors
            SSGtableAttractors$setVisible(visible=TRUE)

            for (s in seq_along(ssg_attr$y)){
              SSGtableAttractors$addRow(s,
                                        values=list(
                                          stateName = paste(ssg_attr$y[s]),
                                          Nvisits = ssg_attr$Nvisits[s],
                                          Nreturns = ssg_attr$Nreturns[s],
                                          MNduration = ssg_attr$MNduration[s],
                                          SDduration = ssg_attr$SDduration[s],
                                          Nevents = ssg_attr$Nevents[s],
                                          MNevent = ssg_attr$MNevent[s],
                                          SDevent = ssg_attr$SDevent[s],
                                          MNreturn = ssg_attr$MNreturn[s],
                                          SDreturn = ssg_attr$MNduration[s]
                                        ))
            }
        } else {
          SSGtableAttractors <- self$results$tblSSGattractors
          SSGtableAttractors$setVisible(visible=FALSE)
        }

        tsImage <- self$results$tsplot
        tsImage$setState(tsData)

        dur_data <- plyr::ldply(SSG_traj, function(ssgl){ssgl$durations})
        dur_data$Trajectory <- factor(dur_data$Trajectory)
        dur_data$Wave <- factor(dur_data$Wave)

        ssgImage <- self$results$SSGplot
        ssgImage$setState(dur_data)
      } else {
        return(FALSE)
      }

    },

    .tsplot=function(tsImage, ...) {

      ready <- TRUE
      dfl <- tsImage$state

      if(is.null(self$options$y1)|is.null(self$options$y2)){
        ready <- FALSE
      }
      if(!is.data.frame(dfl)){
        ready <- FALSE
      }

      if(ready){

        dfl <- tsImage$state

        df <- tidyr::gather(dfl, key = label, value = y1, -c(1,4,5,6))

        df$y1         <- factor(df$y1)
        df$combi      <- factor(df$combi)
        df$Trajectory <- factor(df$Trajectory)
        df$Waves      <- factor(df$Waves)

        pal <- scales::col_factor(palette="Blues", domain=NULL)(levels(df$y1))

        tspl <- ggplot2::ggplot(df, ggplot2::aes_(x=~t, y=~y1, fill=~y1)) +
          ggplot2::geom_point(pch=22,colour="black") +
          ggplot2::facet_grid(Trajectory:Waves ~ label, scales = "free") +
          ggplot2::scale_x_continuous("Time") +
          ggplot2::scale_y_discrete("",labels = levels(df$y1)) +
          ggplot2::scale_fill_manual("Category",values = pal) +
          ggplot2::theme_bw() +
          ggplot2::theme(strip.text = ggplot2::element_text(face="bold"))

        print(tspl)
        TRUE
      }
    },

    .SSGplot=function(ssgImage, ...) {

      ready <- TRUE
      durData       <- ssgImage$state

      if(is.null(self$options$y1)|is.null(self$options$y2)){
        ready <- FALSE
      }
      if(!is.data.frame(durData)){
        ready <- FALSE
      }

      if(ready){

        pd <- ggplot2::position_jitterdodge(jitter.height=.4,jitter.width =.4, seed=12345)

        g1 <- ggplot2::ggplot(durData, ggplot2::aes(x=y1,y=y2,group=value)) +
          ggplot2::geom_raster(ggplot2::aes(fill=value),show.legend = FALSE, alpha =.5) +
          ggplot2:: geom_point(ggplot2::aes(size=duration.samples), position = pd, alpha=.5, show.legend = FALSE)

        # build the plot for rendering
        foo <- ggplot2::ggplot_build(g1)
        durData$x.fromRND <- foo$data[[2]][['x']]
        durData$y.fromRND <- foo$data[[2]][['y']]

        trajectories          <- durData
        trajectories$x.to     <- c(durData$x.from[seq_along(durData$x.from)[-1]],NA)
        trajectories$y.to     <- c(durData$y.from[seq_along(durData$y.from)[-1]],NA)
        trajectories$x.toRND  <- c(durData$x.fromRND[seq_along(durData$x.fromRND)[-1]],NA)
        trajectories$y.toRND  <- c(durData$y.fromRND[seq_along(durData$y.fromRND)[-1]],NA)
        trajectories          <- trajectories[1:(NROW(trajectories)-1),]
        trajectories$size     <- factor(cut(trajectories$duration.samples, 4, include.lowest = TRUE, ordered_result = TRUE, labels = FALSE, right = TRUE))

        first <- trajectories[trajectories$trajectory.id==1,]
        last  <- trajectories[(NROW(trajectories)),]

        mark <- plyr::ldply(list(First=first, Last = last))
        #mark$.id <- relevel(factor(mark$.id),ref=first[1])

        LABS_v1 <- levels(durData$y1)
        LABS_v2 <- levels(durData$y2)

        flist <- c("0" = "grey80","1" = "grey50")
        clist <- c("Last" = "red3","First" = "steelblue4", "NA" = "orange")
        slist <- c("1"=3, "2" = 6, "3"= 8, "4" = 10)
        if(length(unique(trajectories$Trajectory:trajectories$Wave))>1){
          pal <- scales::col_factor(palette="Accent", domain=NULL)(unique(trajectories$Trajectory:trajectories$Wave))
        } else {
          pal <- "#AAB2A9"
        }

        ssgr <- ggplot2::ggplot(durData, ggplot2::aes_(x=~y1,y=~y2,group=~value)) +
          ggplot2::geom_raster(ggplot2::aes_(fill=~value), alpha =.5, show.legend = FALSE) +
          ggplot2::geom_point(data = trajectories,
                              ggplot2::aes(x = x.fromRND, y = y.fromRND, size= size),
                              fill="steelblue", colour="black", alpha=.5, pch = 21, show.legend = FALSE) +
          ggplot2:: geom_curve(data=trajectories, ggplot2::aes(x = x.fromRND, y = y.fromRND, xend = x.toRND, yend = y.toRND, colour = Trajectory),
                               lineend = "butt", curvature = 0.2, angle = 120, ncp=10,
                               arrow= grid::arrow(angle = 20, length = grid::unit(0.02, units = "npc"), type = "closed"),
                               alpha = .8, show.legend = FALSE,arrow.fill = "black") +
          ggplot2::geom_curve(data = mark, ggplot2::aes(x = x.fromRND, y = y.fromRND, xend = x.toRND, yend = y.toRND, colour = .id),
                              lineend = "butt", curvature = 0.2, angle = 120, ncp=10,
                              arrow= grid::arrow(angle = 15, length = grid::unit(0.015, units = "npc"), type = "closed"),
                              alpha=1, size=1, arrow.fill = "black") +
          ggplot2::guides(colour = "legend",size="none",fill="none") +
          #ggplot2::scale_color_manual("Trajectory", values = pal) +
          ggplot2::scale_fill_manual(values = flist) +
          ggplot2::scale_size_manual(breaks = 1:4,values = slist) +
          ggplot2::scale_x_discrete(self$options$y1,expand = c(0,0),breaks = LABS_v1,labels = LABS_v1) +
          ggplot2::scale_y_discrete(self$options$y2,expand = c(0,0),breaks = LABS_v2, labels = LABS_v2) +
          ggplot2::coord_equal(length(LABS_v1)/length(LABS_v1)) +
          ggplot2::theme_bw() +
          ggplot2::theme(panel.grid.major = ggplot2::element_blank())

        print(ssgr)
        TRUE
      }
    }
  )
)
