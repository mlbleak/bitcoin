%% Setting up Environment
clc; clear all; close all;
which = 1:10
graph = 1
model = 1:13;



%% Establishing Variables
price = readmatrix("../data/train.csv");
t = price(:,1)';
t = t-42843;
price = price(:,3)';

if graph == 1
    plot(t,price); grid
    hold on;
end

%% Executing:

funy = zeros(max(model),max(model)+1);
r2 = zeros(length(model),1);
for model = model
    [funy(model,end-model:end),r2(model)] = polyReg(model,t,y);
end




