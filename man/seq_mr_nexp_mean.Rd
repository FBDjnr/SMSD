% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/seq_mr_nexp_mean.R
\name{seq_mr_nexp_mean}
\alias{seq_mr_nexp_mean}
\title{seq_mr_nexp_mean}
\usage{
seq_mr_nexp_mean(
  data,
  A,
  c,
  k,
  t,
  pilot = FALSE,
  verbose = FALSE,
  na.rm = TRUE
)
}
\arguments{
\item{data}{The data for which to calculate the minimum risk point.}

\item{A}{The loss function constant.}

\item{c}{The cost of unit sample.}

\item{k}{Loss function index 1.}

\item{t}{Loss function index 2.}

\item{pilot}{Should a pilot sample be generated. True/False value.
default value is \code{FALSE}.}

\item{verbose}{Should the criterion be printed. Default is \code{FALSE}.}

\item{na.rm}{This parameter controls whether NA values are removed from
the data prior to calculation. Default is \code{TRUE}}
}
\value{
The calculated risk, the sample size, mean, standard deviation,
 and
an indicator of if the criterion was satisfied.
}
\description{
Purely Sequential approach to Get Minimum Risk Point Estimation
 for negative exponential random variables
}
\examples{
pilot_ss <- seq_mr_nexp_mean(A=500, c=0.01, k=1, t=2, pilot=TRUE)
SLS <- rexp(pilot_ss, rate=1)
seq_mr_nexp_mean(data=SLS, A=500, c=0.01, k=1, t=2, pilot=FALSE)
}
\references{
Mukhopadhyay, N., \& de Silva, B. M. (2009). \emph{Sequential Methods and Their Applications}. New York: CRC Press.
}
\author{
Bhargab Chattopadhyay \email{Bhargab@iiitvadodara.ac.in},
Neetu Shah \email{201451015@iiitvadodara.ac.in}, Ken Kelley \email{kkelley@nd.edu}
}
