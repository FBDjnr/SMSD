% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/seq_fwd_nexp_mean.R
\name{seq_fwd_nexp_mean}
\alias{seq_fwd_nexp_mean}
\title{seq_fwd_nexp_mean}
\usage{
seq_fwd_nexp_mean(
  data,
  d,
  alpha,
  gamma,
  pilot = FALSE,
  verbose = FALSE,
  na.rm = TRUE
)
}
\arguments{
\item{data}{The data for which to calculate the confidence interval.
A numeric vector.}

\item{d}{Half of the confidence interval width, must be a non-zero positive
value.}

\item{alpha}{The significance level. A value between 0 and 1.}

\item{gamma}{gamma}

\item{pilot}{Should a pilot sample be generated. TRUE/FALSE value.
default value is \code{FALSE}.}

\item{verbose}{Should the criterion be printed. Default is \code{FALSE}.}

\item{na.rm}{This parameter controls whether NA values are removed from
the data prior to calculation. Default is \code{TRUE}.}
}
\value{
The calculated confidence interval, the sample size, data mean,
and an indicator of if the criterion was satisfied.
}
\description{
Purely Sequential approach to Get Fixed Width Confidence Interval
for the mean of negative exponential random variables.
}
\examples{
pilot_ss <- seq_fwd_nexp_mean(alpha=0.05, d=0.2, gamma=1, pilot=TRUE)
SLS <- rexp(pilot_ss, rate=1)
seq_fwd_nexp_mean(data=SLS, d=0.2, alpha=0.05, pilot=FALSE)
}
\references{
Mukhopadhyay, N., \& de Silva, Basil M. (2009). \emph{Sequential Methods and Their Applications}. New York: CRC Press.
}
\author{
Bhargab Chattopadhyay \email{Bhargab@iiitvadodara.ac.in},
Neetu Shah \email{201451015@iiitvadodara.ac.in}, Ken Kelley \email{kkelley@nd.edu}
}
