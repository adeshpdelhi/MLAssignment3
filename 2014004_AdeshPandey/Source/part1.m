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

labelstrain_3_8(labelstrain_3_8 == 3) = 1;
labelstrain_3_8(labelstrain_3_8 == 8) = -1;

labelstest_3_8(labelstest_3_8 == 3) = 1;
labelstest_3_8(labelstest_3_8 == 8) = -1;


fprintf('Training binary SVM\n');

max_C = 0.1;
fileID = fopen('part1result.txt','w');
max_accuracy = 0;
for c = [0.0001, 0.001,0.1,1,10,100],
	fprintf('Testing c = %d\n',c);
	parameters = ['-t 0 -v 5 -c ',num2str(c)];
	parameters = strcat(parameters,' -h 0');
	accuracy = svmtrain(labelstrain_3_8,imgstrain_3_8,parameters);
	if(accuracy>max_accuracy)
		max_C = c;
		max_accuracy = accuracy;
		fprintf('Updated max C is %d with max accuracy %f\n',max_C,max_accuracy);
	end
	fprintf(fileID,'C = %d  Accuracy %f\n',c,accuracy);
end
fclose(fileID);
fprintf('Max accuracy is %f by %d\n',max_accuracy,max_C);


parameters = ['-t 0 -c ',num2str(max_C)];
parameters = strcat(parameters,' -h 0');

model = svmtrain(labelstrain_3_8,imgstrain_3_8,parameters);
[predict_label1, accuracy1, dec_values1] = svmpredict(labelstest_3_8, imgstest_3_8, model);
fprintf('Final accuracy is %f\n',accuracy1(1,1));

model_linear = model;
save LinearMod.mat model_linear;


%%%% plotting ROC start

indexpos = labelstrain_3_8 == 1;
indexneg = labelstrain_3_8 == -1;

labelstrain_3_8(indexpos) = -1;
labelstrain_3_8(indexneg) = 1;

indexpos = labelstest_3_8 == 1;
indexneg = labelstest_3_8 == -1;

labelstest_3_8(indexpos) = -1;
labelstest_3_8(indexneg) = 1;

model = svmtrain(labelstrain_3_8,imgstrain_3_8,parameters);
[predict_label2, accuracy2, dec_values2] = svmpredict(labelstest_3_8, imgstest_3_8, model);

scoreMatrix = [dec_values1'; dec_values2'];
size(scoreMatrix);
trueLabels = [(labelstest_3_8 == -1)' ; (labelstest_3_8 == 1)']; %reverse labels
size(trueLabels);

[rocData, thdArr] = generate_roc(scoreMatrix,trueLabels,100,true);

%%%% plotting ROC end

