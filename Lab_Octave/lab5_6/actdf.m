function res = actdf(sfvalue)
% derivative of sigmoid activation function
% sfvalue - value of sigmoid activation function (!!!)
  %VAL = sfvalue.*(1-sfvalue);
  VAL = (4.57573*cosh((2.*sfvalue)./3))./(cosh((4*sfvalue)./3)+ 1).^2;
	res = VAL;
