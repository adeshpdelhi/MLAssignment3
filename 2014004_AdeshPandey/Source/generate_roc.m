function [rocData, thdArr] = generate_roc(scoreMatrix,trueLabels,nROCpts,plotROC)
% USAGE:
%       [rocData, thdArr] = generate_roc(scoreMatrix,trueLabels,nROCpts,plotROC)
% 
% Input Variables: 
%       scoreMatrix: nClasses x nTestPts score matrix
%       trueLabels:  nClasses x nTestPts binary indicator matrix with 1 and 0 representing membership and non-membership respectively 
%       nROCpts:     scalar value indicating number of points to be plotted on the ROC curve [default: 100]
%       plotROC:     logical variable for plotting the ROC curve [default: false]
% Output Variables:
%       rocData:     2 x nROCpts array with False Positive Rate (fpr) and True Positive Rate (tpr) for each threshold value.
%       thdArr:      1 x nROCpts array of the threshold values applied on the score matrix 

if(~exist('nROCpts','var'))
    nROCpts = 100;
end

if(~exist('plotROC','var'))
    plotROC = false;
end


tpr = zeros(1,nROCpts);
fpr = zeros(1,nROCpts);

trueLabels = logical(trueLabels);
nTrueLabels = sum(trueLabels(:));
nFalseLabels = sum(~trueLabels(:));

minScore = min(scoreMatrix(:));
maxScore = max(scoreMatrix(:));
rangeScore = maxScore - minScore;

thdArr = minScore + rangeScore*(0:1/(nROCpts-1):1);

for thd_i = 1:nROCpts,
    thd = thdArr(thd_i);
    thisLabel = scoreMatrix >= thd;
    tpr_mat = thisLabel & trueLabels;
    tpr(thd_i) = sum(tpr_mat(:))/nTrueLabels;
    fpr_mat = thisLabel & ~trueLabels;
    fpr(thd_i) = sum(fpr_mat(:))/nFalseLabels;
end

rocData = [fpr;tpr];

if(plotROC)
    figure;plot(rocData(1,:),rocData(2,:),'b.-');
    legend('show');
    title('ROC Curve');
    xlabel('False Positive Rate');
end
ylabel('True Positive Rate');

return;
end