%Use linfit 2D to model nutritional rating of cereals with sugar and fiber as predictors. Report R2 and s. 

%Use linfit3D to consider protein, fat, and sodium separately as a third attribute, 
%in addition to sugar and fiber, to predict the nutritional rating cereals.

%Report the change in R2 and s, relative to results with fiber and sugar for each case.

% get cereals data
Z=csvread('Cereals no alpha.csv');
[rows,cols] = size(Z);
disp([rows, cols])
sugar = Z(:,7);
fiber = Z(:,5);
rating = Z(:, 13);
protein = Z(:, 2);
fat = Z(:, 3);
sodium = Z(:, 4);

% use linfit2D model with sugar and fiber
[b0,b1,b2,rsq,s,F,StdRes] = linfit2D(sugar,fiber,rating);
disp(['R² for sugar and fiber: ', num2str(rsq)])
disp(['s for sugar and fiber: ', num2str(s)])

% use linfit3D model with protein
[b0_1,b1_1,b2_1,b3_1,rsq_1,s_1,StdRes_1] = linfit3D(sugar,fiber,protein,rating);
disp(['R² for sugar, fiber, and protein: ', num2str(rsq_1)])
disp(['s for sugar, fiber, and protein: ', num2str(s_1)])

% use linfit3D model with fat
[b0_2,b1_2,b2_2,b3_2,rsq_2,s_2,StdRes_2] = linfit3D(sugar,fiber,fat,rating);
disp(['R² for sugar, fiber, and fat: ', num2str(rsq_2)])
disp(['s for sugar, fiber, and fat: ', num2str(s_2)])

% use linfit3D model with sodium
[b0_3,b1_3,b2_3,b3_3,rsq_3,s_3,StdRes_3] = linfit3D(sugar,fiber,sodium,rating);
disp(['R² for sugar, fiber, and sodium: ', num2str(rsq_3)])
disp(['s for sugar, fiber, and sodium: ', num2str(s_3)])

% report change in rsq and s to results for each case
disp(['Change in R² for protein: ', num2str(rsq_1 - rsq)])
disp(['Change in s for protein: ', num2str(s_1 - s)])

disp(['Change in R² for fat: ', num2str(rsq_2 - rsq)])
disp(['Change in s for fat: ', num2str(s_2 - s)])

disp(['Change in R² for sodium: ', num2str(rsq_3 - rsq)])
disp(['Change in s for sodium: ', num2str(s_3 - s)])