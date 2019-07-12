function y = func(x)

global a b

y = (1-a^2)./((1-a)^2+4*a*(sin((x-b)/2)).^2)/(2*pi);

end