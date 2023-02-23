%% P2 - Basics on receding horizon control
%
% Script used to solve part 2 of the ECPD course laboratoty
%
% Group 3: 95765 Afonso Magalhães 
%          95773 Beatriz Pedroso
%          95826 Teresa Gonçalves
%          95834 Miguel Isidoro

%%
% The function P2 can be called for different values of A, B, and Q.

% For the proposed laboratory work, the function has to be called for two different inputs.
% Firstly, considering an open-loop unstable first order plant, A=1.2.
% Secondly, considering an open-loop stable first order plant, A=0.8.
% For both inputs, B=1 and Q=1.

clc 
clear all
close all
P2(1.2, 1, 1)
P2(0.8, 1, 1)

%%
function P2(A, B, Q)
%% Pergunta 1
%LQ state feedabck gain computed for low and high values of R
    jj=1;
    for R=0.1:2:100
        [KLQ, S, lambda] = dlqr(A,B,Q,R);
        KLQ_vR(:,jj)=KLQ;    %The values of the gain and the respective R
        R_vR(:,jj)=R;        %were, for each iteration, saved in a vector  
        jj=jj+1;             %to be, later on, plotted
    end
    
    figure()
    hold on
    plot(R_vR, KLQ_vR);
    xlabel('R');
    ylabel('LQ Gain');  
      
    

    %% Pergunta 2 

    %The receding horizon gains were tested for several values of R
    C=1; 
    y = logspace(-3,3,7);    %Values of R taken into account
    figure()
    hold on

    for l=1:1:7              %Outside loop iterates for each value of R tested
        R=y(l);
        [KLQ, S, lambda] = dlqr(A,B,Q,R); 
        clear w Trian_sup W PI M 
        ii = 1;
        for H=1:1:50         %The gains are tested for Horizons between 1 and 50

            % Matrix W definition
            for jj=1:1:H
                for kk=1:1:H 
                    w(kk,jj) = C*B*A^(kk-jj);
                end
            end

            Trian_sup=ones(H);
            Trian_sup = tril(Trian_sup);

            W = w.*Trian_sup;

            % Matrix PI definition
            for jj=1:1:H
                PI(jj,:)=A^(jj);
            end

            % Vector PI definition
            M = W.'*W + R*eye(H);

            % Computation of the receding horizon (RH) gain
            K = M^(-1)*W.'*PI;
            KRH = K(1);
    
            %values saved in vector to be, later on, plotted
            KRH_v(ii,l)=KRH;
            H_v(ii)=H;
            ii=ii+1;
        end
        
        %Conditions to make 2 different plots
        %Plot for R=[0.001, 0.01, 0.1, 1]
        if l<=4
            plot(H_v, KRH_v(:,l));
            plot(H_v, KLQ*ones(length(H_v)));
            legend('R (KRH) = 0.001','R (KLQ) = 0.001','R (KRH) = 0.01','R (KLQ) = 0.01','R (KRH) = 0.1','R (KLQ) = 0.1' ,'R (KRH) = 1','R (KLQ) = 1');
            xlabel('Horizon');
            ylabel('Gain');
        end
        
        if l==4
            hold off
            legend show
            figure()
            hold on
        end
        
        %Plot for R=[10, 100, 1000]
        if l>4
            plot(H_v, KRH_v(:,l));
            plot(H_v, KLQ*ones(length(H_v)));
            legend('R (KRH) = 10','R (KLQ) = 10','R (KRH) = 100','R (KLQ) = 100','R (KRH) = 1000','R (KLQ) = 1000');
            xlabel('Horizon');
            ylabel('Gain');
        end
    end
    hold off
    
    

    %% Pergunta 3
    Dim=size(KRH_v);
    EIGV = A*ones(Dim(1), Dim(2)) - B*KRH_v;
    EIGV_abs = abs(EIGV);

    %plot of the absolute value of the closed-loop eigenvalue and 
    %comparison with the stability boundary.
    figure()
    hold on
    for jj = 1:1:Dim(2)
        plot(H_v, EIGV_abs(:,jj));
    end
    
    plot(H_v, ones(length(H_v)));
    legend('R = 0.001','R = 0.01','R = 0.1','R = 1','R = 10','R = 100', 'R = 1000', 'Stability boundary');
    xlabel('Horizon');
    ylabel('Absolute eigenvalue');
    hold off
    
    figure()
    hold on
    for kk = 4:3:16
        plot(y, EIGV_abs(kk,:));
        set(gca, 'XScale', 'log')
    end
    xlabel('R');
    ylabel('Absolute eigenvalue');
    hold off

end
   