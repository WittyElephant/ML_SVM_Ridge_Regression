% problems 1 - 3
% this function finds the MSE for both the training and the testing sets,
% using the values from the multivariate regression function

function [sampleMean, results] = multivariate_regression_function(X, Y)

results = ones(2,10); %lambda's, cross validation error, number of non zero weights
allIndex = 1:size(X, 1);
firstIndex = 1;
lastIndex = 19;
allPredictions = ones(194,1); %for the bootstrap of number 2
for j = 1:10 %10 fold
    testIndexes = firstIndex:lastIndex;
    trainIndexes = setdiff(allIndex,firstIndex:lastIndex);
    %we have 195 inputs which doesn't divide into 10 evenly, so I will give
    %every other iteration another sample
    
    testOutputs = Y(testIndexes);
    testInputs = X(testIndexes,:);
    
    trainOutputs = Y(trainIndexes,:);
    trainInputs = X(trainIndexes, :);
    
    [weights, ~] = multivariate_regression_solver(trainInputs,trainOutputs); %get weights and lambda
    %disp(lambda) %debugger
    yPredict = horzcat(ones(size(testInputs,1),1),testInputs)*weights; %using the coefficeints from part 1, make predicted y values for test set
    
    allPredictions(firstIndex:lastIndex) = yPredict; %for bootstrap of numeber 2
    
    results(1,j) = MSE_solver(yPredict, testOutputs); %calc and store MSE for testing set
    results(2,j) = sum(abs(weights) > .001); %number of non zero weights (with a little leway
    
    if j == 2 || j == 4 || j == 6 || j== 8 
        firstIndex = lastIndex+1;
        lastIndex = lastIndex+20;
    else
        firstIndex = lastIndex+1;
        lastIndex = lastIndex+19;
    end
end
sampleMean = mean(allPredictions); %for bootstrap of number 2
 
end