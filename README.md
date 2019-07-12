# Generator for random numbers
A constructor for generating random samples following an arbitrary given probability density function

Given a probability density function (pdf) f(x), the corresponding cumulative density function (cdf) F(x) is varied from zero to one. Given a set of random numbers {F_i} drawn from uniform distribution in [0,1], the corresponding {x_i} such that F(x_i)=F_i follows the distribution characterized by f(x).

Based on the above observation, we use continuation to find {x_i}. Note $F(x)$ is a monotonic incresing function of x. Suppose x\in[a,b], continuation is started from x=a until x=b. In such continuation, F(x) is incresing and event handler is used to identify F_i. The corresponding x_i is the desired random number.
