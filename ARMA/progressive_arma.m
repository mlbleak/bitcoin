clc; clear all; close all;
which = 4
graph = 1
addpath('../linReg');
addpath('../gpr');


%% Presets:
polynomial = 2;
%   scale allows higher-polynomial functions to still be
%   used. The high numbers of t affected the evaluation of
%   t^7 or t^11 too much for regression to be useful.
scale = 1;
price = readmatrix("../data/train.csv");
t = price(:,1)';
t = (t-42843)/scale;
price = price(:,3)';
gprweight = 10^.3;
tt = zeros(size(t));
pp = zeros(size(price));
k = 10;
l = 20;

w_avg = zeros(size(t));
for i = 1:k-1
    tt(i) = t(i);
    pp(i) = price(i);
    w_avg(i+1) = price(i);
end


%% get Models:
weight = zeros(size(t));
mux = zeros(size(t));
s = zeros(size(t));
for i = k:length(t)-1
    tt(i) = t(i);
    pp(i) = price(i);
    
    point = t(i+1);
    knn = tt(i-k+1:i);
    [fx,r2] = polyReg(polynomial,knn,pp(i-k+1:i));
    [mu,sigma] = gpr(tt(1:i),pp(1:i),t(i+1),l*scale^(-.5));
    mux(i+1) = mu;
    x = zeros(1,polynomial+1);
    for j = 0:polynomial
        x(:,end-j) = point^j;
    end
    s(i) = sigma;
    
    weight(i) = sigma*gprweight/(sigma*gprweight+r2);
    w_avg(i+1) = (1-weight(i))*mu+x*fx*weight(i);
end

disp([mean(weight);var(weight);]);

plot(t,price); grid;
hold on;
plot(t(2:end),w_avg(2:end));
hold on;
plot(t(2:end),mux(2:end));
hold on;

perr = sum(((w_avg(k+1:end)-price(k+1:end))./price(k+1:end)).^2);
disp([perr]);

