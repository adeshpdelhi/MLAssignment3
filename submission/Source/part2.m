fprintf('Training multiclass SVM\n');
fileID = fopen('part2result.txt','w');

labelstrain2 = labelstrain;
labelstest2 = labelstest;

max_C = 0.1;
% max_accuracy = 0;
% for c = [0.001,0.1,1,10,100,1000],
% 	fprintf('Trying c=%d \n',c);
% 	parameters = [' -t 0 -s 0 -c ',num2str(c)];
% 	parameters = strcat(parameters,' -h 0');
% 	% accuracy = svmtrain(labelstrain2,imgstrain,parameters);
% 	accuracy = get_cv_ac(labelstrain2,imgstrain,parameters, 5);
% 	if(accuracy>max_accuracy)
% 		max_C = c;
% 		max_accuracy = accuracy;
% 		fprintf('Updated max C is %d with max accuracy %f\n',max_C,max_accuracy);
% 	end
% 	fprintf(fileID,'C = %d  Accuracy %f\n',c,accuracy);

% end
% fclose(fileID);
% fprintf('Max accuracy is %f by %d\n',max_accuracy,max_C);


parameters = [' -t 0 -s 0 -c ',num2str(max_C)];
parameters = strcat(parameters,' -h 0');
model = ovrtrain(labelstrain2,imgstrain,parameters);
[predict_label, accuracy, dec_values] = ovrpredict(labelstest2, imgstest, model);
fprintf('Final accuracy is %f\n',accuracy(1,1));

scoreMatrix = [];
trueLabels = [];
for i=1:10,
	[predict_label, accuracy, dec_values] = svmpredict(double(labelstest2 == (i-1)), imgstest, model.models{i});
	scoreMatrix = [scoreMatrix;dec_values'];
	trueLabels = [trueLabels ; (labelstest2 == i-1)'];
end

[rocData, thdArr] = generate_roc(scoreMatrix,trueLabels,100,true);


multi1 = model.models{1};
multi2 = model.models{2};
multi3 = model.models{3};
multi4 = model.models{4};
multi5 = model.models{5};
multi6 = model.models{6};
multi7 = model.models{7};
multi8 = model.models{8};
multi9 = model.models{9};
multi10 = model.models{10};
save multi1 multi1;
save multi2 multi2;
save multi3 multi3;
save multi4 multi4;
save multi5 multi5;
save multi6 multi6;
save multi7 multi7;
save multi8 multi8;
save multi9 multi9;
save multi10 multi10;