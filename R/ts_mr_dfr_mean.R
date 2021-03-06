#' ts_mr_dfr_mean
#'
#' @description Two Stage approach to Get Minimum Risk Point
#'  Estimation for distribution free random variables with known variance
#'
#'
#' @param data The data for which to calculate the confidence interval.
#' A numeric vector.
#' @param A The loss function constant.
#' @param c The cost of unit sample.
#' @param lowerlim The lower bound for the variance.
#' @param pilot Should a pilot sample be generated. True/False value.
#' default value is \code{FALSE}.
#' @param verbose Should the criterion be printed. Default is \code{FALSE}.
#' @param na.rm This parameter controls whether NA values are removed from
#' the data prior to calculation. Default is \code{TRUE}.
#'
#' @return The calculated risk, the sample size, mean, standard deviation, and
#' an indicator of if the criterion was satisfied.
#'
#' @author Bhargab Chattopadhyay \email{Bhargab@iiitvadodara.ac.in},
#' Neetu Shah \email{201451015@iiitvadodara.ac.in}, Ken Kelley \email{kkelley@nd.edu}
#'
#' @references
#' Mukhopadhyay, N., \& de Silva, B. M. (2009). \emph{Sequential Methods and Their Applications}. New York: CRC Press.
#'
#' @export ts_mr_dfr_mean
#'
#' @examples
#' pilot_ss <- ts_mr_dfr_mean(A=100, c=4, pilot=TRUE)
#' \dontrun{
#' SLS <- rnorm(pilot_ss, mean=0, sd=1)
#' }
#' SLS <- rnorm(100, mean=0, sd=1)
#' ts_mr_dfr_mean(data=SLS, A=100, c=4, lowerlim=2, pilot=FALSE)
ts_mr_dfr_mean <- function(data, A, c, lowerlim , pilot=FALSE,
                           verbose=FALSE, na.rm=TRUE)
{

  if(!missing(A)){
    if(A<=0) {
      stop("A should be a non-zero positive value")
    }
  }

  if(missing(A)){
    stop("You must specify \'A\'")
  }

  if(!missing(c)){
    if(c<=0){
      stop("c should be a non-zero positive value")
    }
  }

  if(missing(c)){
    stop("You must specify \'c\'")
  }

  if(pilot==FALSE){
    if(!missing(lowerlim)) {
      if(lowerlim<=0){
        stop("c should be a non-zero positive value")
      }
    }

    if(missing(lowerlim)){
      stop("You must specify \'lower bound\'")
    }

    if (!is.data.frame(data) && !is.matrix(data) && !is.vector(data)){
      stop("The argument 'data' must be a data.frame
           or matrix with one column")
    }

    if (dim(data)[2] != 1 && !is.null(data) && !is.vector(data)){
      stop("The argument 'data' must have only one column,
           or be 'NULL' for pilot = TRUE")
    }


    if(is.data.frame(data)){
      data <- as.vector(data)
    }
    if(na.rm){
      data <-  data[!is.na( data)]
    }

    n <- max(length(data), ceiling(sqrt((A/c)*lowerlim)))

    optimal_N <- max(n, ceiling(sqrt((A/c)*stats::var(data))))

    Rk<-(1/n)*A*stats::var(data)+(c*n)

    if(verbose==FALSE){
      Outcome <- rbind(list(Risk=Rk, N=length(data),
                            mean=mean(data),
                            "Is.Satisfied?"=(n >= optimal_N)))
    }
    if(verbose==TRUE){
      Outcome <- rbind(list(Risk=Rk, N=length(data),
                            mean=mean(data), Criterion=optimal_N,
                            Is.Satisfied=n >= optimal_N))
    }
    if((n >= optimal_N)==FALSE){
      print(Outcome)
    }
    while((length(data) >= optimal_N)==FALSE){
      cat(optimal_N-length(data)," more are needed ")
      obs <- as.integer(strsplit(readline(), " ")[[1]])
      data <- c(data,obs)
      if(length(data)==optimal_N){
        Rk<-(1/n)*A*stats::var(data)+(c*n)
        Outcome <- rbind(list(Risk=Rk, N=length(data), mean=mean(data),
                              Stage=2))
      }else if(length(data)> optimal_N){
        Rk<-(1/n)*A*stats::var(data)+(c*n)
        Outcome <- rbind(list(Risk=Rk, N=length(data), mean=mean(data),
                              Stage=2))
      }
    }
  }

  if(pilot==TRUE)  {
    Outcome <- c(pilot_ss=max(4, ceiling((A/c)^(1/2))))
  }

  return(Outcome)
}
