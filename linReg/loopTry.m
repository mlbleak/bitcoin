clc; clear all; close all;
sz = 1;
t = 0:.5:4;
x = zeros(length(t),sz+1);
y = t.^2 + 9*randn(1,length(t));
for i = 0:sz
    x(:,end-i) = t.^i;
end
%funy = pinv(x'*x)*x'*y';
models = [1:6:13];
funy = zeros(max(models),max(models)+1);
r2 = zeros(length(models),1);
for model = models
    [funy(model,end-model:end),r2(model)] = polyReg(model,t,y);
end
t1 = 0:.01:4;
x = zeros(length(t1),max(models)+1);
for i = 0:max(models)
    x(:,end-i) = t1.^i;
end

out = x*funy';


%[funy,r2] = polyReg(1,t,y);

%yGuess = x*funy;
%    r2 = mean((y-(x*funy)').^2);
    disp(r2);
    disp(funy);


plot(t,y);
hold on;
plot(t1,out);
%plot(t,yGuess);