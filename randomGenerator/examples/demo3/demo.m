%%
% when the number of samples is large, e.g., 10,000, the simulation will
% become more and more slow as continuation performed because the stored
% data takes lots of memory in disk. In demo2, we delete data after certain
% runs to ensure the efficiency
%%
global a b
a = 0.1;
b = 0;
prob = coco_prob();
prob = coco_set(prob, 'cpdf', 'NTST', 10);
prob = coco_set(prob, 'cpdf', 'NCOL', 4);
prob = coco_set(prob, 'cont', 'h_max', 0.05);
prob = coco_set(prob, 'cont', 'ItMX', 1400);
aa = 0.5; % lower bound of integration domain
aa = b;
prob = cpdf_constructor(prob, '', @func, @Dfunc, aa, aa);
uidx = coco_get_func_data(prob, 'cpdf', 'uidx');
prob = coco_add_pars(prob, 'pars', uidx, 'x');

Nsamp = 20;
Frand = rand(Nsamp,1);
Frand = sort(Frand);
prob = coco_add_event(prob, 'UZ', 'cpdf', Frand);

coco(prob, 'run1', [], 1, {'cpdf' 'x'},{[],[aa,aa+2*pi]});

bd = coco_bd_read('run1');
coco_plot_bd('run1', 'x', 'cpdf');
x = coco_bd_col(bd, 'x');
F = coco_bd_col(bd, 'cpdf');
hold on
% plot(x, func(x))
xl = x(x<b+pi);
xr = x(x>b+pi);
yl = atan((tan(b/2 - xl/2)*(a + 1))/(a - 1))/pi;
yr = atan((tan(b/2 - xr/2)*(a + 1))/(a - 1))/pi+1;
plot([xl xr],[yl yr],'bs');

% figure(2)
% plot(x, F-atan((tan(b/2 - x/2)*(a + 1))/(a - 1))/pi,'ro');


%% random numbers
labs  = coco_bd_labs(bd, 'UZ');
xrand = zeros(Nsamp,1);
for i=1:Nsamp
    sol      = cpdf_read_solution('', 'run1', labs(i));
    xrand(i) = sol.x;
end
figure(1)
plot(xrand, Frand, 'ro'); hold on

figure(2)
plot(x, func(x)); hold on;
% [xm,nx] = myhist(xrand, aa, aa+2*pi, 6);
[xm,nx] = unifhist(xrand, aa, aa+2*pi, 2*pi/50);
plot(xm, nx, 'ro');

%% analytical solution for integration in [b,b+2*pi]
yl = Frand(Frand<0.5);
yr = Frand(Frand>0.5);
xl = b+2*atan((1-a)/(1+a)*tan(pi*yl));
xr = b+2*atan((1-a)/(1+a)*tan(pi*(yr-1)))+2*pi;
figure(1)
plot([xl;xr],[yl;yr],'k.');


%% using analytical solution to check distribution
Ns    = 1000000;
Frand = rand(Ns,1);
yl = Frand(Frand<0.5);
yr = Frand(Frand>0.5);
xl = b+2*atan((1-a)/(1+a)*tan(pi*yl));
xr = b+2*atan((1-a)/(1+a)*tan(pi*(yr-1)))+2*pi;
figure(3);
xx = linspace(aa,aa+2*pi,100);
plot(xx, func(xx),'k-','LineWidth',2); hold on;
% [xm,nx] = myhist([xl;xr], aa, aa+2*pi, 50);
[xm,nx] = unifhist([xl;xr], aa, aa+2*pi, 2*pi/40);
plot(xm, nx, 'ro','LineWidth',2,'MarkerSize',8);
axis([aa,aa+2*pi,0.12,0.2]);
set(gca,'LineWidth',1.2);
set(gca,'FontSize',14);
xlabel('Phase $x$','interpreter','latex','FontSize',16);
ylabel('Density $\rho_0(x)$','interpreter','latex','FontSize',16);
leg1 = legend('Continuum limit', 'Samples');
set(leg1,'Interpreter','latex');
set(leg1,'FontSize',16);



%% shift of psi
b = 1.5;
aa = 0.8;


Ns    = 1000000;
Frand = rand(Ns,1);
yl = Frand(Frand<0.5);
yr = Frand(Frand>0.5);
xl = b+2*atan((1-a)/(1+a)*tan(pi*yl));
xr = b+2*atan((1-a)/(1+a)*tan(pi*(yr-1)))+2*pi;
figure(3);
xx = linspace(aa,aa+2*pi,100);
plot(xx, func(xx)); hold on;
[xm,nx] = unifhist([xl;xr], b, b+2*pi, 2*pi/50);
plot(xm, nx, 'ro');
xrand     = [xl;xr];
% xrand_sft = xrand-b+aa; % shift directly
% [xm,nx] = unifhist(xrand_sft, aa, aa+2*pi, 2*pi/50);
% plot(xm, nx, 'bs');
x1 = xrand(xrand<aa);
x1 = x1+2*pi;
x2 = xrand(xrand>aa);
x3 = x2(x2>aa+2*pi);
x3 = x3-2*pi;
x2 = x2(x2<aa+2*pi);
[xm,nx] = unifhist([x1;x2;x3], aa, aa+2*pi, 2*pi/50);
plot(xm, nx, 'kv');







