function pdf = pdf_indep(pts, para)
% Liczy funkcj� g�sto�ci prawdopodobie�stwa przy za�o�eniu, �e cechy s� niezale�ne
% pts zawiera punkty, dla kt�rych liczy si� f-cj� g�sto�ci (punkt = wiersz, bez etykiety!)
% para - struktura zawieraj�ca parametry:
%	para.mu - warto�ci �rednie cech (wiersz na klas�)
%	para.sig - odchylenia standardowe cech (wiersz na klas�)
% pdf - macierz g�sto�ci prawdopodobie�stwa
%	liczba wierszy = liczba pr�bek w pts
%	liczba kolumn = liczba klas

	% znam rozmiar wyniku, wi�c go alokuj�
	pdf = zeros(rows(pts), rows(para.mu));
	
  % tu trzeba policzy� warto�� funkcji g�sto�ci
	% jako iloczyn g�sto�ci jednowymiarowych
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
