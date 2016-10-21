fprintf('Training multiclass SVM\n');

max_C = 0;
max_accuracy = 0;
for c = [1,2,5],
	fprintf('Trying c=%d xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxXXXXxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n',c);
	parameters = [' -t 0 -v 5 -s 0 -c ',num2str(c)];
	parameters = strcat(parameters,' -h 0');
	accuracy = svmtrain(labelstrain,imgstrain,parameters);
	if(accuracy>max_accuracy)
		max_C = c;
		max_accuracy = accuracy;
		fprintf('Updated max C is %d wth max accuracy %f\n',max_C,max_accuracy);
	end
end
fprintf('Max accuracy is %f by %d\n',max_accuracy,max_C);


parameters = [' -t 0 -s 0 -c ',num2str(max_C)];
parameters = strcat(parameters,' -h 0');
model = svmtrain(labelstrain,imgstrain,parameters);
[predict_label, accuracy, dec_values] = svmpredict(labelstest, imgstest, model);
fprintf('Final accuracy is %f\n',accuracy(1,1));