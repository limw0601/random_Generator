function data = cpdf_init_data(data,a)

NTST = data.cpdf.NTST; % Number of mesh intervals
NCOL = data.cpdf.NCOL; % Degree of polynomial interpolants
dim  = 1;

cntnum = NTST-1;            % Number of internal boundaries

[tc wts]    = coll_nodes(NCOL); % Collocation nodes and quadrature weights
wts         = repmat(wts, [dim NTST]);
data.wts    = wts;

t  = repmat((0.5/NTST)*(tc+1), [1 NTST]);
t  = t+repmat((0:cntnum)/NTST, [NCOL 1]);
data.tcn    = t(:);   % Temporal mesh with duplication

data.a = a;

end

function [nds wts] = coll_nodes(m)
%COLL_NODES   Compute collocation nodes and integration weights.
%
% Uses eigenvalues and eigenvectors of Jacobi matrix.
%
% [NDS WTS] = COLL_NODES(M)
%
% NDS - Collocation nodes.
% WTS - Quadrature weights.
% M   - Polynomial degree.

n = (1:m-1)';
g = n.*sqrt(1./(4*n.^2-1));
J = -diag(g,1)-diag(g,-1);

[w x] = eig(J);
nds   = diag(x);
wts   = 2*w(1,:).^2;

end

