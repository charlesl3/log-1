% Charles Liu
%01/09/2021
%usage: return the confusion table
% INPUTS:
%   TP,FN,FP,TN logic arrays

% RETURNS:
% mltable: the table

function mltable = confusionMat(TP,FN,FP,TN);
    PP = sum(TP)+sum(FP);
    PN = sum(FN)+sum(TN);
    P = sum(TP)+sum(FN);
    N = sum(FP)+sum(TN);
    target = {'target';'non-target';'NA';'na'};
    pred_positive = [sum(TP);sum(FP);sum(TP)/PP;sum(FP)/PP];
    pred_negative = [sum(FN);sum(TN);sum(FN)/PN;sum(TN)/PN]; 
    pred_positive_rate = [sum(TP)/P;sum(FP)/N;NaN;NaN];
    pred_negative_rate = [sum(FN)/P;sum(TN)/N;NaN;NaN];
    mltable = table(pred_positive,pred_negative,pred_positive_rate,pred_negative_rate,'RowNames',target);   
end
