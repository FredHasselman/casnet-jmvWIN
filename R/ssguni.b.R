
# This file is a generated template, your changes will not be overwritten

ssgUNIClass <- if (requireNamespace('jmvcore')) R6::R6Class(
  "ssgUNIClass",
  inherit = ssgUNIBase,
  private = list(
    .run = function() {

      if (is.null(self$options$y1)){
        return(FALSE)
      }

      y1_ready <- FALSE
      y2_ready <- FALSE

      data <- self$data

      y1         <- self$options$y1
      v1_labels  <- self$options$v1_labels
      v1_numeric <- self$options$v1_Nstates

      # Get number of categories
      v1_labels_usr  <- strsplit(x = v1_labels,split = "[,]")[[1]]
      v1_Nlabels_usr <- length(v1_labels_usr)
      v1_Nstates_usr <- v1_numeric


      # Get labels in data (obs, if any)
      v1_labels_obs  <- unique(as.character(data[[y1]]))
      v1_Nlabels_obs <- length(v1_labels_obs)

      warningMessage1 <- paste("Variable",y1,"has",v1_Nlabels_obs,"unique categories.")

      if(v1_Nlabels_usr>0&v1_Nstates_usr>0){
        if(v1_Nlabels_usr!=v1_Nstates_usr){
          jmvcore::reject(jmvcore::format('Number of user defined states and number of user defined state labels mismatch for {}',y1))
        }}

      LABS_v1 <- ""
      if(v1_Nlabels_usr>0){
        if(v1_Nlabels_usr==v1_Nlabels_obs){
          if(!identical(sort(v1_labels_obs),sort(v1_labels_usr))){
            warningMessage1 <- paste0("User defined and observed state labels are different for ",y1,". User defined labels will be used.")
            LABS_v1 <- v1_labels_usr
          }
        } else {
          LABS_v1 <- v1_labels_obs
        }
        if(v1_Nlabels_usr<v1_Nlabels_obs){
          warningMessage1 <- paste0("Fewer user defined state labels than observed in ",y1,". Observed labels will be used.")
          LABS_v1 <- v1_labels_obs
        }
        if(v1_Nlabels_usr>v1_Nlabels_obs){
          warningMessage1 <- paste0("More user defined state labels than observed in ",y1,". User defined labels will be used.")
          LABS_v1 <- v1_labels_obs
        }

      } else {
        LABS_v1 <- v1_labels_obs
      }
      if(LABS_v1!=""){
        y1_ready <- TRUE
      }

      # Variable 2 ----
      y2         <- paste0(y1,".lag",self$results$ssgUNIlag)
      y2vec      <- ts_embed(data[[y1]],1,1)
      v2_labels  <- v1_labels
      v2_numeric <- v1_numeric

      # Get number of categories
      v2_labels_usr  <- strsplit(x = v1_labels,split = "[,]")[[1]]
      v2_Nlabels_usr <- length(v1_labels_usr)
      v2_Nstates_usr <- v2_numeric

      # Get labels in data (obs, if any)
      v2_labels_obs  <- unique(as.character(y2vec))
      v2_Nlabels_obs <- length(v2_labels_obs)

      warningMessage2 <- paste("Variable",y2,"has",v2_Nlabels_obs,"unique categories.")

      if(v2_Nlabels_usr>0&v2_Nstates_usr>0){
        if(v2_Nlabels_usr!=v2_Nstates_usr){
          jmvcore::reject(jmvcore::format('Number of user defined states and number of user defined state labels mismatch for {}',y2))
        }}

      LABS_v2 <- ""
      if(v2_Nlabels_usr>0){
        if(v2_Nlabels_usr==v2_Nlabels_obs){
          if(!identical(sort(v2_labels_obs),sort(v2_labels_usr))){
            warningMessage2 <- paste0("User defined and observed state labels are different for",y2,". User defined labels will be used.")
            LABS_v2 <- v2_labels_usr
          } else {
            LABS_v2 <- v2_labels_obs
          }
        }
        if(v2_Nlabels_usr<v2_Nlabels_obs){
          warningMessage2 <- paste("Fewer user defined state labels than observed in",y2,". Observed labels will be used.")
          LABS_v2 <- v2_labels_obs
        }
        if(v2_Nlabels_usr>v2_Nlabels_obs){
          warningMessage2 <- paste("More user defined state labels than observed in",y2,". User defined labels will be used.")
          LABS_v2 <- v2_labels_obs
        }
      } else {
        LABS_v2 <- v2_labels_obs
      }
      if(LABS_v2!=""){
        y2_ready <- TRUE
      }


      if(v1_Nlabels_usr==0&v1_Nstates_usr>0){
        v1_Nlabels_usr <- v1_Nstates_usr
      }
      if(v1_Nlabels_usr>0&v1_Nstates_usr==0){
        v1_Nlabels_usr -> v1_Nstates_usr
      }
      if(v2_Nlabels_usr==0&v2_Nstates_usr>0){
        v2_Nlabels_usr <- v2_Nstates_usr
      }
      if(v2_Nlabels_usr>0&v2_Nstates_usr==0){
        v2_Nlabels_usr -> v2_Nstates_usr
      }

      self$results$warnings$setContent(paste(warningMessage1,warningMessage2,sep="\n"))

      if(all(y1_ready,y2_ready)){

        LABS_v1 <- sort(LABS_v1)
        LABS_v2 <- sort(LABS_v2)

        COORD_v1 <- seq_along(LABS_v1)
        COORD_v2 <- seq_along(LABS_v2)

        y1vec <- data[[y1]]

        y1.levels <- sort(unique(paste(y1vec)))
        if(length(y1.levels)<length(LABS_v1)){
          y1.levels <- c(y1.levels,LABS_v1[(1+length(y1.levels)):length(LABS_v1)])
        }
        y1vec <- as.numeric(factor(y1vec,levels = y1.levels, labels = COORD_v1))
        data[[y1]] <- factor(y1vec,levels = COORD_v1, labels = LABS_v1)

        y2.levels <- sort(unique(y2vec))
        if(length(y2.levels)<length(LABS_v2)){
          y2.levels <- c(y2.levels,LABS_v2[(1+length(y2.levels)):length(LABS_v2)])
        }
        y2vec <- as.numeric(factor(y2vec,levels = y2.levels, labels = COORD_v2))
        y2vec <- factor(y2vec,levels = COORD_v2, labels = LABS_v2)

        rm(y1vec)


        # data[[y1]] <- factor(data[[y1]],labels=LABS_v1)
        # y2vec <- factor(y2vec,labels=LABS_v2)

        # SSG
        # ssg <- matrix(data = 0, nrow = length(LABS_v1),ncol=length(LABS_v2),dimnames = list(LABS_v1,LABS_v2))
        # dlist <-list(LABS_v1,LABS_v2)
        # names(dlist) <- c(y1,y2)
        # ssg_freq <- arrayInd(which(ssg==0),.dim = dim(ssg), .dimnames = dlist,useNames = TRUE)
        # ssg_freq$combi <- interaction(LABS_v1,LABS_v2)

        ssg      <- data.frame(expand.grid(y1=LABS_v1,y2=LABS_v2),expand.grid(y1=COORD_v1,y2=COORD_v2))
        colnames(ssg) <- c(y1,y2,paste0("COORD.",y1),paste0("COORD.",y2))
        ssg$cell <- paste0(ssg[,1],".",ssg[,2])
        ssg$loc <- paste0("[",ssg[,3],",",ssg[,4],"]")
        ssg$value <- NA
        for(i in seq_along(ssg$cell)){
          ssg$value[ssg$cell%in%ssg$cell[i]] <- i%%2
        }
        ssg$value <- factor(ssg$value)

        t <- self$options$time
        if(!is.null(t)){
          data[[t]] <- jmvcore::toNumeric(data[[t]])
          tNA <- is.na(data[[t]])
        } else {
          t   <- "Time (generated)"
          tNA <- 0
        }

        #data        <- na.omit(data)
        if(t%in%"Time (generated)"){
          tvec <- seq_along(data[[y1]])
        } else {
          tvec <- as.numeric(data[[t]])
        }

        cell_obs <- factor(paste0(data[[y1]],".",y2vec))

        durations       <- ts_duration(cell_obs, timeVec = tvec)
        durations$value <- NA
        durations$value <- factor(plyr::laply(durations$y,function(t){as.numeric(paste(ssg$value[ssg$cell%in%t]))}))

        durations$x.from <- plyr::laply(durations$y,function(t){as.numeric(ssg[,3][ssg$cell%in%t])})
        durations$y.from <- plyr::laply(durations$y,function(t){as.numeric(ssg[,4][ssg$cell%in%t])})
        durations$y1 <- factor(plyr::laply(strsplit(paste(durations$y),"[.]"),function(n1){n1[1]}), labels = LABS_v1)
        durations$y2 <- factor(plyr::laply(strsplit(paste(durations$y),"[.]"),function(n1){n1[2]}), labels = LABS_v2)

        ssg_obs <- durations %>% dplyr::group_by(y) %>% dplyr::summarise(Nvisits = n(),
                                                                         Nreturns = Nvisits-1,
                                                                         MNduration = mean(duration.time),
                                                                         SDduration = stats::sd(duration.time),
                                                                         Nevents = sum(duration.samples),
                                                                         MNevent = sum(duration.time)/sum(duration.samples),
                                                                         SDevent = stats::sd(duration.samples/duration.samples),
                                                                         MNreturn = 0,
                                                                         SDreturn =0)


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
        if(is.factor(y2vec)|is.character(y2vec)){
          if(is.factor(y2vec)&is.ordered(y2vec)){
            y2.vlevel <- "Ordered categorical"
          } else {
            y2.vlevel <- "Unordered categorical"
          }
        }
        if(is.numeric(y2vec)){
          y2.vlevel <- typeof(y2vec)
        }

        TStable$setRow(rowNo=1,
                       values=list(
                         var = y1,
                         vlevel = y1.vlevel,
                         N   = NROW(na.omit(data[[y1]])),
                         na  = sum(is.na(data[[y1]])),
                         uni_obs = v1_Nlabels_obs,
                         uni_exp = v1_Nlabels_usr,
                         discretised = "no")
        )

        TStable$setRow(rowNo=2,
                       values=list(
                         var = y2,
                         vlevel = y2.vlevel,
                         N   = NROW(na.omit(y2vec)),
                         na  = sum(is.na(y2vec)),
                         uni_obs = v2_Nlabels_obs,
                         uni_exp = v2_Nlabels_usr,
                         discretised = "no")
        )

        SSGtable <- self$results$tblSSG
        SSGtable$setRow(rowNo=1,
                        values=list(
                          Nstates = sum(ssg_obs$Nvisits, na.rm = TRUE),
                          Ntraj = NROW(durations$trajectory.id)-1,
                          Nreturns = 0))

        SSGtableStates <- self$results$tblSSGstates

        for (s in seq_along(ssg_obs$y)){
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

        tsData <- data.frame(t  = tvec,
                             y1 = data[[y1]],
                             y2 = y2vec,
                             combi = cell_obs
        )

        tsImage <- self$results$tsplot
        tsImage$setState(tsData)

        SSGplot <- self$results$SSGplot
        SSGplot$setState(durations)
      } else {
        return(FALSE)
      }
    },

    .tsplot=function(tsImage, ...) {

      ready <- TRUE
      dfl <- tsImage$state

      if(is.null(self$options$y1)){
        ready <- FALSE
      }
      if(!is.data.frame(dfl)){
        ready <- FALSE
      }

      if(ready){

        dfl <- tsImage$state

        #colnames(dfl) <- c("time",self$options$y1,self$options$y2)
        #df <- tidyr::gather(dfl, key = label, value = y1, -t)

        df <- data.frame(t  = c(dfl$t,dfl$t),
                         y1 = factor(c(paste(dfl$y1),paste(dfl$y2))),
                         label = c(rep(self$options$y1,NROW(dfl$y1)), rep(self$options$y2, NROW(dfl$y2)))
        )

        pal <- scales::col_factor(palette="Blues", domain=NULL)(levels(df$y1))

        tspl <- ggplot2::ggplot(df, ggplot2::aes_(x=~t, y=~y1, fill=~y1)) +
          ggplot2::geom_point(pch=22,colour="black") +
          ggplot2::facet_grid(label ~ ., scales = "free") +
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

      if(is.null(self$options$y1)){
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
        last  <- trajectories[(NROW(trajectories)-1),]

        mark <- plyr::ldply(list(First=first, Last = last))
        mark$.id <- relevel(factor(mark$.id),ref="First")

        LABS_v1 <- levels(durData$y1)
        LABS_v2 <- levels(durData$y2)

        flist <- c("0" = "grey80","1" = "grey50")
        clist <- c("Last" = "red3","First" = "steelblue4", "NA" = "orange")
        slist <- c("1"=3, "2" = 6, "3"= 8, "4" = 10)

        ssgr <- ggplot2::ggplot(durData, ggplot2::aes_(x=~y1,y=~y2,group=~value)) +
          ggplot2::geom_raster(ggplot2::aes_(fill=~value), alpha =.5, show.legend = FALSE) +
          ggplot2::geom_point(data = trajectories,
                              ggplot2::aes(x = x.fromRND, y = y.fromRND, size= size),
                              fill="steelblue", colour="black", alpha=.5, pch = 21, show.legend = FALSE) +
          ggplot2:: geom_curve(data=trajectories, ggplot2::aes(x = x.fromRND, y = y.fromRND, xend = x.toRND, yend = y.toRND),
                               lineend = "butt", curvature = 0.2, angle = 120, ncp=10,
                               arrow= grid::arrow(angle = 20, length = grid::unit(0.02, units = "npc"), type = "closed"),
                               alpha = .8, colour = "grey70", show.legend = FALSE,arrow.fill = "black") +
          ggplot2::geom_curve(data = mark, ggplot2::aes(x = x.fromRND, y = y.fromRND, xend = x.toRND, yend = y.toRND, colour = .id),
                              lineend = "butt", curvature = 0.2, angle = 120, ncp=10,
                              arrow= grid::arrow(angle = 15, length = grid::unit(0.015, units = "npc"), type = "closed"),
                              alpha=1, size=1, arrow.fill = "black") +
          ggplot2::guides(colour = "legend",size="none",fill="none") +
          ggplot2::scale_color_manual("Trajectory", values = clist) +
          ggplot2::scale_fill_manual(values = flist) +
          ggplot2::scale_size_manual(breaks = 1:4,values = slist) +
          ggplot2::scale_x_discrete(self$options$y1,expand = c(0,0),breaks = LABS_v1,labels = LABS_v1) +
          ggplot2::scale_y_discrete(y2,expand = c(0,0),breaks = LABS_v2, labels = LABS_v2) +
          ggplot2::coord_equal(length(LABS_v1)/length(LABS_v1)) +
          ggplot2::theme_bw() +
          ggplot2::theme(panel.grid.major = ggplot2::element_blank())

        print(ssgr)
        TRUE
      }
    }
  )
)
