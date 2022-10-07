function [hl1 hl2 hl3 hl4 hl5 ol] = crann(cfeat, chn, cclass)
% generates hidden and output ANN weight matrices
% cfeat - number of features 
% chn - number of neurons in the hidden layer
% cclass - number of neurons in the outpur layer (= number of classes)

% hl - hidden layer weight matrix
% ol - output layer weight matrix
% ATTENTION: we assume that constant value IS NOT INCLUDED (BIAS????) 
    
    hl1 = (rand(cfeat + 1, chn(1)) - 0.5) / sqrt(cfeat + 1);
    hl2 = (rand(chn(1) + 1, chn(2)) - 0.5) / sqrt(chn(1) + 1);
    hl3 = (rand(chn(2) + 1, chn(3)) - 0.5) / sqrt(chn(2) + 1);
    hl4 = (rand(chn(3) + 1, chn(4)) - 0.5) / sqrt(chn(3) + 1);
    hl5 = (rand(chn(4) + 1, chn(5)) - 0.5) / sqrt(chn(4) + 1);
	  ol = (rand(chn(5) + 1, cclass) - 0.5) / sqrt(chn(5) + 1);  
    