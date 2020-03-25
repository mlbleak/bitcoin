function [mu,sigma] = gpr(COVID_4,fCOVID_4,COVID_5,l)
%GPR Summary of this function goes here
%   Detailed explanation goes here

%% changes
% add mu (average of data)
% justify the mu
% comment the code
% DOCUMENTATION!!!

% ARMA
% Kalman
% Linear Regression
% GRP
% Compared to gold, $$, and stock market

%%
k   = kernel(COVID_4,COVID_4,l);

%%
ks  = kernel(COVID_4,COVID_5,l);

%%
kss = kernel(COVID_5,COVID_5,l);

%%
mu = ks'*inv(k)*fCOVID_4';
sigma = kss-ks'*inv(k)*ks;
end

