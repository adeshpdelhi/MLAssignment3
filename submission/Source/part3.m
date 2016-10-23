fprintf('Training RBF kernel SVM\n');

labelstrain3 = labelstrain;
labelstest3 = labelstest;

max_C = 0.1;
% max_accuracy = 0;
% for c = [0.1],
% 	fprintf('Trying c=%d xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxXXXXxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n',c);
% 	parameters = [' -t 2 -s 0 -c ',num2str(c)];
% 	parameters = strcat(parameters,' -h 0');
% 	% accuracy = svmtrain(labelstrain3,imgstrain,parameters);
% 	accuracy = get_cv_ac(labelstrain3,imgstrain,parameters, 5);
% 	if(accuracy>max_accuracy)
% 		max_C = c;
% 		max_accuracy = accuracy;
% 		fprintf('Updated max C is %d wth max accuracy %f\n',max_C,max_accuracy);
% 	end
% end
% fprintf('Max accuracy is %f by %d\n',max_accuracy,max_C);


parameters = [' -t 0 -s 0 -c ',num2str(max_C)];
parameters = strcat(parameters,' -h 0');
model = ovrtrain(labelstrain3,imgstrain,parameters);
[predict_label, accuracy, dec_values] = ovrpredict(labelstest3, imgstest, model);
fprintf('Final accuracy is %f\n',accuracy(1,1));
% save multi.mat model;


scoreMatrix = [];
trueLabels = [];
for i=1:10,
	[predict_label, accuracy, dec_values] = svmpredict(double(labelstest3 == (i-1)), imgstest, model.models{i});
	scoreMatrix = [scoreMatrix;dec_values'];
	trueLabels = [trueLabels ; (labelstest3 == i-1)'];
end

[rocData, thdArr] = generate_roc(scoreMatrix,trueLabels,100,true);
