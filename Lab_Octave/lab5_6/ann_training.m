function [trReport confMatrixes1 confMatrixes2] = ann_training(noNeurons,noEpochs,learningRate)
[tvec tlab tstv tstl] = readSets(); 
[unique(tlab)'; unique(tstl)']
tlab += 1;
tstl += 1;

[unique(tlab)'; sum(tlab == unique(tlab)')]
[unique(tstl)'; sum(tstl == unique(tstl)')]

% imsize = 28;
% fim = zeros((imsize + 2) * 10 + 2);

% for clid = 1:10
%   rowid = (clid - 1) * (imsize + 2) + 3;
%   clsamples = find(tlab == clid)(1:10);
%   for spid = 1:10
%	 colid = (spid - 1) * (imsize + 2) + 3;
%	 im = 1-reshape(tvec(clsamples(spid),:), imsize, imsize)';
%	 fim(rowid:rowid+imsize-1, colid:colid+imsize-1) = im;
%   end
% end
% imshow(fim)

%noHiddenNeurons = 100;
%noEpochs = 50;
%learningRate = 0.001;

rand()

% saving state of (pseudo)random number generator
rndstate = rand("state");
save rndstate.txt rndstate

%loading state of (pseudo)random number generator
load rndstate.txt
rand("state", rndstate);

% Shuffle train and test sets
rnum = rows(tvec);
i = randperm(rnum);
tvec = tvec(i,:);
tlab = tlab(i,:);

%Normalization of train and test sets
mn = mean(tvec); sd = std(tvec);
sd(sd==0) = 1;
tvec = bsxfun(@minus,tvec,mn);
tvec = bsxfun(@rdivide,tvec,sd);
mn = mean(tstv); sd = std(tstv);
sd(sd==0) = 1;
tstv = bsxfun(@minus,tstv,mn);
tstv = bsxfun(@rdivide,tstv,sd);

[hlnn1 hlnn2 hlnn3 hlnn4 hlnn5 olnn] = crann(columns(tvec), noNeurons, numel(unique(tlab)));
disp(strcat('Size hlnn1',num2str(size(hlnn1))));
disp(strcat('Size hlnn2',num2str(size(hlnn2))));
disp(strcat('Size hlnn3',num2str(size(hlnn3))));
disp(strcat('Size hlnn4',num2str(size(hlnn4))));
disp(strcat('Size hlnn5',num2str(size(hlnn5))));
disp(strcat('Size olnn',num2str(size(olnn))));
trainError = zeros(1, noEpochs);
testError = zeros(1, noEpochs);
confMatrixes1 = zeros(10,11,noEpochs);
confMatrixes2 = zeros(10,11,noEpochs);
trReport = [];

for epoch=1:noEpochs
	tic();
	[hlnn1 hlnn2 hlnn3 hlnn4 hlnn5 olnn terr] = backprop(tvec,tlab,hlnn1,hlnn2,hlnn3,hlnn4,hlnn5,olnn,learningRate);
  clsRes = anncls(tvec, hlnn1,hlnn2,hlnn3,hlnn4,hlnn5,olnn);
	cfmx1 = confMx(tlab, clsRes);
	errcf = compErrors(cfmx1);
	trainError(epoch) = errcf(2);
  
	clsRes = anncls(tstv, hlnn1,hlnn2,hlnn3,hlnn4,hlnn5, olnn);
	cfmx2 = confMx(tstl, clsRes);
	errcf2 = compErrors(cfmx2);
	testError(epoch) = errcf2(2);
  if epoch >= 2
    if abs(testError(epoch) - testError(epoch-1))  <= testError(epoch)*0.02
      learningRate = learningRate * 1.1
    elseif abs(testError(epoch) - testError(epoch-1)) >= testError(epoch)*0.1
       learningRate = learningRate / 1.2
    else
       % do nothing
    end
  end
	epochTime = toc();
	disp([epoch epochTime trainError(epoch) testError(epoch)])
	trReport = [trReport; epoch epochTime trainError(epoch) testError(epoch)];
	% [errcf errcf2]
	fflush(stdout);
  confMatrixes1(:,:,epoch) = cfmx1;
  confMatrixes2(:,:,epoch) = cfmx2;
end

plot(1:noEpochs, trainError, 'b', 1:noEpochs, testError, 'r')
xlabel('epoch');
ylabel('error [%]');
title ("training and testing error during backprop");
legend ("train error", "test error");
grid on
set(findall(gcf,'-property','FontSize'),'FontSize',12);
end
    % 1.00000   32.45361    0.24037    0.25030
    % 2.00000   33.74495    0.18575    0.19860
    % 3.00000   32.88645    0.16907    0.18360
    % 4.00000   32.28321    0.15967    0.17360
    % 5.00000   32.08673    0.15335    0.16840
    % 6.00000   34.68219    0.14790    0.16440
    % 7.00000   32.36811    0.14435    0.16140
    % 8.00000   32.76522    0.14085    0.15830
    % 9.00000   31.85858    0.13777    0.15530
   % 10.00000   31.62970    0.13517    0.15200
   % 11.00000   32.21210    0.13288    0.14900
   % 12.00000   31.66517    0.13095    0.14790
   % 13.00000   31.99674    0.12902    0.14620
   % 14.00000   32.26260    0.12708    0.14490
   % 15.00000   33.02412    0.12550    0.14400
   % 16.00000   31.98132    0.12385    0.14310
   % 17.00000   31.54450    0.12265    0.14250
   % 18.00000   32.09317    0.12117    0.14010
   % 19.00000   32.22823    0.11970    0.13950
   % 20.00000   32.50912    0.11848    0.13810
   % 21.00000   31.53274    0.11783    0.13660
   % 22.00000   31.75400    0.11682    0.13540
   % 23.00000   31.87277    0.11600    0.13500
   % 24.00000   31.88337    0.11487    0.13510
   % 25.00000   32.12629    0.11378    0.13460
   % 26.00000   32.18595    0.11262    0.13410
   % 27.00000   32.17478    0.11172    0.13330
   % 28.00000   31.64682    0.11077    0.13330
   % 29.00000   30.33903    0.11020    0.13240
   % 30.00000   30.51275    0.10945    0.13210
   % 31.00000   30.71867    0.10868    0.13170
   % 32.00000   30.49341    0.10760    0.13100
   % 33.00000   30.41651    0.10698    0.13090
   % 34.00000   31.13717    0.10615    0.12990
   % 35.00000   30.38222    0.10560    0.12950
   % 36.00000   31.70545    0.10492    0.12880
   % 37.00000   32.68488    0.10438    0.12810
   % 38.00000   35.60400    0.10387    0.12810
   % 39.00000   38.60883    0.10305    0.12770
   % 40.00000   37.09883    0.10252    0.12720
   % 41.00000   37.97968    0.10185    0.12730
   % 42.00000   34.97819    0.10093    0.12690
   % 43.00000   47.60830    0.10017    0.12640
   % 44.000000   33.959792    0.099533    0.126200
   % 45.000000   32.473671    0.099017    0.126100
   % 46.000000   32.619054    0.098367    0.126100
   % 47.000000   32.433345    0.097683    0.125600
   % 48.000000   31.767765    0.097250    0.125500
   % 49.000000   32.100420    0.096883    0.125000
   % 50.000000   32.116261    0.096467    0.124600