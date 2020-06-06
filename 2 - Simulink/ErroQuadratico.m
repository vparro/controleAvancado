function [Eq] = ErroQuadratico(X,Rd,Id)
% Esta função determina o erro quadrático
% entre a saída real e a saída do modelo.
% u - entrada real
% y - saída real
% t - tempo real
% X = [Km pm];

beta = X(1);
r = X(2);

%%% Modelo

S0 = 60e6;
I0 = 2;
R0 = 0;
N  = 60e6;

options = simset('solver','ode45','MaxStep',0.01,'InitialStep',0.01,'ReturnWorkspaceOutputs', 'on');
y = sim('SIRmodel',200,options);

%%% Saida do modelo

I = y.logsout{1}.Values.Data; % Saída I
R = y.logsout{2}.Values.Data; % Saída R

auxI = resample(I,length(I),length(Id));
auxR = resample(R,length(R),length(Rd));

%%% Erro quadrático

Eq = sum((auxI - Id).^2) + sum((auxR - Rd).^2); %% cálculo do erro

% plot(t,y,t,ym,"linewidth", 2)

end

