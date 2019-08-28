# Continuation based generator for random numbers
A constructor for generating random samples following an arbitrary given probability density function

Given a probability density function (pdf) f(x), the corresponding cumulative density function (cdf) F(x) is varied from zero to one. Given a set of random numbers {F_i} drawn from uniform distribution in [0,1], the corresponding {x_i} such that F(x_i)=F_i follows the distribution characterized by f(x).

Based on the above observation, we use continuation to find {x_i}. Note $F(x)$ is a monotonic incresing function of x. Suppose x\in[a,b], continuation is started from x=a until x=b. In such continuation, F(x) is incresing and event handler is used to identify F_i. The corresponding x_i is the desired random number.

Continuation method is implemented in COCO, a MATLAB-based toolbox for numerical continuation. Please refer https://sourceforge.net/projects/cocotools/ for the info and installation of COCO. To use the code in this repository, you need first install COCO and then put the randomGenerator folder in this repository to ...\coco. If you have any questions regarding the use of the code, you may reach me at mingwul2@illinois.edu.

For citation, please cite the following two papers.

## References
[1] Dankowicz, H., & Schilder, F. (2013). Recipes for continuation (Vol. 11). SIAM.

[2] Li, M., & Dankowicz, H. (2018). Staged Construction of Adjoints for Constrained Optimization of Integro-Differential Boundary-Value Problems. SIAM Journal on Applied Dynamical Systems, 17(2), 1117-1151.


