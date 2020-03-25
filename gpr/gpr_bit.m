clc; clear all; close all;
which = 4
graph = 1
price = readmatrix("../data/train.csv");
t = price(:,1)';
t = t-42843;
price = price(:,3)';

plot(t,price); grid
hold on;
l = 10;


%t_test = [0.5:100:600.5,601.5:2:610.5];

t_test = [0.5:10:600.5,601.5:2:610.5];


x = 1:100;
y = x.^2;

xt = .5:110.5;

[mux,six] = gpr(x,y,xt,1);


[mufs, sigmafs] = gpr(t,price,t_test,10);
[mul, sigmal] = gpr(t,price,t_test,5);
[mu, sigma] = gpr(t,price,t_test,1);


plot(t_test,mufs); grid
hold on;
plot(t_test,mul); grid
hold on;
plot(t_test,mu); grid


%disp(t2(1:5));S



%figure;

%plot(x,y);
%hold on;
%plot(xt,mux);




legend("data","l=10","l=5","l=1");