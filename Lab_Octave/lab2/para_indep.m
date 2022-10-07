function para = para_indep(ts)
% Liczy parametry dla funkcji pdf_indep
% ts zbiór ucz¹cy (próbka = wiersz; w pierwszej kolumnie etykiety)
% para - struktura zawieraj¹ca parametry:
%	para.labels - etykiety klas
%	para.mu - wartoœci œrednie cech (wiersz na klasê)
%	para.sig - odchylenia standardowe cech (wiersz na klasê)

	labels = unique(ts(:,1));
	para.labels = labels;
	para.mu = zeros(rows(labels), columns(ts)-1);
	para.sig = zeros(rows(labels), columns(ts)-1);

	% tu trzeba wype³niæ wartoœci œrednie i odchylenie standardowe dla klas 
  
  for i=1:rows(labels)
    data = ts(ts(:, 1) == i, 2:end);
    para.mu(i, :) = mean(data);
    para.sig(i, :) = std(data);
  end
  
##  i = length(ts)./labels+1;
##  i(end+1) = 1;
##  i = flip(i);
##  
##  for k = 2:columns(ts)
##    m = 1;
##    for l = 1:length(labels)
##      para.mu(l,k-1) = mean(ts(i(m):i(m+1)-1,k));
##      
##      wariancja = sum((ts(i(m):i(m+1)-1,k) - para.mu(l,k-1)).^2)./...
##      (length(ts(i(m):i(m+1)-2,k)));
##      
##      para.sig(l,k-1) = sqrt(wariancja);
##      m+=1;
##    endfor
##  endfor
 
  
end