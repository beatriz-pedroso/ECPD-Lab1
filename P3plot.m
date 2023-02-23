%% Function P3plot 
%
% This functions plots the outputs given by the simulink simulation

function P3plot(kt, yout, rout, uout)

figure()

% Plots the output and the reference
subplot(2,1,1)

gg=plot(kt,yout,'b');
set(gg,'LineWidth',1.5);
hold on
gg=plot(kt,rout,'r');
set(gg,'LineWidth',1.5);
hold off

gg=xlabel('time (s)');
set(gg,'Fontsize',10);
gg=ylabel('y');
set(gg,'Fontsize',10);

% Plots the control variable
subplot(2,1,2)

gg=stairs(kt,uout);
set(gg,'LineWidth',1.5);
gg=xlabel('time (s)');
set(gg,'Fontsize',11);
gg=ylabel('u');
set(gg,'Fontsize',11);
    
end