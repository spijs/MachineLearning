function [projQ, projI] = preprocess(trainingCaption, trainingImages, testQueries, testImages, k)

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
[row, col] = size(imageCorr);
[rowq,colq] = size(queryCorr);
dimI = col * k
resI = zeros(row,dim);
resQ = zeros(rowq,dim);
for l = 1:row
	resI(l,:) = imageCorr(l,1:dim);
end

for l = 1:rowq
	resQ(l,:) = queryCorr(l,1:dim);
end	
[projQ1, projI1] = proj(testI,testQ, reqI, resQ);
size(projQ1)
size(projI1)
projQ = projQ1;
projI = projI1;
dlmwrite('projectedQ_'+k, projQ);
dlmwrite('projectedI_'+k, projI);