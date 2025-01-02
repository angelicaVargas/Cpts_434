Z=readmatrix('hw10.csv');
[rows,cols]=size(Z);
disp('Dataset size (rows, cols):')
disp([rows,cols])

% separate actual and predicted labels into separate variables
labels = Z(:,1); % Actual labels
fit = Z(:,2); % Predicted labels
% disp ([labels(1),fit(1)])

% initialize a 2x2 confusion matrix
cmat = zeros(2,2);

% loop through each example in the dataset
for i = 1:rows
 class = labels(i); % Get the actual class label
 bin = 1; % Initialize bin as 1 (assuming the default class is 1)

 % if predicted value is greater than 3, assign it to class 5
 if(fit(i) > 3)bin = 5;end

 % fill matrix based on actual and predicted values
 if(bin == 1 && class == 1)cmat(1,1) = cmat(1,1) + 1;end
 if(bin == 5 && class == 1)cmat(2,1) = cmat(2,1) + 1;end
 if(bin == 5 && class == 5)cmat(2,2) = cmat(2,2) + 1;end
 if(bin == 1 && class == 5)cmat(1,2) = cmat(1,2) + 1;end
end

% display confusinon matrix
disp('Confusion matrix:')
disp(cmat)

% calculate total counts for each class
tot1s = cmat(1,1) + cmat(2,1);
tot5s = cmat(2,2) + cmat(1,2);
totall = tot1s + tot5s;

% display totals for each class and overall
disp('Class membership 1, 2 and overall total')
disp([tot1s, tot5s, totall]);

% calc accuracy for class 1,5
accurs1 = cmat(1,1) / tot1s;
accur5s = cmat(2,2) / tot5s;

% accuracy w/ correct predictionss
accurall = (cmat(1,1) + cmat(2,2)) / totall;

% disp the accuracies for class 1, class 5, and overall accuracy
disp('Accuracy of class assignment 1, 2 and overall accuracy');
disp([accurs1, accur5s, accurall]);
