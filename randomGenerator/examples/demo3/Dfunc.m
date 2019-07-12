function y = Dfunc(x)

global a b

y = -(2*a*cos(b/2 - x/2).*sin(b/2 - x/2)*(a^2 - 1))./(pi*((a - 1)^2 + 4*a*sin(b/2 - x/2).^2).^2);

end