
# This file is a generated template, your changes will not be overwritten

recNetClass <- if (requireNamespace('jmvcore')) R6::R6Class(
    "recNetClass",
    inherit = recNetBase,
    private = list(
        .run = function() {

            # `self$data` contains the data
            # `self$options` contains the options
            # `self$results` contains the results object (to populate)

          if (is.null(self$options$y1)){
            return(FALSE)
          }

          data        <- self$data
          standardise <- "none"

          # Variables ----
          y1 <- self$options$y1

          if(!plyr::is.discrete(data[[y1]])){
            y1vec <- jmvcore::toNumeric(data[[y1]])
          } else {
            if(is.factor(data[[y1]])){
              y1vec <- as.factor(data[[y1]])
            } else {
              y1vec <- as.character(data[[y1]])
            }
            y1Vlevel <- "Unordered categorical"
          }


          if(!any(plyr::is.discrete(y1vec),is.numeric(y1vec))){
            y1vec <- data[[y1]]
            y1Vlevel <- "Unordered categorical"
          }


          if(self$options$standardise=="none"){
            standardise <- "none"
          }

          if(is.numeric(y1vec)){

            y1Vlevel <- ifelse(all(is.wholenumber(y1vec)),"Discrete","Continuous")

            if(self$options$standardise=="meanSD"){
              standardise <- "mean.sd"
            }
            if(self$options$standardise=="medianMAD"){
              standardise <- "median.mad"
            }

            if(self$options$standardise=="unitScale"){
              y1vec <- elascer(y1vec)
              standardise <- "unit scale"
              y1Vlevel <- "Continuous"
            }

            if(self$options$standardise=="symbolicScale"){
              y1vec <- ts_symbolic(y1vec)
              y1vec <- y1vec[!is.na(y1vec)]

              standardise <- "symbolic"
              y1Vlevel <- "Ordered categorical"
            }

            if(any(standardise%in%c("mean.sd","median.mad"))){
              y1vec <- ts_standardise(y1vec, type = standardise,  adjustN = FALSE)
              y1Vlevel <- "Continuous"
            }
          }

          if(plyr::is.discrete(y1vec)&self$options$standardise!="symbolicScale"){
            y1Vlevel <- "Unordered categorical"
            if(is.factor(y1vec)){
              y1vec <- as.numeric_factor(y1vec)
              allvalues <- sort(unique(y1vec))
              y1vec <- factor(y1vec,labels = paste0(allvalues), levels = allvalues, ordered = is.ordered(data[[y1]]))
              if(is.ordered(y1vec)){
                y1Vlevel <- "Ordered categorical"
              }
            }
            if(is.character(y1vec)){
              allvalues <- as.numeric_character(sort(unique(c(y1vec))))
              y1vec <- factor(y1vec,labels = names(allvalues), levels = names(allvalues), ordered = is.ordered(data[[y1]]))
              if(is.ordered(y1vec)){
                y1Vlevel <- "Ordered categorical"
              }
            }
          }
          #
          #         if((!plyr::is.discrete(data[[y1]]))&self$options$discretise){
          #           data[[y1]] <- ts_symbolic(data[[y1]])
          #           v1_discretised <- "yes"
          #         }
          #
          #         if(is.factor(data[[y1]])|is.character(data[[y1]])){
          #           if(is.factor(data[[y1]])&is.ordered(data[[y1]])){
          #             y1Vlevel <- "Ordered categorical"
          #           } else {
          #             y1Vlevel <- "Unordered categorical"
          #           }
          #         }
          #         if(is.numeric(data[[y1]])){
          #           y1Vlevel <- typeof(data[[y1]])
          #         }

          TStable <- self$results$tblTS

          # Time Series table ----
          TStable$setRow(rowNo=1,
                         values=list(
                           var = y1,
                           vlevel = y1Vlevel,
                           N   = NROW(na.omit(data[[y1]])),
                           na  = sum(is.na(data[[y1]])),
                           uni_obs = length(unique(na.omit(data[[y1]]))),
                           transformed = standardise)
          )

          tsData <- data.frame(t  = seq_along(y1vec),
                               y1 = y1vec,
                               label = rep(y1,length(y1vec))
          )
          # tsImage <- self$results$tsplot
          # tsImage$setState(tsData)

          emLag <- self$options$emLag
          emDim <- self$options$emDim
          if(emDim<=0){emDim<-1}

          emRad <- NULL
          if(self$options$fixed%in%"RAD"){
            emRad <- self$options$fixRAD
            #if(emRad<=0){emRad<-emRad+.Machine$double.eps}
          }
          if(self$options$fixed%in%"RR"){
            emRad <- crqa_radius(y1 = tsData$y1, emLag = emLag, emDim = emDim, targetValue = self$options$fixRR)$Radius
          }
          if(self$options$fixed%in%"NO"){
            RM <- rp(y1 = tsData$y1, emDim = emDim, emLag = emLag, method = as.character(self$options$norm), weighted = self$options$Gweight)
          } else {
            RM <- rp(y1 = tsData$y1, emDim = emDim, emLag = emLag, emRad = emRad, method = as.character(self$options$norm), weighted = self$options$Gweight)
          }

          rpImage <- self$results$rpplot
          rpImage$setState(RM)

          # if(!is.null(emRad)){
          #
          #   if(self$options$DLmax<=0){
          #     DLmax <- length(Matrix::diag(RM))-1
          #   }
          #   if(self$options$VLmax<=0){
          #     VLmax <- length(Matrix::diag(RM))-1
          #   }
          #   if(self$options$HLmax<=0){
          #     HLmax <- length(Matrix::diag(RM))-1
          #   }
          #
          #   crqa_all <- crqa_rp(RM = RM,emRad = emRad,
          #                       DLmin = self$options$DLmin, DLmax = DLmax,
          #                       VLmin = self$options$VLmin, VLmax = VLmax,
          #                       HLmin = self$options$HLmin, HLmax = HLmax,
          #                       theiler = self$options$theiler,
          #                       matrices = TRUE)
          #   crqa_out <- crqa_all$crqaMeasures
          #
          #   RPtable <- self$results$tblRP
          #
          #   RPtable$setRow(rowNo=1,
          #                  values = list(
          #                    emRad = emRad,
          #                    RP = crqa_out$RP_N,
          #                    RN = rp_size(RM, AUTO=TRUE),
          #                    RR = crqa_out$RR,
          #                    SING = crqa_out$SING_N,
          #                    DIV = crqa_out$DIV_dl,
          #                    REP = crqa_out$REP_av,
          #                    ANI = crqa_out$ANI)
          #   )
          #
          #   RQAtable <- self$results$tblRQA
          # }

          rnetImage <- self$results$rnetplot
          rnetImage$setState(RM)

        },

          .rpplot=function(rpImage, ...) {

            ready <- TRUE
            rm <- rpImage$state

            if(is.null(self$options$y1)){
              ready <- FALSE
            }

            if(ready){

              rm <- rpImage$state

              RadiusRRbar <- FALSE
              if(self$options$fixed%in%"NO"){
                RadiusRRbar <- TRUE
              }

              #   if(plyr::is.discrete(df$y1)){

              rppl <- rp_plot(rm, plotDimensions = TRUE, xlab = self$options$y1, ylab = self$options$y1, radiusValue = attributes(rm)$emRad, plotRadiusRRbar = RadiusRRbar)

              print(rppl)
              TRUE
            }
          },

          .rnetplot=function(rnetImage, ...) {

            ready <- TRUE
            rnet <- rnetImage$state

            if(is.null(self$options$y1)){
              ready <- FALSE
            }

            if(ready){

              rnet <- rnetImage$state

              #rnet[rnet<=quantile(rnet[upper.tri(rnet)],self$options$Qtile)] <- 0

              mode <- "undirected"
              if(self$options$Gdirect){
                mode <- "directed"
              }
              weighted <- NULL
              eweight  <- "weight"
              if(self$options$Gweight){
                weighted <- TRUE
              } else {
                eweight <- 1
              }

              tvec <- 1:length(Matrix::diag(rnet))
              w <- max(plyr::laply(paste0(tvec), nchar), na.rm = TRUE)
              colnames(rnet) <- formatC(tvec, width=w, flag="0")
              rownames(rnet) <- formatC(tvec, width=w, flag="0")

              switch (self$options$nsize,
                degree = nsize <- "degree",
                hubscore = nsize <- "hubscore",
                fixed = nsize <- .3
              )

              switch (self$options$nsize,
                      degree = lsize <- "asnodesize",
                      hubscore = lsize <- "asnodesize",
                      fixed = lsize <- .6
              )

              g <- igraph::graph_from_adjacency_matrix(rnet, mode = mode, weighted = weighted, diag = FALSE)

              if(self$options$PruneDegree>0){
                g <- igraph::delete.vertices(g, which(igraph::degree(g) < self$options$PruneDegree))
              }
              if(self$options$PruneWeight>0){
                g <- igraph::delete.edges(g, which(igraph::E(g)$weight < self$options$PruneWeight))
              }

              if(self$options$Glabels){
                vlabs <- igraph::V(g)$name
              } else {
                vlabs <- ""
              }

              if(self$options$Glayout%in%"cl"){
                membership <- cut(tvec,breaks = 10,labels = FALSE)
                names(membership) <- igraph::V(g)$name
                igraph::E(g)$weight <- plotNET_groupWeight(g, membership, weigth.within = 5, weight.between = 10, preserve.weight.within = TRUE,preserve.weight.between = TRUE)
              }

              g <- plotNET_prep(g, labels = vlabs, nodesize = nsize, edgeweight = eweight,labelsize = lsize, doPlot = FALSE)
              switch(self$options$Glayout,
                     ni = l <- igraph::layout_nicely(g),
                     st = l <- igraph::layout_as_star(g),
                     ci = l <- igraph::layout_in_circle(g),
                     tr = l <- igraph::layout_as_tree(g),
                     fr = l <- igraph::layout_with_fr(g),
                     md = l <- igraph::layout_with_mds(g),
                     cl = l <- igraph::layout_with_fr(g, weights=igraph::E(g)$weight)
              )


              plot(g,layout=l)
              #print(g)
              TRUE
            }
        }
    )
)
