% Write a script to use linfit2D for regression of nutritional rating vs sodium and fiber. Report b0, bs, bf, r2, s, and F. Plot standard residuals as a function of fit.

% Expand your script to use inference2D to calculate 95% confidence intervals on slopes bs and bf. 
% Use the regression model to predict nutritional rating of cereals with 200 units of sodium and 5 units of fiber.
% Find the 95% confidence intervals on prediction of the mean nutritional rating for a population of cereals with 200 units of sodium and 5 units of fiber.
% Find the 95% confidence intervals on prediction of nutritional rating for a random cereal with 200 units of sodium and 5 units of fiber.

% get cereals data 
Z=csvread('Cereals no alpha.csv'); 
[rows,cols] = size(Z); 
disp([rows, cols]) 

fiber = Z(:,5); 
sodium = Z(:, 4);
rating = Z(:, 13); 

% use linfit2D model with sodium and fiber 
[b0,bs,bf,rsq,s,F,StdRes] = linfit2D(sodium,fiber,rating); 

% display regression results
disp(['Intercept (b0): ', num2str(b0)]);
disp(['Slope for sodium (bs): ', num2str(bs)]);
disp(['Slope for fiber (bf): ', num2str(bf)]);
disp(['R²: ', num2str(rsq)]);
disp(['Standard error of estimation (s): ', num2str(s)]);
disp(['F-statistic (F): ', num2str(F)]);

% plot standard residuals as function of fit
fit = b0 + bs*sodium + bf*fiber;
plot(fit,StdRes,"*");
title('Standard Residuals as a funcition of fit');
xlabel('Fit');
ylabel('Standardized Residuals');

% calc 95% confidence intervals for bs and bf
pptdist = 1.96;  % 95% confidence interval, assuming normal distribution
[dbs,dbf,dypbar,dypran] = inference2D(sodium,fiber,s,pptdist);

% display confidence intervals for slopes
disp(['95% CI for slope bs (sodium): [', num2str(bs - dbs), ', ', num2str(bs + dbs), ']']);
disp(['95% CI for slope bf (fiber): [', num2str(bf - dbf), ', ', num2str(bf + dbf), ']']);

% prediction of nutritional rating for a cereal with 200 sodium and 5 fiber
new_sodium = 200;
new_fiber = 5;
predicted_rating = b0 + bs*new_sodium + bf*new_fiber;
disp(['Predicted nutritional rating for 200 sodium and 5 fiber: ', num2str(predicted_rating)]);

% calc 95% confidence intervals on prediction of mean nutritional rating
CI_mean_lower = predicted_rating - dypbar;
CI_mean_upper = predicted_rating + dypbar;

% display 95% confidence interval for mean prediction
disp(['95% CI for mean nutritional rating of a population: [', num2str(CI_mean_lower), ', ', num2str(CI_mean_upper), ']']);

% calc 95% confidence intervals with prediction numbers
CI_lower = predicted_rating - dypran;
CI_upper = predicted_rating + dypran;

% display 95% confidence interval for individual prediction
disp(['95% CI for nutritional rating of a random cereal: [', num2str(CI_lower), ', ', num2str(CI_upper), ']']);