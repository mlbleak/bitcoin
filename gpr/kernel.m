function [covid_3] = kernel(covid_1,covid_2,l)
%KERNEL Summary of this function goes here
%   Detailed explanation goes here
    covid_3 = zeros(length(covid_1),length(covid_2));
    for i = 1:length(covid_1)
        for j = 1:length(covid_2)
            covid_3(i,j) = exp(-1*abs(covid_2(j) - covid_1(i))/(2*l^2));
        end
    end
end

