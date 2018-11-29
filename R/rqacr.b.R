
# This file is a generated template, your changes will not be overwritten

rqaCRClass <- if (requireNamespace('jmvcore')) {
  R6::R6Class(
    "rqaCRClass",
    inherit = rqaCRBase,
    private = list(
        .run = function() {

          if (is.null(self$options$y1)|is.null(self$options$y2)){
            return(FALSE)
          }

          v1_discretised <- "no"
          v2_discretised <- "no"

          data <- self$data

          # Variable 1 ----
          y1 <- self$options$y1

          if(!plyr::is.discrete(data[[y1]])){
            y1vec <- jmvcore::toNumeric(data[[y1]])

            if(self$options$discretise){
              y1vec <- ts_symbolic(y1vec)
              v1_discretised <- "yes"
              } else {
                y1.vlevel <- paste(typeof(y1vec),"(unit scale)")
                y1vec <- elascer(y1vec)
              }
          } else {
            if(is.factor(data[[y1]])|is.character(data[[y1]])){
              if(is.factor(data[[y1]])){
                y1vec <- as.factor(data[[y1]])
                y1vec <- as.numeric_factor(y1vec)
              } else {
                y1vec <- as.character(data[[y1]])
                y1vec <- as.numeric_character(y1vec)
              }
              if(is.factor(y1vec)&is.ordered(y1vec)){
                y1.vlevel <- "Ordered categorical"
              } else {
                y1.vlevel <- "Unordered categorical"
              }
            }
          }

          # Variable 2 ----
          y2 <- self$options$y2

          if(!plyr::is.discrete(data[[y2]])){
            y2vec <- jmvcore::toNumeric(data[[y2]])

            if(self$options$discretise){
              y2vec <- ts_symbolic(y2vec)
              v2_discretised <- "yes"
            } else {
              y2.vlevel <- paste(typeof(y2vec),"(unit scale)")
              y2vec <- elascer(y2vec)
            }
          } else {
            if(is.factor(data[[y2]])|is.character(data[[y2]])){
              if(is.factor(data[[y2]])){
                y2vec <- as.factor(data[[y2]])
                y2vec <- as.numeric_factor(y2vec)
              } else {
                y2vec <- as.character(data[[y2]])
                y2vec <- as.numeric_character(y2vec)
              }
              if(is.factor(y2vec)&is.ordered(y2vec)){
                y2.vlevel <- "Ordered categorical"
              } else {
                y2.vlevel <- "Unordered categorical"
              }
            }
          }

          TStable <- self$results$tblTS

          # Time Series table ----
          TStable$setRow(rowNo=1,
                         values=list(
                           var = y1,
                           vlevel = y1.vlevel,
                           N   = NROW(na.omit(y1vec)),
                           na  = sum(is.na(y1vec)),
                           uni_obs = length(unique(na.omit(y1vec))),
                           discretised = v1_discretised)
          )
          TStable$setRow(rowNo=2,
                         values=list(
                           var = y2,
                           vlevel = y2.vlevel,
                           N   = NROW(na.omit(y2vec)),
                           na  = sum(is.na(y2vec)),
                           uni_obs = length(unique(na.omit(y2vec))),
                           discretised = v2_discretised)
          )

          # tsData <- data.frame(t  = seq_along(data[[y1]]),
          #                      y1 = data[[y1]],
          #                      y2 = data[[y2]],
          #                      label = rep(y1,length(data[[y1]]))
          # )

          emLag <- self$options$emLag
          emDim <- self$options$emDim
          if(emDim<=0){emDim<-1}

          emRad <- NULL
          if(self$options$fixed%in%"RAD"){
            emRad <- self$options$fixRAD
            #if(emRad<=0){emRad<-emRad+.Machine$double.eps}
          }
          if(self$options$fixed%in%"RR"){
            emRad <- crqa_radius(y1 = y1vec, y2 = y2vec, emLag = emLag, emDim = emDim, targetValue = self$options$fixRR)$Radius
          }
          if(self$options$fixed%in%"NO"){
            RM <- rp(y1 = y1vec, y2 = y2vec, emDim = emDim, emLag = emLag ,method = as.character(self$options$norm))
          } else {
            RM <- rp(y1 = y1vec, y2 = y2vec, emDim = emDim, emLag = emLag, emRad = emRad ,method = as.character(self$options$norm))
          }

          crpImage <- self$results$crpplot
          crpImage$setState(RM)

          if(!is.null(emRad)){

          if(self$options$DLmax<=0){
            DLmax <- length(Matrix::diag(RM))-1
          }
          if(self$options$VLmax<=0){
            VLmax <- length(Matrix::diag(RM))-1
          }
          if(self$options$HLmax<=0){
            HLmax <- length(Matrix::diag(RM))-1
          }

          crqa_all <- crqa_rp(RM = RM, emRad = emRad,
                              DLmin = self$options$DLmin, DLmax = DLmax,
                              VLmin = self$options$VLmin, VLmax = VLmax,
                              HLmin = self$options$HLmin, HLmax = HLmax,
                              theiler = self$options$theiler,
                              matrices = TRUE)
          crqa_out <- crqa_all$crqaMeasures

          RPtable <- self$results$tblRP

          RPtable$setRow(rowNo=1,
                         values = list(
                           emRad = emRad,
                           RP = crqa_out$RP_N,
                           RN = rp_size(RM, AUTO=FALSE),
                           RR = crqa_out$RR,
                           SING = crqa_out$SING_N,
                           DIV = crqa_out$DIV_dl,
                           REP = crqa_out$REP_av,
                           ANI = crqa_out$ANI)
          )

          RQAtable <- self$results$tblCRQA

          RQAtable$setRow(rowNo=1,
                          values = list(
                            LineType = "Diagonal",
                            NLines = crqa_out$N_dl,
                            Npoints = crqa_out$N_dlp,
                            Measure = "Determinism",
                            PoL = crqa_out$DET,
                            MEAN = crqa_out$MEAN_dl,
                            MAX = crqa_out$MAX_dl,
                            ENT = crqa_out$ENT_dl,
                            relENT = crqa_out$ENTrel_dl,
                            CoV    = crqa_out$CoV_dl)
          )

          RQAtable$setRow(rowNo=2,
                          values = list(
                            LineType = "Vertical",
                            NLines = crqa_out$N_vl,
                            Npoints = crqa_out$N_vlp,
                            Measure = "V Laminarity",
                            PoL = crqa_out$LAM_vl,
                            MEAN = crqa_out$TT_vl,
                            MAX = crqa_out$MAX_vl,
                            ENT = crqa_out$ENT_vl,
                            relENT = crqa_out$ENTrel_vl,
                            CoV    = crqa_out$CoV_vl)
          )

          RQAtable$setRow(rowNo=3,
                          values = list(
                            LineType = "Horizontal",
                            NLines = crqa_out$N_hl,
                            Npoints = crqa_out$N_hlp,
                            Measure = "H Laminarity",
                            PoL = crqa_out$LAM_hl,
                            MEAN = crqa_out$TT_hl,
                            MAX = crqa_out$MAX_hl,
                            ENT = crqa_out$ENT_hl,
                            relENT = crqa_out$ENTrel_hl,
                            CoV    = crqa_out$CoV_hl)
          )

          dpImage <- self$results$DPplot

          if(self$options$plotDP==FALSE){

            dpImage$setVisible(visible=FALSE)

          } else {

            dpImage$setVisible(visible=TRUE)
            dpImage$setState(RM)

          }

          }

        },

        .crpplot=function(crpImage, ...) {

          ready <- TRUE
          crm <- crpImage$state

           if(any(is.null(self$options$y1),is.null(self$options$y2))){
             ready <- FALSE
           }

          if(ready){

            crm <- crpImage$state

            #   if(plyr::is.discrete(df$y1)){
            RadiusRRbar <- FALSE
            if(self$options$fixed%in%"NO"){
              RadiusRRbar <- TRUE
            }

             crppl <-  rp_plot(crm, plotDimensions = TRUE, xlab = self$options$y1, ylab = self$options$y2, radiusValue = attributes(crm)$emRad, plotRadiusRRbar = RadiusRRbar)

            #crppl <- image(as.matrix(crm))

            print(crppl)
            TRUE
          }
        },

        .DPplot=function(dpImage, ...) {

          ready <- TRUE
          dp <- dpImage$state

          if(any(is.null(self$options$y1),is.null(self$options$y2),self$options$plotDP==FALSE)){
            ready <- FALSE
          }

          if(ready){

            dp <- dpImage$state

            dppl <-  crqa_diagPofile(dp,diagWin = self$options$diagWin,  xname = self$options$y1, yname = self$options$y2)

            print(dppl)
            TRUE
          }
        }

      )
    )
}
