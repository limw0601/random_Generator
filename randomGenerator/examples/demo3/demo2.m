
%%
% when the number of samples is large, e.g., 10,000, the simulation will
% become more and more slow as continuation performed because the stored
% data takes lots of memory in disk. Here, we delete data after certain
% runs to ensure the efficiency
%%
global a b
a = 0.5;
b = 0;
prob = coco_prob();
prob = coco_set(prob, 'cpdf', 'NTST', 10);
prob = coco_set(prob, 'cpdf', 'NCOL', 4);
prob = coco_set(prob, 'cont', 'h_max', 0.05);
prob = coco_set(prob, 'cont', 'ItMX', 1400);
aa = 1.5; % lower bound of integration domain
% aa = b;

NSAMP = 10000;
Nsamp = 100;
NRAN  = round(NSAMP/Nsamp);
XRAND = [];

for run_id = 1:NRAN
    fprintf('run%d in total %d runs\n',run_id, NRAN);
    tic
    
    prob1 = cpdf_constructor(prob, '', @func, @Dfunc, aa, aa);
    uidx = coco_get_func_data(prob1, 'cpdf', 'uidx');
    prob1 = coco_add_pars(prob1, 'pars', uidx, 'x');

    Frand       = rand(Nsamp,1);
    [Frand,idx] = sort(Frand);
    prob1 = coco_add_event(prob1, 'UZ', 'cpdf', Frand);
    
    coco(prob1, 'run1', [], 1, {'cpdf' 'x'},{[],[aa,aa+2*pi]});

    bd = coco_bd_read('run1');
    %% random numbers
    labs  = coco_bd_labs(bd, 'UZ');
    xrand = zeros(Nsamp,1);
    for i=1:Nsamp
        sol      = cpdf_read_solution('', 'run1', labs(i));
        xrand(idx(i)) = sol.x;
    end
    %% remove data to improve efficiency
    rmdir data s;
    XRAND = [XRAND; xrand];
    toc
end

figure(2)
x = linspace(aa,aa+2*pi,100);
plot(x, func(x)); hold on;
% [xm,nx] = myhist(xrand, aa, aa+2*pi, 6);
[xm,nx] = unifhist(XRAND, aa, aa+2*pi, 2*pi/40);
plot(xm, nx, 'ro');






