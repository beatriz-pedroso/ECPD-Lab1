%% P1 - Basics on constrained optimization
%
% Script used to solve the problem 2 of part 1 of the ECPD course laboratoty
%
% Group 3: 95765 Afonso Magalhães 
%          95773 Beatriz Pedroso
%          95826 Teresa Gonçalves
%          95834 Miguel Isidoro
%  
%--------------------------------------------------------------------------


%initial commands

close all
clear all
clc


%--------------------------------------------------------------------------
% Plots function level curves

% Range of independent variables to consider 
x1min=-3;
x1max=30;
x2min=-3;
x2max=30;

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
        ff(ii,jj)=P1_2func(x);
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
x0 = [-1 -1 1 1; 1 -1 -1 1];

% Define the options to be used with the fminunc solver:
% The quasi-newton algorithm is used because it does not require the
% gradient; the default algorithm requires the gradient
options = optimoptions('fminunc','Algorithm','quasi-newton');

% Uses the solver fminunc to compute the minimum of the function defined in
% the Matlab function defined in the file P2.m

for i=1:size(x0,2)
    xopt=fminunc(@P1_2func,x0(:,i),options);
    xmin(:,i) = xopt; 
end

%Determination of the convergence boundary

%Selection of the Desired Minimum
xch = xmin(:,4);
% xch = xmin(2,4);

%Determination Of the desired steps
hr = 0.5;
hteta = pi/64;

%Index
i = 1;

%Cycle for to determine the convergence region

for teta = 0:hteta:2*pi
    
    k = 0;
    r = 0;
    while (k == 0)
        
        r = r + hr;
        xguess = [xch(1) + r*cos(teta) ; xch(2) + r*sin(teta)];
        xaux = fminunc(@P1_2func,xguess,options);
        
        if norm(xaux - xch) < 0.001 
            convbound(:,i) = xguess;
            i = i+1;
        else
            k = 1;
        end
        
    end
    
end

%% Plots the initial point as a red circle
for i=1:size(x0,2) 
    gg1=plot(x0(1,i),x0(2,i),'or');
    set(gg1,'Linewidth',1.5);
end       
    
% Plots the final estimate of the unconstrained minimum as a red cross

for i=1:size(xmin,2)
    gg2=plot(xmin(1,i),xmin(2,i),'xr','DisplayName','Local minima');
    set(gg2,'Linewidth',1.5);
end

% Plot the convergence boundary 

x = convbound(1,:).';
y = convbound(2,:).';
B = boundary(x,y,1);
gg3 = plot(x(B),y(B));
set(gg3,'Linewidth',1.5);

gg4 = plot(convbound(1,:),convbound(2,:),'b');
set(gg4,'Linewidth',1.5);


% Identifies axis
gg=xlabel('x_1');
set(gg,'FontSize',11);

gg=ylabel('x_2');
set(gg,'FontSize',11);

lgd = legend([gg1,gg2,gg3,gg4], {'Initial guesses', 'Local minima', 'Convergence boundary', 'Convergence region'});
lgd.NumColumns = 2;
set(lgd,'FontSize',10);

hold off

%--------------------------------------------------------------------------
%Plots the 3d view of the function

figure(2)
surf(xx1,xx2,ff);

% Identifies axis
gg=xlabel('x_1');
set(gg,'FontSize',11);

gg=ylabel('x_2');
set(gg,'FontSize',11);

gg=zlabel('f(x)');
set(gg,'FontSize',11);

