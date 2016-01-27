function MSE = MSE_solver(y_estimate, y)

MSE= y_estimate - y; %subtract the elements
MSE = MSE.^2;  %square em
MSE = mean(MSE); %average them for the mean
end