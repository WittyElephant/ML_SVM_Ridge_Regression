% problems 3
% this function trains on the whole set and then predicts the sample,
% using the values from the multivariate regression function

function  [nzw, weights, result] = growth_rate_output(X, Y)


    
trainOutputs = Y;
trainInputs = X;

testInput = mean(X); %returns the mean of every column

[weights, ~] = multivariate_regression_solver(trainInputs,trainOutputs); %get weights and lambda
%disp(lambda) %debugger
result = horzcat(ones(size(testInput,1),1),testInput)*weights; %using the coefficeints from part 1, make predicted y values for test set
 nzw = find(abs(weights)>.0019);
   
end

 