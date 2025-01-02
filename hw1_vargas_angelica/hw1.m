% add data points for x and y
% data based on the example shown in slide 10
x = [2, 2, 3, 4, 4, 5, 6, 7, 8, 9, 5]';
y = [10, 11, 12, 13, 14, 15, 20, 18, 22, 25, 20]';

% call linfit to perform linear regression on the data
[b0,b1,rsq,StdErrEst,StdRes] = linfit(x,y);

% display parameters
disp(['b0 = ', num2str(b0)]);
disp(['b1 = ', num2str(b1)]);
disp(['Standard Error = ', num2str(StdErrEst)]);
disp(['r^2 = ', num2str(rsq)]);

% calc fitted values using the linear regression model
fit = b0 + b1 * x;

% plot fitted line on x-axis
plot(x, fit);

hold on; % hold current plot to overlay the data points

% plot original data points (x, y) as stars ('*')
plot(x, y, '*');

% label last data point
last_x = x(end);
last_y = y(end);
text(last_x, last_y, ['(', num2str(last_x), ', ', num2str(last_y), ')'], ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');

hold off; % release hold on the current plot

% calc residual for the new data point
residual_new_point = y(end) - (b0 + b1 * x(end));

% standardize residual
standardized_residual_new_point = residual_new_point / StdErrEst;

% display standardized residual
disp(['Standardized Residual for New Data Point: ', num2str(standardized_residual_new_point)]);

% check if new data point is an outlier
if abs(standardized_residual_new_point) > 2
    disp('The new data point is an outlier.');
else
    disp('The new data point is not an outlier.');
end