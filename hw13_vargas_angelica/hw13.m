load simplecluster_dataset.MAT
inputs = simplecluster_dataset;

% perform SOM 5x5 output grid
d1 = 5;
d2 = 5;
net = selforgmap([d1, d2]);  % SOM with 25 nodes

% train the SOM
[net, tr] = train(net, inputs);
outputs = net(inputs);  % map inputs to SOM nodes

% report hits
figure, plotsomhits(net, inputs);
title('Hits Display');

% report UMAT
figure, plotsomnd(net);
title('UMAT Display');

% report weight positions
figure, plotsompos(net, inputs);
title('Weight Positions Display');

SeedC=net.IW(1);
w=cell2mat(SeedC(1)); %SOM weights

% calculate DBI
DBI=evalclusters(inputs', 'kmeans', 'DaviesBouldin', 'klist', 2:6);
plot(DBI);
title('Davies-Bouldin Index Plot');

% kmeans clustering for 4 clusters
clusters=4;
[idx,C]=kmeans(inputs',clusters); %centoids

% initialize variables
meandist=0;

% loop over clusters
for i=1:clusters
    for k=1:25
        dist(k)=(C(i,1)-w(k,1))^2+(C(i,2)-w(k,2))^2;
    end

    % find SOM node closest to the centroid
    kmin=1;
    mindist=dist(1);
    for k=2:25
        if dist(k)<mindist
            kmin=k;
            mindist=dist(k);
        end
    end
    disp('Cluster, closest node, and distance: ')
    disp([i,kmin,mindist])  % display cluster, closest node, and distance
    meandist=meandist+mindist;
end
meandist=meandist/clusters;  % average minimum distance
disp('Average min separation');
disp(meandist) %average min separation
