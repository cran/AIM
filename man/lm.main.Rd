\name{lm.main}
\alias{lm.main}
\title{Main effect linear adaptive index model}
\description{Estimate adpative index model for continuous outcomes in the context of linear regression. The resulting index characterizes the main covariate effect on the continuous response.}

\usage{
lm.main(x, y, nsteps=8, backfit=F, mincut=.1, maxnumcut=1, dirp=0)
}

\arguments{
  \item{x}{n by p matrix. The covariate matrix}
  \item{y}{n vector. The continuous response variable}
  \item{nsteps}{the maximum number of binary rules to be included in the index}
  \item{backfit}{T/F. Whether the existing split points are adjusted after including a new binary rule}
  \item{mincut}{The minimum cutting proportion for the binary rule at either end. It typically is between 0 and 0.2.}
  \item{maxnumcut}{The maximum number of binary splits per predictor}
  \item{dirp}{p vector. The given direction of the binary split for each of the p predictors. 0 represents "no pre-given direction"; 1 represents "(x>cut)"; -1 represents "(x<cut)". Alternatively, "dirp=0" represents that there is no pre-given direction for any of the predictor.}

}    

\details{
  \code{lm.main} sequentially estimates a sequence of adaptive index models with up to "nsteps" terms for continuous outcomes. The appropriate number of binary rules can be selected via K-fold cross-validation(\code{cv.lm.main}). 
}

\value{
   \code{lm.main} returns \code{maxsc}, which is the score test statistics achieved in the fitted model and \code{res}, which is a list with components
\item{jmaa}{number of predictors}
\item{cutp}{split points for the binary rules}
\item{maxdir}{direction of split: 1 represents "(x>cut)" and -1 represents "(x<cut)"}
\item{maxsc}{observed score test statistics for the main effect}
}


\references{Lu Tian and Robert Tibshirani (2010) "Adaptive index models for marker-based risk stratification", Tech Report, available at http://www-stat.stanford.edu/~tibs/AIM.} 


\author{ Lu Tian and Rob Tibshirani  }

\examples{
## generate data
set.seed(1)

n=500
p=20
x=matrix(rnorm(n*p), n, p)
z=(x[,1]<0.2)+(x[,5]>0.2)
beta=1
y=beta*z+rnorm(n)


## fit the main effects linear AIM
a=lm.main(x, y, nsteps=10)
 
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

