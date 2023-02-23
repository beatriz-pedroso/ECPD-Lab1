%% P3 – Basics on predictive control
%
% Script used to solve part 3 of the ECPD course laboratoty
%
% Group 3: 95765 Afonso Magalhães 
%          95773 Beatriz Pedroso
%          95826 Teresa Gonçalves
%          95834 Miguel Isidoro
% 
%--------------------------------------------------------------------------
%% Initial Commands

clear all
close all

%% Parameters of the discrete model

    h=0.1; % sampling period (s)

    Ap=1.2;
    Bp=1;
    Cp=1;   %Assumes access to the state as output
    Dp=0;

    path(path,'../')
    tfinal=150; % duration of the simulation (s)

    
    %% Base Plot 
    
    % MPC parameters computation

    md = P3mdfunc(1.2, 1, 1, 0, 0.1, -100, 100, -100, 100, -10000, 10000, 1000, 10000, 3, 3)

    % Simulates the controlled system
    sim('Oscillating');
    
    % Plots 
    P3plot(kt, yout, rout, uout);

    %% Question 1
    
    % u_min and u_max variation
    md = P3mdfunc(1.2, 1, 1, 0, 0.1, -0.25, 0.25, -100, 100, -10000, 10000, 1000, 10000, 3, 3)
    sim('Oscillating');
    P3plot(kt, yout, rout, uout);

    md = P3mdfunc(1.2, 1, 1, 0, 0.1, -0.25, 10, -100, 100, -10000, 10000, 1000, 10000, 3, 3)
    sim('Oscillating');
    P3plot(kt, yout, rout, uout);
    
    % du_min and du_max variation
    
    md = P3mdfunc(1.2, 1, 1, 0, 0.1, -100, 100, -0.15, 0.15, -10000, 10000, 1000, 10000, 3, 3)
    sim('Oscillating');
    P3plot(kt, yout, rout, uout);

    md = P3mdfunc(1.2, 1, 1, 0, 0.1, -100, 100, -10, 0.15, -10000, 10000, 1000, 10000, 3, 3)
    sim('Oscillating');
    P3plot(kt, yout, rout, uout);
    
    % z_min and z_max variation
    
    md = P3mdfunc(1.2, 1, 1, 0, 0.1, -100, 100, -100, 100, -1, 1, 1000, 10000, 3, 3)
    sim('Oscillating');
    P3plot(kt, yout, rout, uout);

    md = P3mdfunc(1.2, 1, 1, 0, 0.1, -0.25, 0.25, -100, 100, -1, 1, 1000, 10000, 3, 3)
    sim('Oscillating');
    P3plot(kt, yout, rout, uout);
    
    % R and Q variation
    
    md = P3mdfunc(1.2, 1, 1, 0, 0.1, -100, 100, -100, 100, -10000, 10000, 1, 0.1, 3, 3)
    sim('Oscillating');
    P3plot(kt, yout, rout, uout);

    md = P3mdfunc(1.2, 1, 1, 0, 0.1, -100, 100, -100, 100, -10000, 10000, 1, 1, 3, 3)
    sim('Oscillating');
    P3plot(kt, yout, rout, uout);
    
    md = P3mdfunc(1.2, 1, 1, 0, 0.1, -100, 100, -100, 100, -10000, 10000, 1, 10, 3, 3)
    sim('Oscillating');
    P3plot(kt, yout, rout, uout);
    
    % Hp variation
    
    md = P3mdfunc(1.2, 1, 1, 0, 0.1, -100, 100, -100, 100, -10000, 10000, 1000, 10000, 2, 2)
    sim('Oscillating');
    P3plot(kt, yout, rout, uout);

    md = P3mdfunc(1.2, 1, 1, 0, 0.1, -100, 100, -100, 100, -10000, 10000, 1000, 10000, 50, 50)
    sim('Oscillating');
    P3plot(kt, yout, rout, uout);
    
    % Hu variation
    
    md = P3mdfunc(1.2, 1, 1, 0, 0.1, -100, 100, -100, 100, -10000, 10000, 10, 10000, 50, 10)
    sim('Oscillating');
    P3plot(kt, yout, rout, uout);

    md = P3mdfunc(1.2, 1, 1, 0, 0.1, -100, 100, -100, 100, -10000, 10000, 10, 10000, 50, 25)
    sim('Oscillating');
    P3plot(kt, yout, rout, uout);
    
    %% Question 2
    
    md = P3mdfunc(1.2, 1, 1, 0, 0.1, -0.4, 0.4, -100, 100, -10000, 10000, 1000, 1000000, 8, 8)
    sim('Oscillating');
    P3plot(kt, yout, rout, uout);

    md = P3mdfunc(1.2, 1, 1, 0, 0.1, -0.4, 0.4, -100, 100, -10000, 10000, 1000, 1000000, 13, 13)
    sim('Oscillating');
    P3plot(kt, yout, rout, uout);
    
    md = P3mdfunc(1.2, 1, 1, 0, 0.1, -0.4, 0.4, -100, 100, -10000, 10000, 1000, 1000000, 50, 50)
    sim('Oscillating');
    P3plot(kt, yout, rout, uout);
%__________________________________________________________________________
% End of file

