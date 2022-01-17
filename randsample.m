% Charles Liu
%01/09/2021
%usage: find a random sample of an array without repetition
% INPUTS:
%   x: the full array 
%   n: number of samples

% RETURNS:
% y: sampled array   ind: position/index in the full array

function [y,ind] = randsample(x,n);
    ind = sort(randperm(numel(x),n));
    y = x(ind);
end