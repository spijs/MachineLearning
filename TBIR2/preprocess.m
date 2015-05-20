% This function applies CCA to the trainingcaption and trainingimages matrix
% The resulting correlation matrices are truncated to k % of their dimensions
% Finally, the testQueries and testImages are projected onto the multimodal space defined by the CCA results
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

[U,V] = canoncorr(trainqueries,bigTrain);
[row, col] = size(V);
[rowq,colq] = size(U);
dim = col * (k/100);
resV = zeros(row,dim);
resU = zeros(rowq,dim);
for l = 1:row
	resV(l,:) = V(l,1:dim);
end

for l = 1:rowq
	resU(l,:) = U(l,1:dim);
end	
[projQ, projI] = proj(testI,testQ, resV, resU);
dlmwrite(strcat('projectedQ_',num2str(k),'.txt'), projQ);
dlmwrite(strcat('projectedI_',num2str(k),'.txt'), projI);