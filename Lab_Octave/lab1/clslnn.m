function lab = clslnn (ts,x)
% clslnn - 1 nearest neighbour classifier
% ts - training set
%     each row represents one sample
%     first column contains class label
% x - sample to be classified
%      no label in x, just features
% lab - label of x's nearest neighvour in ts
  
    sqdist = sumsq(ts(:,2:end) - x,2);
    [value,index] = min(sqdist);
    
    lab = ts(index,1);
endfunction
