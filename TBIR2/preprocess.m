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

[imageCorr,queryCorr] = canoncorr(bigTrain,trainqueries);
disp('Dimensie U');
size(imageCorr)
disp('Dimensie V');
size(queryCorr)
[projQ1, projI1] = proj(testI,testQ, imageCorr, queryCorr);
size(projQ1)
size(projI1)
projQ = projQ1;
projI = projI1;