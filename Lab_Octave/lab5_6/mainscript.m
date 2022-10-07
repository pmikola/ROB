clear all% implement actf & check it on a graphx = -5:0.1:5;%figure(1)%plot(x, actf(x))%grid on% implement actdf % note that input value for actdf is not x itself but actf(x)%figure(2)%plot(x, actdf(actf(x)))%grid on% implement backprop % it makes sense to start with a really small dataset%load tiny.txt%tlab = tiny(:,1);%tvec = tiny(:,2:end);%[hlnn olnn] = crann(columns(tvec), 4, 2);%[size(hlnn) size(olnn)]%%clsRes = anncls(tvec, hlnn, olnn);%cfmx = confMx(tlab, clsRes);%errcf = compErrors(cfmx)%%[hlnn olnn terr] = backprop(tvec, tlab, hlnn, olnn, 0.5,numOfLayers)%clsRes = anncls(tvec, hlnn, olnn);%cfmx = confMx(tlab, clsRes);%errcf = compErrors(cfmx);% after reaching 100% classification % you can (probably) play with ann_training% ANN TraningnoNeurons = [200 175 150 125 100]; % last vector element is output layernoEpochs = 50;learningRate = 0.0005;[TrainingReport confMatrix1 confMatrix2] = ann_training(noNeurons,noEpochs,learningRate);save rep_hreg_e50_5layer_Adaptive_lr_Simple.txt TrainingReportsave confMatrix1_hreg_e50_5layer_Adaptive_lr_Simple.txt confMatrix1save confMatrix2_hreg_e50_5layer_Adaptive_lr_Simple.txt confMatrix2rand();rstate = rand("state");save rnd_state_ref.txt rstate