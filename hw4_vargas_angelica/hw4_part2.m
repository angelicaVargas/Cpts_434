% Load the dataset
Z = csvread('glass_data_HW6.csv');
[rows, cols] = size(Z);
disp('Dataset size (rows, cols):')
disp([rows, cols])

% Prepare the design matrix
V = ones(rows, 10);
for k = 1:9
    V(:, k + 1) = Z(:, k);
end
y = Z(:, 10); % needed values

% Perform linear regression
A = V' * V;
b = V' * y;
w = A \ b;
fit = V * w;

% Calculate residuals and sum of squared error
r = fit - y;
sse = r' * r;

% Calculate R-squared value
ybar = sum(y) / rows;
var = y - ybar;
sst = var' * var;
rsq = (sst - sse) / sst;
disp('Coefficient of determination (R-squared):')
disp(rsq)

% Initialize confusion matrix
cmat = zeros(3, 3);

% Classify based on bin specifications
for i = 1:rows
    class = y(i);
    bin = 2; % default bin
    if (fit(i) < 1.5)
        bin = 1; 
    elseif (fit(i) > 2.5)
        bin = 6; 
    end

    % Enter info into confusion matrix
    if (bin == 1 && class == 1) cmat(1, 1) = cmat(1, 1) + 1; end
    if (bin == 2 && class == 1) cmat(2, 1) = cmat(2, 1) + 1; end
    if (bin == 6 && class == 1) cmat(3, 1) = cmat(3, 1) + 1; end
    if (bin == 1 && class == 2) cmat(1, 2) = cmat(1, 2) + 1; end
    if (bin == 2 && class == 2) cmat(2, 2) = cmat(2, 2) + 1; end
    if (bin == 6 && class == 2) cmat(3, 2) = cmat(3, 2) + 1; end
    if (bin == 1 && class == 6) cmat(1, 3) = cmat(1, 3) + 1; end
    if (bin == 2 && class == 6) cmat(2, 3) = cmat(2, 3) + 1; end
    if (bin == 6 && class == 6) cmat(3, 3) = cmat(3, 3) + 1; end
end

% Display confusion matrix
disp('Confusion matrix:')
disp(cmat)

% Totals for each class
tot1s = cmat(1, 1) + cmat(2, 1) + cmat(3, 1);
tot2s = cmat(1, 2) + cmat(2, 2) + cmat(3, 2);
tot6s = cmat(1, 3) + cmat(2, 3) + cmat(3, 3);
totall = tot1s + tot2s + tot6s;

disp('Total records in class 1, 2, and 6:')
disp([tot1s, tot2s, tot6s, totall])

% Calculate class specific accuracies
accur1s = cmat(1, 1) / tot1s;
accur2s = cmat(2, 2) / tot2s;
accur6s = cmat(3, 3) / tot6s;
accurall = (cmat(1, 1) + cmat(2, 2) + cmat(3, 3)) / totall;

disp('Accuracy for class 1, 2, 6, and overall accuracy:')
disp([accur1s, accur2s, accur6s, accurall])