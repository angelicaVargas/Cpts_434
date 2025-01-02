% Load the CSV dataset (replace with the actual CSV filename)
data = readtable('one-five-424-no label.csv');  % Replace with your file name

% Convert the table to an array (if needed, depending on the dataset format)
inputs = table2array(data);

% Perform clustering evaluation and calculate Davies-Bouldin Index for k = 2 to 6
DBI = evalclusters(inputs, 'kmeans', 'DaviesBouldin', 'klist', 2:6);  % 'inputs' should be a matrix of data points

% Plot the Davies-Bouldin Index
figure;
plot(DBI);
title('Davies-Bouldin Index for k = 2 to 6 clusters');
xlabel('Number of Clusters');
ylabel('Davies-Bouldin Index');

% Display the best number of clusters based on the DBI
disp(['Optimal number of clusters: ', num2str(DBI.OptimalK)]);

% For k = 4 clusters (example), perform k-means clustering:
clusters = 4;  % Change as needed
[idx, C] = kmeans(inputs, clusters);  % Perform k-means clustering

% Initialize variables for calculating the mean distance
meandist = 0;

% Loop over clusters to find the closest SOM node and calculate distances
for i = 1:clusters
    % Initialize distance array for each centroid
    dist = zeros(25, 1);  % Assuming SOM has 25 nodes (5x5 grid)
    for k = 1:25
        dist(k) = (C(i, 1) - w(k, 1))^2 + (C(i, 2) - w(k, 2))^2;
    end

    % Find the SOM node closest to the centroid
    [mindist, kmin] = min(dist);  % Get the minimum distance and corresponding node index
    disp(['Cluster ', num2str(i), ', closest node: ', num2str(kmin), ', distance: ', num2str(mindist)]);

    % Accumulate the minimum distances to calculate average
    meandist = meandist + mindist;
end

% Calculate and display the average minimum separation
meandist = meandist / clusters;
disp(['Average minimum separation: ', num2str(meandist)]);
