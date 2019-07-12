function prob = cpdf_construct(prob, tbid, data, x0)
% CPDF_CONSTRUCT_SEG   Append an instance of 'cpdf' to problem.
%
% PROB = CPDF_CONSTRUCT_SEG(PROB, TBID, DATA, SOL)
%
% PROB - Continuation problem structure.
% TBID - Toolbox instance identifier.
% DATA - Toolbox data structure.
% x0   - Initial x.

prob = coco_add_func(prob, tbid, @cpdf_F, @cpdf_DFDU, data, 'inactive', ...
  tbid, 'u0', x0);
prob = coco_add_slot(prob, tbid, @coco_save_data, data, 'save_full');

end

function [data y] = cpdf_F(prob, data, u)

a = data.a;
% a + (x-a)\tau
tau_cn = a+(u-a)*data.tcn;
f_cn   = data.fhan(tau_cn);

% integration
Int_f  = data.wts*f_cn;

y = (u-a)*Int_f;
y = y/(2*data.cpdf.NTST);


end

function [data J] = cpdf_DFDU(prob, data, u)

a = data.a;
% a + (x-a)\tau
tau_cn = a+(u-a)*data.tcn;
f_cn   = data.fhan(tau_cn);
df_cn  = data.dfhan(tau_cn);

% integration
Int_f      = data.wts*f_cn;
Int_df_tau = data.wts*(df_cn.*data.tcn);

J = Int_f+(u-a)*Int_df_tau;
J = J/(2*data.cpdf.NTST);

% [data, DadF] = coco_ezDFDX('f(o,d,x)',  prob, data, @cpdf_F, u);
% 
% abs(J-DadF)

end
