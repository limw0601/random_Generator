

prob = coco_prob();
prob = coco_set(prob, 'cpdf', 'NTST', 5);
prob = coco_set(prob, 'cpdf', 'NCOL', 2);
a = 1; % lower bound of integration domain
prob = cpdf_constructor(prob, '', @func, @Dfunc, 2, a);
uidx = coco_get_func_data(prob, 'cpdf', 'uidx');
prob = coco_add_pars(prob, 'pars', uidx, 'x');

coco(prob, 'run1', [], 1, {'cpdf' 'x'},{[],[a,10]});

bd = coco_bd_read('run1');
coco_plot_bd('run1', 'x', 'cpdf');
x = coco_bd_col(bd, 'x');
F = (x.^3-a^3)/3;
hold on
plot(x,F,'r*');

