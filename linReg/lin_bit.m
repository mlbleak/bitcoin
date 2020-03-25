%% Setting up Environment
clc; clear all; close all;
which = 1:10
graph = 1
models = 1:7;
leg = {};



%% Establishing Variables
price = readmatrix("../data/train.csv");
t = price(:,1)';
t = t-42843;
price = price(:,3)';
%t = flip(t);

if graph == 1
    plot(t,price); grid
    leg{length(leg)+1} = "data";
    hold on;
end

%% Executing:

funy = zeros(max(models),max(models)+1);
r2 = zeros(length(models),1);
for model = models
    [funy(model,end-model:end),r2(model)] = polyReg(model,t,price);
    leg{length(leg)+1} = num2str(model);
end
x = zeros(length(t),max(models)+1);
for i = 0:max(models)
    x(:,end-i) = t.^i;
end

disp(funy);

out = x*funy';
if graph == 1
    plot(t,out);
end
%% Comparing

legend(leg)





