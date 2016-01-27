%Problem 1
clear();

%loading in the data

data = dlmread('growth_input_output.txt');

% we will split the data

growth = data(:,1);
inputs = data(:,2:end);

% we'll do the 10 fold cross validation in the regression function


%and throw this into my multivariate regression solver

[~,results] = multivariate_regression_function(inputs, growth);
display(results);