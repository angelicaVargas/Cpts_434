% get cereals data
Z=csvread('Cereals no alpha.csv');
[rows,cols] = size(Z);
disp([rows, cols])
fiber = Z(:,5);
rating = Z(:, 13);
protein = Z(:, 2);

% use linfit to fit a line to the rating of cereals as a function of fiber
[b0,b1,rsq,s,StdRes] = linfit(fiber,rating);

fprintf("- Q1 - \n")
% display intercept, slope, rsq and s
disp(['Intercept (b0): ', num2str(b0)])
disp(['Slope (b1): ', num2str(b1)])
disp(['R-squared (coefficient of determination): ', num2str(rsq)])
disp(['Standard Error of Estimation: ', num2str(s)])

fprintf("- Q2a - \n")
% use linfit2D for regression on rating as function of protein and fiber
[b0_2,b1_2,b2_2,rsq_2,s_2,F_2,StdRes_2] = linfit2D(protein,fiber,rating);

% display intercept and slopes
disp(['Intercept (b0): ', num2str(b0_2)])
disp(['Slope for protein (b1): ', num2str(b1_2)])
disp(['Slope for fiber (b2): ', num2str(b2_2)])

fprintf("- Q2b -\n")
% display values rsq and s
disp(['R-squared: ', num2str(rsq_2)])
disp(['Standard Error of Estimate (s): ', num2str(s_2)])
disp(['F-statistic: ', num2str(F_2)])

% changes in values of rsq and s
disp(['Change in R-squared: ', num2str(rsq_2 - rsq)])
disp(['Change in Standard Error: ', num2str(s_2 - s)])

fprintf("- Q3 -\n")
pptdist = 1.9926;
[db1,db2,dypbar,dypran] = inference2D(protein,fiber,s_2,pptdist);

% confidence intervals for slopes of protein and fiber (from problem 2)
disp(['CI for slope of protein: ', num2str(b1_2 - db1), ' , ', num2str(b1_2 + db2)])
disp(['CI for slope of fiber: ', num2str(b2_2 - db2), ' , ', num2str(b2_2 + db2)])

fprintf("- Q4a -\n")
% prediction of regression model for rating of new cereal protein and fiber
new_protein = 3;
new_fiber = 5;
predicted_rating = b0_2 + b1_2*new_protein + b2_2*new_fiber;
disp(['Predicted rating for 3g protein and 5g fiber: ', num2str(predicted_rating)]);

fprintf("- Q4b -\n")
% display CI for mean prediction
CI_mean_lower = predicted_rating - dypbar;
CI_mean_upper = predicted_rating + dypbar;
disp(['CI for mean rating: ', num2str(CI_mean_lower), ' , ', num2str(CI_mean_upper)]);

fprintf("- Q4c -\n")
% display CI for random cereal prediction
CI_lower = predicted_rating - dypran;
CI_upper = predicted_rating + dypran;
disp(['CI for random cereal rating: ', num2str(CI_lower), ' , ', num2str(CI_upper)]);
