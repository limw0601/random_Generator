function data = cpdf_get_settings(prob, tbid, data)
% Merge user-supplied toolbox settings with default values.
%
% DATA = CPDF_GET_SETTINGS(PROB, TBID, DATA)
%
% PROB - Continuation problem structure.
% TBID - Toolbox instance identifier.
% DATA - Toolbox data strcture.


defaults.NTST = 10; % Number of mesh intervals
defaults.NCOL = 4;  % Degree of interpolating polynomials
if ~isfield(data, 'cpdf')
  data.cpdf = [];
end
data.cpdf = coco_merge(defaults, coco_merge(data.cpdf, ...
  coco_get(prob, tbid))); % Defaults < Stored < User-supplied
NTST = data.cpdf.NTST;
assert(numel(NTST)==1 && isnumeric(NTST) && mod(NTST,1)==0, ...
  '%s: input for option ''NTST'' is not an integer', tbid);
NCOL = data.cpdf.NCOL;
assert(numel(NCOL)==1 && isnumeric(NCOL) && mod(NCOL,1)==0, ...
  '%s: input for option ''NCOL'' is not an integer', tbid);

end
