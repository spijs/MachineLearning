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
disp('Dimensie V');
size(V)
disp('Dimensie U');
size(U)
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
[projQ1, projI1] = proj(testI,testQ, resV, resU);
size(projQ1)
size(projI1)
projQ = projQ1;
projI = projI1;
dlmwrite(strcat('projectedQ_',num2str(k),'.txt'), projQ);
dlmwrite(strcat('projectedI_',num2str(k),'.txt'), projI);