% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calculate_c.R
\name{calculate_c}
\alias{calculate_c}
\title{Calculates exact value of C}
\usage{
calculate_c(var, alpha, d)
}
\arguments{
\item{var}{The population variance.}

\item{alpha}{The chosen Type I error rate (complement of the confidence coefficient).}

\item{d}{Half of the confidence interval width. That is the confidence
interval is 2d wide.}
}
\value{
The optimal sample size $C$, the ``optimal fixed sample size required."
}
\description{
This function replicates the function in Mukhopadhyay \& de Silva (chapter 6, section 2) for the exact sample size given the variance, significance level, and confidence interval width for a fixed width confidence interval for the population mean of normal random variables.
}
\examples{
calculate_c(var = 1, alpha = 0.05, d = 0.75)


}
\references{
Mukhopadhyay, N., \& de Silva, B. M. (2009). \emph{Sequential Methods and Their Applications}. New York: CRC Press.
}
