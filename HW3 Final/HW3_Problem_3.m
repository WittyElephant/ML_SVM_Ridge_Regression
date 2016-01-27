%Problem 3
clear();

%loading in the data

data = dlmread('growth_input_output.txt');

% we will split the data

growth = data(:,1);
inputs = data(:,2:end);

% we're going to train on the whole data set for the most accurate results


[~,~, growthRate] = growth_rate_output(inputs, growth);
display(growthRate);
% display(nnz);