%% Function P3mdfunc 
%
% This function returns the struct that contains the parameters of the mpc
% controller

function md = P3mdfunc(Ap, Bp, Cp, Dp, h, u_min, u_max, du_min, du_max, z_min, z_max, Q, R, Hp, Hu)
    
    % Model used by MPC

    Ad=Ap;
    Bd=Bp;
    Cyd=Cp;

    Czd=1;
    Dzd=0;   % Dp;

    Ccd=Cp;
    Dcd=Dp;

    zblk=1;
    ublk=1;
    
    Hw = 1;
    
    W=[]; % state estimator not used
    V=[]; % 

    cmode=0; % feedback of the state
    solver='qp_as';

    %--------------------------------------------------------------------------
    % MPC inicialization

    md = MPCInit(Ad,Bd,Cyd,Czd,Dzd,Ccd,Dcd,Hp,Hw,zblk,Hu,ublk, ...
            du_max,du_min,u_max,u_min,z_max, ...
            z_min,Q,R,W,V,h,cmode,'qp_as');
end