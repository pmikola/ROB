function decv = bayescls(samples, pdfunc, pdparams, apriori)
% Klasyfikator Bayesa 
% samples - macierz pr�bek do klasyfikacji (pr�bka = wiersz)
% pdfunc - uchwyt (handle) do funkcji licz�cej pdf 
% pdparams - parametry dla funkcji licz�cej pdf
% 	pdparams.labels - etykiety klas
% apriori - wektor prawdopodobie�stw apriori (wierszowy)
% decv - kolumnowy wektor etykiet (wynik klasyfikacji)

	pdfs = pdfunc(samples, pdparams);
	% a priori uwzgl�dniamy tylko, je�li podano parametr
	if nargin >= 4
		% zamiast pdfs .*= apriori
		pdfs = bsxfun(@times, pdfs, apriori);
	end
	
	% nie interesuje nas konkretna warto�� g�sto�ci...
	[~, mi] = max(pdfs, [], 2);
	
	% translacja numer klasy -> etykieta
	decv = pdparams.labels(mi);
  
  % Zwracac uwage na prawidlowa kolejnosc klas 
  
end