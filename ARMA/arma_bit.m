clc; clear all; close all;
which = 4
graph = 1
addpath('../linReg');
addpath('../gpr');

%% Presets:
polynomial = 7;
%   scale allows higher-polynomial functions to still be
%   used. The high numbers of t affected the evaluation of
%   t^7 or t^11 too much for regression to be useful.
scale = 100;
price = readmatrix("../data/train.csv");
t = price(:,1)';
t_test = [0.5:10:600.5,601.5:2:620.5]/scale;
t = (t-42843)/scale;
price = price(:,3)';
gprweight = 10^8;

%% get Models:
[mufs, sigmafs] = gpr(t,price,t_test,5*scale^(-.5));
sigmafs = sum(sigmafs)*gprweight;
[coeff, r2]     = polyReg(polynomial,t,price);


x = zeros(length(t_test),polynomial+1);
for i = 0:polynomial
    x(:,end-i) = t_test.^i;
end

out = x*coeff;
gpratio = sigmafs./(sigmafs+r2);

new = (1-gpratio)'.*mufs+out.*gpratio';




%% plot Models:
plot(t,price);
hold on;
plot(t_test,mufs); grid
hold on;
plot(t_test,out);
hold on;
plot(t_test,new);
hold on;

legend("data","GPR","x^7 Linear Regression","weighted average");

