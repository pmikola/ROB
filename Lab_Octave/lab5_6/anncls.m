function lab = anncls(tset, hidlw1,hidlw2,hidlw3,hidlw4,hidlw5, outlw)
% simple ANN classifier
% tset - data to be classified (every row represents a sample) 
% hidlw - hidden layer weight matrix
% outlw - output layer weight matrix

% lab - classification result (index of output layer neuron with highest value)
% ATTENTION: we assume that constant value IS NOT INCLUDED in tset rows
	hlact = [tset ones(rows(tset), 1)] * hidlw1;
	hl1out = actf(hlact);
  
	hl1act = [hl1out ones(rows(hl1out), 1)] * hidlw2;
	hl2out = actf(hl1act);
  
  hl2act = [hl2out ones(rows(hl2out), 1)] * hidlw3;
	hl3out = actf(hl2act);
  
  hl3act = [hl3out ones(rows(hl3out), 1)] * hidlw4;
	hl4out = actf(hl3act);
  
  hl4act = [hl4out ones(rows(hl4out), 1)] * hidlw5;
	hl5out = actf(hl4act);
 
	olact = [hl5out ones(rows(hl5out), 1)] * outlw;
	olout = actf(olact);
	
	[~, lab] = max(olout, [], 2);
