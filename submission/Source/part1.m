ichoices_train_3 = labelstrain==3;
ichoices_train_8 = labelstrain==8;
ichoices_train_3_8 = logical(ichoices_train_3 + ichoices_train_8);

ichoices_test_3 = labelstest==3;
ichoices_test_8 = labelstest==8;
ichoices_test_3_8 = logical(ichoices_test_3 + ichoices_test_8);

labelstrain_3_8 = labelstrain(ichoices_train_3_8);
imgstrain_3_8 = imgstrain(ichoices_train_3_8,:);

labelstest_3_8 = labelstest(ichoices_test_3_8);
imgstest_3_8 = imgstest(ichoices_test_3_8,:);

fprintf('Training binary SVM\n');

max_C = 0;
max_accuracy = 0;
for c = [1,2,5,10,50,100],
	parameters = [' -t 0 -v 5 -c ',num2str(c)];
	parameters = strcat(parameters,' -h 0');
	accuracy = svmtrain(labelstrain_3_8,imgstrain_3_8,parameters);
	% [predict_label, accuracy, dec_values] = svmpredict(labelstrain_3_8, imgstrain_3_8, model);
	if(accuracy>max_accuracy)
		max_C = c;
		max_accuracy = accuracy;
		fprintf('Updated max C is %d wth max accuracy %f\n',max_C,max_accuracy);
	end
end
fprintf('Max accuracy is %f by %d\n',max_accuracy,max_C);


parameters = [' -t 0 -c ',num2str(max_C)];
parameters = strcat(parameters,' -h 0');
model = svmtrain(labelstrain_3_8,imgstrain_3_8,parameters);
[predict_label, accuracy, dec_values] = svmpredict(labelstest_3_8, imgstest_3_8, model);
fprintf('Best prediction is %f',accuracy(1,1));