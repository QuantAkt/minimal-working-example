# This script provides a minimal working example for approximation of empirical
# measures/designs with kernel based on MMD minimisation. It is accompanying the talk
# "Nicht nur Glückssache" by Guido Grützner, held on DAV/DGVFM Herbsttagung,
# November 16th 2021.

# This script may only be used for academic/pedagogical purposes.

# WARNING: The script has not been tested!

# The script generates a large sample and then selects a small design
# from the large sample based on the Maximum Mean Discrepancy given by a Kernel.
# The optimisation/search is done by Trial&Error, i.e. uniform subsampling without
# replacement.

# Convention for scenarios/paths:
# Each column is a path/realisation/scenario/random point
# Accordingly the risk factors define the rows


rm(list = ls())

# The kernel function contains two examples of possible kernels.
# 1) The exponential kernel discussed in the talk
# 2) A matern kernel of the \nu=1/2 p=0 variety in the terminology of
#    https://en.wikipedia.org/wiki/Mat%C3%A9rn_covariance_function
# Set appropriate comments to select the Kernel you want.
#-------------------------------------------------------------------------------
fun_kernel = function(xvec,yvec){

  # Input:
  # xvec, yvec: two designs with row/col-convention as above

  # # Exponential, just exp of the scalar products of the random vectors
  # return( exp( t(xvec / 4) %*% (yvec / 4) ) )

  # Matern,
  # calc distance between all pairs of vectors
  nx = dim(xvec)[2]
  ny = dim(yvec)[2]
  r = matrix(0, nx, ny)
  for(ipt in seq.int(nx)){
    r[ipt,] = sqrt(.colSums((xvec[,ipt] - yvec)^2, dim(yvec)[1], ny))
  }
  return(exp(-r))
}


# Main
#-------------------------------------------------------------------------------

# Parameters

# Size of designs
nlarge = 5000
nsmall = 250
# number of risk factors
nrisk = 2 * 30
# number of trials for Trial & Error
ntrial = 1000


# create large design
largedes = rnorm(nrisk * nlarge)
dim(largedes)=c(nrisk,nlarge)

# calculate kernel matrix for the large design
K = fun_kernel(largedes, largedes)
# square norm of large sample, see formulas on slide 14 "Kernel-Trick"
sqnorm_large = sum(K) / nlarge^2

# Trial and error selection loop
bestmmd = Inf
for(itrial in seq.int(ntrial)){
  # choose small design from large, uniform random without replacement
  idx = sample.int( nlarge, nsmall, replace = FALSE)
  # calculate its distance from large
  sqnorm_small = sum(K[idx,idx]) / nsmall^2
  ipro = sum(K[,idx]) / nsmall / nlarge
  curmmd = sqrt(sqnorm_large - 2 * ipro + sqnorm_small)
  # check for new record and remember in case
  if(curmmd < bestmmd){
    bestmmd = curmmd
    besttrial = idx
  }
}

selected_design = largedes[,besttrial]




