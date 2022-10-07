function [hidlw1 hidlw2 hidlw3 hidlw4 hidlw5 outlw terr] = backprop(tset, tslb, inihidlw1,inihidlw2,inihidlw3,inihidlw4,inihidlw5, inioutlw,lr)
% derivative of sigmoid activation function
% tset - training set (every row represents a sample) - input layerr
% tslb - column vector of labels 
% inihidlw - initial hidden layer weight matrix
% inioutlw - initial output layer weight matrix
% lr - learning rate
% hidlw - hidden layer weight matrix
% outlw - output layer weight matrix
% terr - total squared error of the ANN
% 1. Set output matrices to initial values
	hidlw1 = inihidlw1;
  hidlw2 = inihidlw2;
  hidlw3 = inihidlw3;
  hidlw4 = inihidlw4;
  hidlw5 = inihidlw5;
	outlw = inioutlw;
	noSamples = rows(tset);
  noClass = rows(unique(tslb));
% 2. Set total error to 0
	terr = 0;
% for each sample in the training set
for i=1:noSamples
    % noise = (rand(1,cols_tset)-0.5)*noise_dev;
    % tset(i,:) += noise;
		% 3. Set desired output of the ANN (it depends on actf you use!)
    desiredOutput = -ones(1,noClass); % [1 x 10]
		desiredOutput(1,tslb(i)) = 1;
	  % 4. Propagate input forward through the ANN
    a1 = tset(i,:);  % input ->  [1 x 784]
    H1 = [a1 1] * hidlw1;
    a2 = actf(H1); 
    H2 = [a2 1] * hidlw2;  
    a3 = actf(H2); 
    H3 = [a3 1] * hidlw3;
    a4 = actf(H3); 
    H4 = [a4 1] * hidlw4;
    a5 = actf(H4); 
    H5 = [a5 1] * hidlw5;
    a6 = actf(H5);
    H6 = [a6 1] * outlw;
    output = actf(H6);% output <- [1 x cclass]
    
    % Backpropagate
		% 5. Adjust total error E (Cost Function) div
    E = (desiredOutput - output)'; % [1 x noClass] = [1 x noClass] - [1 x cclass]
	  terr += 0.5 .* sqrt(E'*E); % COST
		% 6. Compute delta error of the output layer
		deltaOut = actdf(output)' .* E ;
		% 7. Compute delta error of the hidden layer
    % Layer error is next layer W times next layer Err   
		deltah5 = actdf(a6)' .*(outlw(1:end-1,:) * deltaOut);
    deltah4 = actdf(a5)' .*(hidlw5(1:end-1,:)  * deltah5);
    deltah3 = actdf(a4)' .*(hidlw4(1:end-1,:)  * deltah4);
    deltah2 = actdf(a3)' .*(hidlw3(1:end-1,:)  * deltah3);
    deltah1 = actdf(a2)' .*(hidlw2(1:end-1,:)  * deltah2);
    % 8. Update output layer weights
    outlw += lr * ( deltaOut * [a6 1])';
		% 9. Update hidden layer weights
    hidlw5 += lr * (deltah5 * [a5 1])';
    hidlw4 += lr * (deltah4 * [a4 1])';
    hidlw3 += lr * (deltah3 * [a3 1])';
    hidlw2 += lr * (deltah2 * [a2 1])';
    hidlw1 += lr * (deltah1 * [a1 1])';
	end
  % Gradiend Descend - disp actual terr value
  disp(strcat('E value: ', num2str(terr)));

% Reference Version
##    desiredOutput = zeros(1,noClass);
##    desiredOutput(1,tslb(i)) = 1;
##    X1 = [tset(i,:) 1]; %ones(m,1)];
##    %for j = 1:noLayers-1
##    Wh1 = hidlw1;
##    %inputActj{j} = cellfun(@times,hiddenOutj{j} , hidlw{j},'UniformOutput',false);
##    Z1 =   X1 * Wh1; %Hidden Layers
##    X2 = actf(Z1);
##    Wo = outlw;
##    Z2 = [X2 1] * Wo;   % Input for activation function and output layer
##    output = actf(Z2); % out layer
##    % Backpropagate
##    % 5. Adjust total error E (Cost Function) div
##    % Transpose
##    E = (desiredOutput - output)';
##    terr += 0.5 .* sqrt(E'*E); % COST
##    % 6. Compute delta error of the output layer
##    deltaOut = actdf(output)' .* E;
##    % 7. Compute delta error of the hidden layer
##    % Layer error is next layer W times next layer Err
##    deltaHidden = actdf(X2)' .* outlw(1:end-1,:) * deltaOut;
##    % 8. Update output layer weights
##    outlw += (lr * deltaOut * [X2 1])';
##    % 9. Update hidden layer weights
##    hidlw1 += (lr * deltaHidden * [tset(i,:) 1])';