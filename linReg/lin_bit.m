%% Setting up Environment
clc; clear all; close all;
which = 1:10
graph = 1
leg = {};

%% instructions:
%   models holds the different polynomial combinations you can 
%   use for the linear regression analysis. 1:3 will do models
%   for the following equations:
%       Ax + B
%       Ax^2 + Bx + C
%       Ax^3 + Bx^2 +Cx + D
%   [1 3] will create the models for the following equations:
%       Ax + B
%       0x^2 + 0x + 0
%       Ax^3 + Bx^2 +Cx + D
models = [1:2:7];

%   scale allows higher-polynomial functions to still be
%   used. The high numbers of t affected the evaluation of
%   t^7 or t^11 too much for regression to be useful.
scale = 100;



%% Establishing Variables
price = readmatrix("../data/train.csv");
t = price(:,1)';
t = (t-42843)/scale;
price = price(:,3)';

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




%% Show Results
x = zeros(length(t),max(models)+1);
for i = 0:max(models)
    x(:,end-i) = t.^i;
end
disp("Coefficients")
disp(funy);
disp("r^2")
disp(r2')

out = x*funy';
if graph == 1
    for i = models
        plot(t,out(:,i));
    end
end
legend(leg)



%% Cmp to test:
shft = .4;

test = readmatrix("../data/test.csv");
tt = test(:,1)';
tt = tt/scale;
test = test(:,3)';
disp(tt(1));
figure
plot(tt,test);
hold on;

disp("here")

% Sets the matrix up for plot display
x = zeros(length(tt),max(models)+1);
for i = 0:max(models)
    x(:,end-i) = (tt+shft).^i;
end


% calculates the mean r^2 error
tout = x*funy';
tr2 = zeros(max(models),1);
for i = 1:max(models)
    tr2(i) = mean((test-tout(:,i)').^2);
end

disp("tr^2")
disp(tr2')

if graph == 1
    for i = models
        plot(tt,tout(:,i));
    end
end
disp(tout(1:15))
legend(leg)



