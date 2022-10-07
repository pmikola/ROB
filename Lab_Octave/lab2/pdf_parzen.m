function pdf = pdf_parzen(pts, para)
% Aproksymuje wartoœæ gêstoœci prawdopodobieñstwa z wykorzystaniem okna Parzena
% pts zawiera punkty, dla których liczy siê f-cjê gêstoœci (punkt = wiersz)
% para - struktura zawieraj¹ca parametry:
%	para.samples - tablica komórek zawieraj¹ca próbki z poszczególnych klas
%	para.parzenw - szerokoœæ okna Parzena
% pdf - macierz gêstoœci prawdopodobieñstwa
%	liczba wierszy = liczba próbek w pts
%	liczba kolumn = liczba klas

	pdf = rand(rows(pts), rows(para.samples));
	
	% przy liczeniu gêstoœci warto zastanowiæ siê
	% nad kolejnoœci¹ obliczeñ (pêtli)
  
  for i=1:rows(para.samples)
    sqrt(rows(para.samples{i}));
    width = para.parzenw / sqrt(rows(para.samples{i}));
    for j=1:rows(pts)
      sample = pts(j, :);
      product = ones(rows(para.samples{i}), 1);
	    for k=1:columns(pts)
        product .*= normpdf((para.samples{i})(:, k), sample(k), width);
      endfor
      pdf(j,i) = mean(product);
    endfor
  endfor
end