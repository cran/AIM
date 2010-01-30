\name{cv.lm.interaction}
\alias{cv.lm.interaction}
\title{Cross-validation in interaction linear AIM}
\description{Cross-validation for selecting the number of binary rules in the interaction AIM with continuous outcomes}

\usage{
cv.lm.interaction(x, trt, y, K.cv=5, num.replicate=1, nsteps, mincut=0.1, backfit=F, maxnumcut=1, dirp=0)
}

\arguments{
  \item{x}{n by p matrix. The covariate matrix}
  \item{trt}{n vector. The treatment indicator}
  \item{y}{n vector. The continuous response variable}
  \item{K.cv}{K.cv-fold cross validation}
  \item{num.replicate}{number of independent replications of K-fold cross validations}
  \item{nsteps}{the maximum number of binary rules to be included in the index}
  \item{mincut}{the minimum cutting proportion for the binary rule at either end. It typically is between 0 and 0.2.}
  \item{backfit}{T/F. Whether the existing split points are adjusted after including a new binary rule}
  \item{maxnumcut}{the maximum number of binary splits per predictor}
  \item{dirp}{p vector. The given direction of the binary split for each of the p predictors. 0 represents "no pre-given direction"; 1 represents "(x>cut)"; -1 represents "(x<cut)". Alternatively, "dirp=0" represents that there is no pre-given direction for any of the predictor.}

}    

\details{
  \code{cv.lm.interaction} implements the K-fold cross-validation for interaction linear AIM. It estimates the score test statistics in the test set for testing the treatment*index interaction. It also provides the pre-validated fits for each observation and pre-validated score test statistics. The output can be used to select the optimal number of binary rules.}


\value{
\code{cv.lm.interaction} returns 
\item{kmax}{the optimal number of binary rules based the cross-validation}
\item{meanscore}{nsteps-vector. The cross-validated score test statistics (significant at 0.05, if greater than 1.96) for the treatment*index interaction}
\item{pvfit.score}{nsteps-vector. The pre-validated score test statistics (significant at 0.05, if greater than 1.96) for the treatment*index interaction.}
\item{preval}{nsteps by n matrix. Prevalidated fits for individual observation}
}


\section{References}{
L Tian and R Tibshirani
Adaptive index models for marker-based risk stratification,
Tech Report, available at http://www-stat.stanford.edu/~tibs/AIM. 

R Tibshirani and B Efron, Pre-validation and inference in microarrays,
Statist. Appl. Genet. Mol. Biol., 1:1-18, 2002.
}

\author{ Lu Tian and Robert Tibshirani  }

\examples{
## generate data
set.seed(1)

n=400
p=10
x=matrix(rnorm(n*p), n, p)
z=(x[,1]<0.2)+(x[,5]>0.2)
trt=rbinom(n, 1, 0.5)
beta=1
y=trt+beta*trt*z+rnorm(n)



## cross-validate the interaction linear AIM
a=cv.lm.interaction(x, trt, y, nsteps=10, K.cv=5, num.replicate=3)
 
## examine the score test statistics in the test set 
par(mfrow=c(1,2))
plot(a$meanscore, type="l")
plot(a$pvfit.score, type="l")


## construct the index with the optimal number of binary rules 
k.opt=a$kmax
a=lm.interaction(x, y, trt, nsteps=k.opt)
print(a)
}

