function [sol data] = cpdf_read_solution(oid, run, lab)
% Extract data and chart structures associated with 'cpdf' toolbox instance
% identifier from solution file and construct solution structure.
%
% [SOL DATA] = CPDF_READ_SOLUTION(OID, RUN, LAB)
%
% SOL  - Solution (struct).
% DATA - Toolbox data (struct).
% OID  - Object instance identifier (string).
% RUN  - Run identifier (string).
% LAB  - Solution label (integer).


tbid         = coco_get_id(oid, 'cpdf');
[data chart] = coco_read_solution(tbid, run, lab);
sol.x        = chart.x;

end
