% Charles Liu
%11/05/2021
%usage: compare TP and FP specs in the same scale for visulization
% INPUTS:
%   TPSpec, FPSpec - (:,;,i) matrix, the audio data spectrogram, i given

% RETURNS:
%   mod_TP, mod_FP -  the modified matricea
%   mod_type - what changes?

function [mod_TP, mod_FP, mod_type] = Compare_TPFP(TPSpec, FPSpec);

    [aT,bT,cT] = size(TPSpec); %cT = 1
    [aF,bF,cF] = size(FPSpec); %cF = 1

    if aT == aF;
        mod_TP = TPSpec;
        mod_FP = FPSpec;
        mod_type = "no change";
    elseif aT > aF; % if the True positive has more bins, pad the FP with zeros
        mod_TP = TPSpec;
        mod_FP = zeros(aT, bT, cT);
        mod_FP(1:aF,1:bF,1) = FPSpec;
        mod_type = "pad FP";
    else 
        mod_TP = TPSpec;
        mod_FP = zeros(aT, bT, cT);
        mod_FP = FPSpec(1:aT,1:bT,1);
        mod_type = "cut FP";
    end
 
end

 
        