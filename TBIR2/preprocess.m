function [projQ, projI] = preprocess(trainingCaption, trainingImages, testQueries, testImages)

trainqueries = dlmread(trainingCaption);
trainimages = dlmread(trainingImages);
testQ = dlmread(testQueries);
testI = dlmread(testImages);

[x,y] = size(trainimages)
bigTrain = zeros(5*x,y);
for i = 1:x
    for j=0:4
       bigTrain(i+j,:) = trainimages(i,:);
    end
end

[U,V, r] = cca(bigTrain.',trainqueries.');
disp('Dimensie U');
size(U)
disp('Dimensie V');
size(V)
[projectedQ, projectedI] = proj(testI,testQ, U, V);
projQ = projectedQ.'
projI = projectedI.'