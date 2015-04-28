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

[imageCorr,queryCorr, r] = canoncorr(bigTrain,trainqueries);
disp('Dimensie U');
size(imageCorr)
disp('Dimensie V');
size(queryCorr)
[projectedQ, projectedI] = proj(testI,testQ, imageCorr, queryCorr);
size(projectedQ)
size(projectedI)
projQ = projectedQ.';
projI = projectedI.';