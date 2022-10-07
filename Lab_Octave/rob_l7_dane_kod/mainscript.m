vnames = {
'valid_1.txt', 
'valid_2.txt',
'valid_3.txt',
'valid_4.txt',
'valid_5.txt',
'valid_6.txt',
'valid_7.txt'};

tnames = {
'test_1.txt', 
'test_2.txt', 
'test_3.txt', 
'test_4.txt', 
'test_5.txt', 
'test_6.txt', 
'test_7.txt'};

load validlab.txt;
validlab = validlab + 1;
vtab = loadCNNOutputs_ave(vnames);

load testlab.txt;
testlab = testlab + 1;
ttab = loadCNNOutputs_ave(tnames);

thresholds = 0.01:0.01:0.99;
scores_val = zeros(rows(thresholds),1);
scores_test = zeros(rows(thresholds),1);

best_threshold = 0;
best_f_val = 0;

for i = 1:columns(thresholds)
  vecMy = voteAveraging(vtab, validlab, thresholds(i));
  tecMy = voteAveraging(ttab, testlab, thresholds(i));
  
  scores_val(i) = fobj(vecMy);
  scores_test(i) = fobj(tecMy);
  
  if scores_val(i) > best_f_val
    best_f_val = scores_val(i);
    best_threshold = thresholds(i);
  endif
  
endfor

plot(thresholds, scores_val, 'r', thresholds, scores_test, 'b')
xlabel("Treshold")
ylabel("Score")
legend ("VAL","TEST","left bottom")
grid on
best_threshold = best_threshold

vecMy = voteAveraging(vtab, validlab, best_threshold);
tecMy = voteAveraging(ttab, testlab, best_threshold);

resVald = [vecMy fobj(vecMy)]
resTest = [tecMy fobj(tecMy)]
