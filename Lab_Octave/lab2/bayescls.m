function decv = bayescls(samples, pdfunc, pdparams, apriori)
% Klasyfikator Bayesa 
% samples - macierz próbek do klasyfikacji (próbka = wiersz)
% pdfunc - uchwyt (handle) do funkcji licz¹cej pdf 
% pdparams - parametry dla funkcji licz¹cej pdf
% 	pdparams.labels - etykiety klas
% apriori - wektor prawdopodobieñstw apriori (wierszowy)
% decv - kolumnowy wektor etykiet (wynik klasyfikacji)

	pdfs = pdfunc(samples, pdparams);
	% a priori uwzglêdniamy tylko, jeœli podano parametr
	if nargin >= 4
		% zamiast pdfs .*= apriori
		pdfs = bsxfun(@times, pdfs, apriori);
	end
	
	% nie interesuje nas konkretna wartoœæ gêstoœci...
	[~, mi] = max(pdfs, [], 2);
	
	% translacja numer klasy -> etykieta
	decv = pdparams.labels(mi);
  
  % Zwracac uwage na prawidlowa kolejnosc klas 
  
end