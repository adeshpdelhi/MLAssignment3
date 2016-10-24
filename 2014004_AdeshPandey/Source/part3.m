fprintf('Training RBF kernel SVM here\n');

labelstrain3 = labelstrain;
labelstest3 = labelstest;

max_C = 10;
max_G = 0.000001;

%BELOW IS THE CODE FOR CROSS VALIDATION
% max_accuracy = 0;
% for c = [1,10,100],
% 	for g = [0.0000001,0.000001,0.00001],
% 		parameters = [' -t 0 -g ',num2str(g),' -s 0 -c ',num2str(c)];
% 		parameters = strcat(parameters,' -h 0');
% 		accuracy = get_cv_ac(labelstrain3,imgstrain,parameters, 5);
% 		if(accuracy>max_accuracy)
% 			max_C = c;
% 			max_G = g;
% 			max_accuracy = accuracy;
% 		end
% 	end
% end
% fprintf('Max accuracy is %f by %d %d\n',max_accuracy,max_C,max_G);


parameters = [' -t 0 -g 0.000001 -s 0 -c ',num2str(max_C)];
parameters = strcat(parameters,' -h 0');
model = ovrtrain(labelstrain3,imgstrain,parameters);
[predict_label, accuracy, dec_values] = ovrpredict(labelstest3, imgstest, model);
fprintf('Final accuracy is %f\n',accuracy(1,1));
save Rbf model;

scoreMatrix = [];
trueLabels = [];
for i=1:10,
	[predict_label, accuracy, dec_values] = svmpredict(double(labelstest3 == (i-1)), imgstest, model.models{i});
	scoreMatrix = [scoreMatrix;dec_values'];
	trueLabels = [trueLabels ; (labelstest3 == i-1)'];
end

[rocData, thdArr] = generate_roc(scoreMatrix,trueLabels,100,true);

rbf1 = model.models{1};
rbf2 = model.models{2};
rbf3 = model.models{3};
rbf4 = model.models{4};
rbf5 = model.models{5};
rbf6 = model.models{6};
rbf7 = model.models{7};
rbf8 = model.models{8};
rbf9 = model.models{9};
rbf10 = model.models{10};
save Rbf1 rbf1;
save Rbf2 rbf2;
save Rbf3 rbf3;
save Rbf4 rbf4;
save Rbf5 rbf5;
save Rbf6 rbf6;
save Rbf7 rbf7;
save Rbf8 rbf8;
save Rbf9 rbf9;
save Rbf10 rbf10;
