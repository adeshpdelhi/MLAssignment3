fprintf('Preprocessing...\n');
% MNIST read script from https://in.mathworks.com/matlabcentral/fileexchange/27675-read-digits-and-labels-from-mnist-database
fprintf('Loading testing dataset\n');
[imgstest labelstest] = readMNIST('t10k-images.idx3-ubyte', 't10k-labels.idx1-ubyte', 10000, 0);
fprintf('Loading training dataset\n');
[imgstrain labelstrain] = readMNIST('train-images.idx3-ubyte', 'train-labels.idx1-ubyte', 60000, 0);

fprintf('Reorganizing datasets for use by libSVM\n');
imgstest = permute(imgstest,[3,1,2]);
imgstrain = permute(imgstrain,[3,1,2]);

% newimgstrain = zeros(size(imgstrain,1),size(imgstrain,2),size(imgstrain,3));
% newlabelstrain = zeros(size(labelstrain,1));

% newimgstest = zeros(size(imgstest,1),size(imgstest,2),size(imgstest,3));
% newlabelstest = zeros(size(labelstest,1));

newimgstrain = [];
newlabelstrain = [];
newimgstest = [];
newlabelstest = [];

training_set_count = 2000;
testing_set_count = 500;
fprintf('Reducing dataset size to %d per class for training dataset and %d per class for testing dataset\n',training_set_count,testing_set_count);

for number = 0:9,
	fprintf('Processing %d... ',number);
	ichoices_train = labelstrain==number;
	while(sum(ichoices_train)~=training_set_count),
		find_ichoices_train = find(ichoices_train);
		random_index_for_find = randi(size(find_ichoices_train,1));
		random_index = find_ichoices_train(random_index_for_find);
		if(ichoices_train(random_index)==1)
			ichoices_train(random_index)=0;
		end
	end

	ilabelstrain = labelstrain(ichoices_train);
	iimgstrain = imgstrain(ichoices_train,:,:);

	newlabelstrain = [newlabelstrain; ilabelstrain];
	newimgstrain = [newimgstrain; iimgstrain];

	ichoices_test = labelstest==number;
	while(sum(ichoices_test)~=testing_set_count),
		find_ichoices_test = find(ichoices_test);
		random_index_for_find = randi(size(find_ichoices_test,1));
		random_index = find_ichoices_test(random_index_for_find);
		if(ichoices_test(random_index)==1)
			ichoices_test(random_index)=0;
		end
	end

	ilabelstest = labelstest(ichoices_test);
	iimgstest = imgstest(ichoices_test,:,:);
	
	newlabelstest = [newlabelstest; ilabelstest];
	newimgstest = [newimgstest; iimgstest];
	fprintf('Completed.\n');
end


imgstrain = newimgstrain;
labelstrain = newlabelstrain;
imgstest = newimgstest;
labelstest = newlabelstest;

fprintf('Randomizing...\n');
ichoices = randperm(length(labelstrain));
labelstrain = labelstrain(ichoices);
imgstrain = imgstrain(ichoices,:,:);

ichoices = randperm(length(labelstest));
labelstest = labelstest(ichoices);
imgstest = imgstest(ichoices,:,:);

fprintf('Preprocessing done!\n');