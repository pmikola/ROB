function classifiersError = classifiersError(tset, tlab, clsmx)
% 	tset - matrix containing test data; one row represents one sample
% 	clsmx - voting committee matrix
% Output:
%	clab - classification result 

    classifiersResults = {};
	% class processing
	labels = unique(clsmx(:, [1 2]));
	maxvotes = numel(labels) - 1; % unanimity voting in one vs. one scheme
	reject = max(labels) + 1;

	% cast votes of classifiers
    [ votes, classifiersVotes ] = votingWithClassifiers(tset, clsmx);

    for i=1:columns(classifiersVotes);
        classifiersResults{1, i} = classifiersVotes{1,i};
	    [mv classifiersResults{2,i}] = max(classifiersVotes{2,i}, [], 2);
	    classifiersResults{2,i}(mv ~= maxvotes) = reject;
    endfor

    % classifiersError{1, :} - classifier
    % classifiersError{2, :} - confMx
    % classifiersError{3, :} - Error
    classifiersError = {};
    for i=1:columns(classifiersResults);
        classifierComponents = classifiersResults{1,i};
        classifiersError{1,i} = classifierComponents;
        confm = confMx(tlab, classifiersResults{2,i})(classifierComponents, classifierComponents);
        classifiersError{2,i} = confm;
        classifiersError{3,i} = 1 - sum(diag(confm)(:)) / sum(confm(:));
    endfor
end