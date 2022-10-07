function res = actf(tact)
% sigmoid activation function
% tact - total activation 

  %sigmoid = 1./(1 + exp(-tact)); % sigmoid equation
  tang = 1.7159 .* tanh((2./3).*tact);
  %dsigmoid = exp(-tact)./((1+exp(-tact).^2) % derivitive sigmoid equation
	res = tang;
