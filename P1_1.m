%% P1 - Basics on constrained optimization
%
% Script used to solve the problem 1 of part 1 of the ECPD course laboratoty
%
% Group 3: 95765 Afonso Magalhães 
%          95773 Beatriz Pedroso
%          95826 Teresa Gonçalves
%          95834 Miguel Isidoro
% 
% 
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% Plots function level curves

% Range of independent variables to consider 
x1min=-2;
x1max=2;
x2min=-2;
x2max=2;

% Number of intervals in the mesh grid
N1=100;
N2=100;

xv1 = linspace(x1min,x1max,N1);
xv2 = linspace(x2min,x2max,N2);
[xx1,xx2] = meshgrid(xv1,xv2);

% Computes the function at the different points of the mesh grid
for ii=1:N1
    for jj=1:N2
        x=[xx1(ii,jj); xx2(ii,jj)];
        ff(ii,jj)=Rosenbrock(x);
    end
end

% Plots the level curves using the Matlab function contoutr
Nlevel=10;  % Number of level curves in the contour plot
LW = 'linewidth'; FS = 'fontsize'; MS = 'markersize';
figure(1), contour(xv1,xv2,ff,Nlevel,LW,1.2), colorbar
axis([x1min x1max x2min x2max]), axis square
hold on

%--------------------------------------------------------------------------
% Compute the minimum

% Initial estimate of the minimum
x0=[-1; 1];

% Define the options to be used with the fminunc solver:
% The quasi-newton algorithm is used because it does not require the
% gradient; the default algorithm requires the gradient
options = optimoptions('fminunc','Algorithm','quasi-newton');

% Uses the solver fminunc to compute the minimum of the function defined in
% the Matlab function defined in the file Rosenbrock.m
xopt=fminunc(@Rosenbrock,x0,options)

%--------------------------------------------------------------------------
% Computes the constrained minimum associated to the constraint 
% x(1)+x(2) <= 1

Ac=[1 0];
Bc=0.5;
xoptconstr=fmincon(@Rosenbrock,x0,Ac,Bc)

%--------------------------------------------------------------------------
% Plots the initial point as a red circle
gg1=plot(x0(1),x0(2),'or');
set(gg1,'Linewidth',1.5);

% Plots the final estimate of the unconstrained minimum as a red cross
gg2=plot(xopt(1),xopt(2),'xr');
set(gg2,'Linewidth',1.5);

% Plots the final estimate of the constrained minimum as a red star
gg3=plot(xoptconstr(1),xoptconstr(2),'*r');
set(gg3,'Linewidth',1.5);

%plots the constraint boundary

z2c=[x2min:0.1:x2max];
z1c=Bc*ones(length(z2c), 1);

gg4=plot(z1c,z2c,'k');
set(gg4,'Linewidth',1.5);

% Identifies axis
gg=xlabel('x_1');
set(gg,'FontSize',11);

gg=ylabel('x_2');
set(gg,'FontSize',11);

lgd = legend([gg1,gg2,gg3,gg4], {'Initial guesses', 'Unconstrained minimum', 'Constrained minimum', 'Constrain Boundary'}, 'Location','southwest');
set(lgd,'FontSize',12);

hold off

%--------------------------------------------------------------------------
% Plots the 3d view of the function

figure(2)
surf(xx1,xx2,ff);

% Identifies axis
gg=xlabel('x_1');
set(gg,'FontSize',11);

gg=ylabel('x_2');
set(gg,'FontSize',11);

gg=zlabel('f(x)');
set(gg,'FontSize',11);

%--------------------------------------------------------------------------
% End of File
