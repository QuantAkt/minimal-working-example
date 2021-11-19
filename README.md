# Description
This script provides a minimal working example for the approximation of empirical
measures/designs with kernels based on MMD minimisation. It is accompanying the talk
"Nicht nur Glückssache" by Guido Grützner, held on DAV/DGVFM Herbsttagung,
November 16th 2021.

The script generates a large sample and then selects a small design
from the large sample based on the Maximum Mean Discrepancy given by a Kernel.
The optimisation/search is done by Trial&Error, i.e. uniform subsampling without
replacement.

The kernel function `fun_kernel` contains two examples of possible kernels.
1) The exponential kernel discussed in the talk
2) A matern kernel of the &nu; =1/2 p=0 variety in the terminology of
[wikipedia](https://en.wikipedia.org/wiki/Mat%C3%A9rn_covariance_function)

Set/Unset appropriate comments in `fun_kernel` to select the kernel you want.

# More details 
Can be found in the original presentation (in German) or the English translation.

# WARNING: The script has not been tested!
