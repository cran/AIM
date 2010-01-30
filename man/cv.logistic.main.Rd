\name{cv.logistic.main}
\alias{cv.logistic.main}
\title{Cross-validation in the main effect logistic AIM}
\description{Cross-validation for selecting the number of binary rules in the main effect AIM with binary outcomes}

\usage{
cv.logistic.main(x, y, K.cv=5, num.replicate=1, nsteps, mincut=0.1, backfit=F, maxnumcut=1, dirp=0, weight=1)
}

\arguments{
  \item{x}{n by p matrix. The covariate matrix}
  \item{y}{n 0/1 vector. The binary response variable}
  \item{K.cv}{K.cv-fold cross validation}
  \item{num.replicate}{number of independent replications of K-fold cross validations.}
  \item{nsteps}{The maximum number of binary rules to be included in the index}
  \item{mincut}{The minimum cutting proportion for the binary rule at either end. It typically is between 0 and 0.2.}
  \item{backfit}{T/F. Whether the existing split points are adjusted after including a new binary rule}
  \item{maxnumcut}{The maximum number of binary splits per predictor}
  \item{dirp}{p vector. The given direction of the binary split for each of the p predictors. 0 represents "no pre-given direction"; 1 represents "(x>cut)"; -1 represents "(x<cut)". Alternatively, "dirp=0" represents that there is no pre-given direction for any of the predictor.}
  \item{weight}{a positive value. The weight given to responses. "weight=0" means that all observations are equally weighted.}
}    

\details{
  \code{cv.logistic.main} implements the K-fold cross-validation for the main effect logistic AIM. It estimates the score test statistics in the test set for testing the association between the binary outcome and index constructed using training data. It also provides pre-validated fits for each observation and the pre-validated score test statistic. The output can be used to select the optimal number of binary rules.}


\value{
\code{cv.lm.main} returns 
\item{kmax}{the optimal number of binary rules based the cross-validation}
\item{meanscore}{nsteps-vector. The cross-validated score test statistics (significant at 0.05, if greater than 1.96) for the association between survival time and index.}
\item{pvfit.score}{nsteps-vector. The pre-validated score test statistics (significant at 0.05, if greater than 1.96) for the association between survival time and index.}
\item{preval}{nsteps by n matrix. Pre-validated fits for individual observation}
}



\section{References}{
L Tian and R Tibshirani
Adaptive index models for marker-based risk stratification,
Tech Report, available at http://www-stat.stanford.edu/~tibs/AIM. 

R Tibshirani and B Efron, Pre-validation and inference in microarrays,
Statist. Appl. Genet. Mol. Biol., 1:1-18, 2002.
}


\author{Lu Tian and Robert Tibshirani  }

\examples{
## generate data
set.seed(1)
n=500
p=20

x=matrix(rnorm(n*p), n, p)
z=(x[,1]<0.2)+(x[,5]>0.2)
beta=1
prb=1/(1+exp(-beta*z))
y=rbinom(n,1,prb)


## cross-validate the logistic main effects AIM
a=cv.logistic.main(x, y, nsteps=10, K.cv=5, num.replicate=3)
 
## examine the score test statistics in the test set 
par(mfrow=c(1,2))
plot(a$meanscore, type="l")
plot(a$pvfit.score, type="l")


## construct the index with the optimal number of binary rules 
k.opt=a$kmax
a=logistic.main(x, y, nsteps=k.opt)
print(a)

}

