

if exist("iris2") == 1 || exist("iris3") || exist("iris")
  % do nothing
  disp("All Vars in Workspace")
else
  load iris2.txt
  load iris3.txt
  iris2(:,1) = 2 % cls 2
  iris3(:,1) = 3 % cls 3
  iris = [iris2;iris3]
end


ts = iris(47:54,:)

for i = 1:rows(ts)
  clslnn(ts,ts(i,2:end))
end


