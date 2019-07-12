function cpdf_arg_check(tbid, data, x0, a)

assert(isa(data.fhan, 'function_handle'), ...
  '%s: input for ''F'' is not a function handle', tbid);
assert(isa(data.dfhan, 'function_handle'), ...
  '%s: input for ''DF'' is not a function handle', tbid);
assert(isnumeric(x0), '%s: input for ''x0'' is not numeric', tbid);
assert(isnumeric(a), '%s: input for ''a'' is not numeric', tbid);

end
