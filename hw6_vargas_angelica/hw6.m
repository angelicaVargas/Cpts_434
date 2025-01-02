w = [1; 1];  % weight vector
xp = [0.3678; 0.3678];  % closest member-class point
x0 = [0.1353; 1];  % closest non-member-class point

% call function
[b, margin] = bias_equal_margins(w, xp, x0);

% calculate x and y intercepts
x_intercept = -b / w(1);
y_intercept = -b / w(2);

% display results
disp(['Bias b: ', num2str(b)])
disp(['Margin: ', num2str(margin)])
disp(['X-intercept: ', num2str(x_intercept)])
disp(['Y-intercept: ', num2str(y_intercept)])