% preprocess;

ichoices_train_3 = labelstrain==3;
ichoices_train_8 = labelstrain==8;
ichoices_train_3_8 = logical(ichoices_train_3 + ichoices_train_8);

ichoices_test_3 = labelstest==3;
ichoices_test_8 = labelstest==8;
ichoices_test_3_8 = logical(ichoices_test_3 + ichoices_test_8);

size(imgstrain)
size(labelstrain)
labelstrain_3_8 = labelstrain(ichoices_train_3_8);
imgstrain_3_8 = imgstrain(ichoices_train_3_8,:,:);

labelstest_3_8 = labelstest(ichoices_test_3_8);
imgstest_3_8 = imgstest(ichoices_test_3_8,:,:);

fprintf('Training binary SVM\n');
% [Parameters, nr_class, totalSV, rho, Label, sv_indices, ProbA, ProbB, nSV, sv_coef, SVs] = svmtrain(labelstrain_3_8,imgstrain_3_8,'-t 0 -h 0');
model = svmtrain(labelstrain_3_8,imgstrain_3_8,'-t 0 -h 0')
