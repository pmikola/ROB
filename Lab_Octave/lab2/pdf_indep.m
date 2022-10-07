function pdf = pdf_indep(pts, para)
% Liczy funkcjê gêstoœci prawdopodobieñstwa przy za³o¿eniu, ¿e cechy s¹ niezale¿ne
% pts zawiera punkty, dla których liczy siê f-cjê gêstoœci (punkt = wiersz, bez etykiety!)
% para - struktura zawieraj¹ca parametry:
%	para.mu - wartoœci œrednie cech (wiersz na klasê)
%	para.sig - odchylenia standardowe cech (wiersz na klasê)
% pdf - macierz gêstoœci prawdopodobieñstwa
%	liczba wierszy = liczba próbek w pts
%	liczba kolumn = liczba klas

	% znam rozmiar wyniku, wiêc go alokujê
	pdf = zeros(rows(pts), rows(para.mu));
	
  % tu trzeba policzyæ wartoœæ funkcji gêstoœci
	% jako iloczyn gêstoœci jednowymiarowych
    temp = zeros(1,rows(para.mu));
    for i = 1:rows(pts)
        for j = 1:rows(para.mu)
          perm = 1;
            temp = (1./(para.sig(j, :) .* sqrt(2.*pi))).*exp(-((pts(i, :)-para.mu(j, :)).^2)./(2.*(para.sig(j, :).^2)));
              for k = 1:length(temp)
                perm = perm.*temp(1,k);
              endfor
            pdf(i, j) = perm;
        endfor
    endfor
end
