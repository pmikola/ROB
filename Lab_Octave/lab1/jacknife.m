function ercf = jacknife(ts)
% leave one out test of clslnn classifier
% ts - training set
%     each row represents one sample
%     first column contains class label
% ercf - error coafficient of clslnn on ts
    clres = zeros(rows(ts),1);
    
    for i = 1:rows(ts)
        x = ts(i,2:end);
        %clres(i) = clslnn(ts(1:end !=i,:),x); 
        %clres(i) = clslnn(ts(setdiff(1:end,i),:),x);     
        clres(i) = clslnn(ts([1:i-1 i+1:end],:),x);
    endfor
    
    
    ercf = mean(clres != ts(:,1));
    
endfunction
