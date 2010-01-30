\name{logistic.interaction}
\alias{logistic.interaction}
\title{Interaction logistic adaptive index model}
\description{Estimate adpative index model for binary outcomes in the context of logistic regression. The resulting index characterizes the interaction between the covariates and treatment.}

\usage{
logistic.interaction(x, trt, y, nsteps=8, mincut=.1, backfit=F, maxnumcut=1, dirp=0, weight=1)
}

\arguments{
  \item{x}{n by p matrix. The covariate matrix}
  \item{trt}{n vector. The treatment indicator}
  \item{y}{n 0/1 vector. The binary response variable}
  \item{nsteps}{the maximum number of binary rules to be included in the index}
  \item{mincut}{The minimum cutting proportion for the binary rule at either end. It typically is between 0 and 0.2.}
  \item{backfit}{T/F. Whether the existing split points are adjusted after including a new binary rule}
  \item{maxnumcut}{The maximum number of binary splits per predictor}
  \item{dirp}{p vector. The given direction of the binary split for each of the p predictors. 0 represents "no pre-given direction"; 1 represents "(x>cut)"; -1 represents "(x<cut)". Alternatively, "dirp=0" represents that there is no pre-given direction for any of the predictor.}
  \item{weight}{a positive value. The weight given to responses. "weight=0" means that all observations are equally weighted.}
}    

\details{
  \code{logistic.interaction} sequentially estimates a sequence of adaptive index models with up to "nsteps" terms for binary outcomes. The aglorithm seeks the index having the strong interaction with the treatment in the logistic regression model. The appropriate number of binary rules can be selected via K-fold cross-validation (\code{cv.logistic.interaction}). 
}

\value{
   \code{logistic.interaction} returns \code{maxsc}, which is the observed score test statistics for the index*treatment interaction in the fitted model and \code{res}, which is a list with components
\item{jmaa}{number of predictors}
\item{cutp}{split points for the binary rules}
\item{maxdir}{direction of split: 1 represents "(x>cut)" and -1 represents "(x<cut)"}
\item{maxsc}{observed score test statistics for the interaction}
}

\references{Lu Tian and Robert Tibshirani (2010) "Adaptive index models for marker-based risk stratification", Tech Report, available at http://www-stat.stanford.edu/~tibs/AIM.} 


\author{ Lu Tian and Robert Tibshirani  }

\examples{
## generate data
set.seed(1)

n=400
p=10
x=matrix(rnorm(n*p), n, p)
z=(x[,1]<0.2)+(x[,5]>0.2)
trt=rbinom(n,1, 0.5)
beta=1
prb=1/(1+exp(trt-beta*trt*z-0.5))
y=rbinom(n,1,prb)

## fit the interaction logistic AIM
a=logistic.interaction(x, trt, y, nsteps=10)
 
## examine the model sequence 
print(a)

## compute the index based on the 2nd model of the sequence using data x 
z.prd=index.prediction(a$res[[2]],x)

## compute the index based on the 2nd model of the sequence using new data xx, and compare the result with the true index
nn=10
xx=matrix(rnorm(nn*p), nn, p)
zz=(xx[,1]<0.2)+(xx[,5]>0.2)
zz.prd=index.prediction(a$res[[2]],xx) 
cbind(zz, zz.prd)
}

