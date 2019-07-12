function prob = cpdf_constructor(prob, oid, f, Df, x0, a)

% PROB     = cpdf_constructor(PROB, OID, VARARGIN)
% VARARGIN = { @F @DF x0 a }
%
% PROB   - Continuation problem structure.
% OID    - Object instance identifier (string).
% @F     - Function handle to pdf.
% @DF    - Function handle to derivative of pdf.
% x0     - Initial value for x
% a      - Lower bound of x


tbid = coco_get_id(oid, 'cpdf'); % Create toolbox instance identifier
data.fhan  = f;
data.dfhan = Df;

cpdf_arg_check(tbid, data, x0, a);           % Validate input
data = cpdf_get_settings(prob, tbid, data);  % Get toolbox settings
data = cpdf_init_data(data, a);         % Build toolbox data
prob = cpdf_construct(prob, tbid, data, x0); % Append continuation problem

end
