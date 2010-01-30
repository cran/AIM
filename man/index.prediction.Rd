\name{index.prediction}
\alias{index.prediction}
\title{Predict index based on fitted AIM}
\description{Compute the index for new observations using output from \code{lm.main}, \code{lm.interaction}, \code{logistic.main}, \code{logistic.interaction}, \code{cox.main} and \code{cox.interaction}.}

\usage{
index.prediction(res, x)
}

\arguments{  
  \item{res}{list "res" term from the outputs in \code{lm.main}, \code{lm.interaction}, \code{logistic.main}, \code{logistic.interaction}, \code{cox.main} and \code{cox.interaction}}
  \item{x}{New covariate matrix}
}    

\details{
  \code{index.prediction} computes the new index for given observations based on the fitted AIM
}

\value{
   \code{index.prediction} returns \code{score} which is the index for new observations with covariate matrix "x".
}

\references{Lu Tian and Robert Tibshirani (2010) Adaptive index models for marker-based risk stratification. Tech Report. Available at http://www-stat.stanford.edu/~tibs/AIM.} 


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

## fit the interaction logistic AIM model 
a=logistic.interaction(x, trt, y, nsteps=10)
 
## examine the model sequence 
print(a)

## compute the index based on the 2nd model of the sequence, using data x 
z.prd=index.prediction(a$res[[2]],x)

## compute the index based on the 2nd model of the sequence using new data xx, and compare the result with the true index
nn=10
xx=matrix(rnorm(nn*p), nn, p)
zz=(xx[,1]<0.2)+(xx[,5]>0.2)
zz.prd=index.prediction(a$res[[2]],xx) 
cbind(zz, zz.prd)
}

