%problem 1 - 3

% this function finds both the coeficcients matrix and the y values for a 
% multivariate regression
function [weights, lambda] = multivariate_regression_solver(x,y)
%X is the matrix of values 
%y is the response vector



    %the design matrix (we need to put a 1 at the begining of x)
   



    %need to find the parameter vector p
    
    %ridge attempt
    %--------------------------------------------------------------------------
    oldError = 0;
    temp = ones(size(x, 1),1);
    X = horzcat(temp, x); % just add a row of ones to the begining
    I = eye(size(X,2));
    lambda = .015;
    for i = 1:500
      weights = (inv((X.')*X +lambda *I)*(X.'))*y;
      if sum(weights.^2) > .2 %the C value
          lambda = abs(lamdba)*1.2; %increase lambda
          disp( lambda);
          continue; %skip this round
      end
      ypredict = X*weights;
      error = y - ypredict;
      lambda = lambda + (mean(error)); %if error went down we add more lambda, otherwise we do down
%       disp(i);
%       disp(sum(weights.^2));
%       disp( lambda);
%       disp(mean(error));
      if lambda <= 0 %can't be less than zero
          lambda = 0;
      end
      
       if abs(mean(oldError)) - abs(mean(error)) <= .0000001 %if things really aren't changing 
           break; %we can break early
       end
      
      oldError = error; %otherwise the new error is equal to the old and repeat
      
    end
    

  
end