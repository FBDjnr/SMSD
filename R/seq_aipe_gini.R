#' seq_aipe_gini
#'
#' @description Sequential approach to Accuracy in Parameter
#'  Estimation for Effect Sizes
#' (AIPE): Gini Index
#'
#' @param alpha he significance level., default is 0.05.
#' @param omega omega
#' @param data The data for which to calculate the gini index.
#' @param pilot Should a pilot sample be generated.
#' @param m0 The initial sample size.
#'
#' @return The current sample size, the current gini coefficient, an
#' indicator of if the criterion is satisfied, and the confidence interval.
#'
#' @author Ken Kelley \email{KKelley@@nd.edu},
#' Francis Bilson Darku \email{FBilsonD@nd.edu},
#' Bhargab Chattopadhyay \email{Bhargab@iiitvadodara.ac.in}
#'
#' @export seq_aipe_gini
#'
#' @examples
#' pilot_ss <- seq_aipe_gini(alpha=0.05, omega=0.2, pilot=TRUE)
#' SLS <- rexp(pilot_ss, rate=0.05)
#' seq_aipe_gini(alpha=0.05, omega=0.2,data = SLS)
#'
seq_aipe_gini <- function(alpha = 0.05, omega, data = NULL,
                          pilot = FALSE, m0 = 4){

  if (missing(alpha) && missing(omega)){
    stop("You must specify \'omega\' and \'alpha\'.")
  }

  if (!is.null(data) && !is.data.frame(data) &&
      !is.matrix(data) && !is.vector(data)){
    stop("The argument 'data' must be a data.frame or matrix with one column")
  }

  if (dim(data)[2] != 1 && !is.null(data) && !is.vector(data)){
    stop("The argument 'data' must have only one column,
         or be 'NULL' for pilot = TRUE")
  }
  if (alpha <= 0 || alpha >= 1){
    stop("The argument")
  }

  if (pilot == FALSE) {
    stop <- FALSE
    n <- length(data)
    GI <- gini_index(data)
    V2n <- V2_gini_index(data)
    Criterion <- ceiling((2*stats::qnorm(1 - alpha/2)/omega)^2 * (V2n + 1/n))

    if (n >= Criterion){
      Stop <- TRUE
    } else if (n < Criterion){
      Stop <- FALSE
    }
    lci <- GI - stats::qnorm(1 - alpha/2)*sqrt(V2n/n)
    uci <- GI + stats::qnorm(1 - alpha/2)*sqrt(V2n/n)
    ci <- c(lci, uci)
    if (Stop == FALSE){
      cat("The stopping rule has not yet been met;
            sample size is not large enough")
      Outcome <- list("Current.n" = n, "Current.gini" = GI,
                      "Is.Satisfied?" = Stop)
    }

    if (Stop == TRUE){
      cat("The stopping rule has been met; sample size is large enough.")
      Outcome <- list("Current.n" = n, "Current.gini" = GI,
                      "Is.Satisfied?" = Stop,
                      "Confidence Interval"= ci)
    }

  }
  if(pilot==TRUE) {
    if(m0 < 4) stop("The value of 'm0' must be 4 or greater.")
    Outcome <- max(m0, ceiling(2*stats::qnorm(1 - alpha/2)/omega))
  }
  return(Outcome)
}
