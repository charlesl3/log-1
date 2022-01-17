% Charles Liu
%11/11/2021
%usage: find the TP benchmark to a FP for TP-FP comparison
% INPUTS:
%   TPSpec: whole TPSpec
%   FPSpec: one FPSpec matrix

% RETURNS:
% bench_TP: the closest TP to the given FP for comparison

function [bench_TP, ind_TP] = benchTP(FPSpec,TPSpec);
    TPSpec = reshape(TPSpec, size(TPSpec, 1) * size(TPSpec, 2), size(TPSpec, 3)); % vectorize
    FPSpec = FPSpec(:);
    [bench_TP,ind_TP] = min(sum((TPSpec - FPSpec).^2));
    %bench_TP = TPSpec(:,:,ind_TP); 
end

