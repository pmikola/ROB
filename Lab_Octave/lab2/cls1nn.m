function lab = cls1nn(ts, x)
% 1-NN classifier 
% ts - training set
%		first column contains class label
% x - sample to be classified (no label column)
% lab - label of x's nearest neighbour in ts
	sqdist = sumsq(ts(:, 2:end) - x, 2);
	[v iv] = min(sqdist);
	lab = ts(iv, 1);
end
