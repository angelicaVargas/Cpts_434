%trashImds = imageDatastore(‘C:\Users\jhmiller\Documents\MATLAB\MATLAB CNN\trashnet5F’,
%'IncludeSubfolders',true,'LabelSource','foldernames’);
flowerImds = imageDatastore("test Flowers","IncludeSubfolders",true,"LabelSource","foldernames");

% Get number of objects, number of classes, and display objects per class as a histogram
numObs = length(flowerImds.Labels);
disp(numObs)

numClasses = numel(categories(flowerImds.Labels));
disp(numClasses)

numObsPerClass = countEachLabel(flowerImds);

histogram(flowerImds.Labels)
set(gca,'TickLabelInterpreter','none')

%Check that the data is as expected by viewing a random selection of images
numObsToShow = 8;
idx = randperm(numObs, numObsToShow);
figure(1)
imshow(imtile(flowerImds.Files(idx), 'GridSize', [2 4], 'ThumbnailSize', [100 100]))

%view images that belong to a specific class
class="crocus";
idxClass = find(flowerImds.Labels == class);
idx=randsample(idxClass, numObsToShow);
figure(2)
imshow(imtile(flowerImds.Files(idx), 'GridSize', [2 4], 'ThumbnailSize', [100 100]));

%Split into training and testing sets
split=0.6;
[trainImgs,testImgs] = splitEachLabel(flowerImds,split,'randomized');

%Define an augmentation scheme
imageAugmenter = imageDataAugmenter('RandRotation',[-90 90],'RandScale',[1 2],'RandXReflection', true);

%get googlenet
net = googlenet;

%Get the layers from GoogLeNet
lgraph = layerGraph(net);

%Get input size
inputSize = net.Layers(1).InputSize;
disp(inputSize)

%Define the augmented image datastore fo training
augFlowerImds = augmentedImageDatastore(inputSize,trainImgs,'DataAugmentation',imageAugmenter);

%Modify the classification and output layers
newFc = fullyConnectedLayer(numClasses,"Name","new_fc");
lgraph = replaceLayer(lgraph,"loss3-classifier",newFc);
newOut = classificationLayer("Name","new_out");
lgraph = replaceLayer(lgraph,"output",newOut);

%Lower the learning rate for transfer learning
options = trainingOptions("sgdm","InitialLearnRate", 0.001);

%perform training 30 epochs 3min 11sec on calipso
[flowernet,info] = trainNetwork(augFlowerImds, lgraph, options);

%Use the trained network to classify test images
%resizedtestImages=augmentedImageDatastore(inputSize,testImgs);
testpreds = classify(flowernet,testImgs);

%Calculate the accuracy
accuracy=nnz(testpreds == testImgs.Labels)/numel(testpreds)

%Visualize the confusion matrix
figure(3)
confusionchart(testImgs.Labels,testpreds);

