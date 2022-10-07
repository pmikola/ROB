function rds = reduce(ds, parts)
% Funkcja redukcji liczby próbek poszczególnych klas w zbiorze ds
% ds - zbiór danych do redukcji; pierwsza kolumna zawiera etykietê
% parts - wierszowy wektor wspó³czynników redukcji dla poszczególnych klas
  
	
  labels = unique(ds(:,1));
	if rows(labels) ~= columns(parts)
		error("Liczba klas nie zgadza sie z liczba wsp. redukcji.");
	end

	if max(parts) > 1 || min(parts) < 0
		error("Niewlasciwe wspolczynniki redukcji.");
	end
    reducedSet = [];
  for i=1:length(labels)
    validLabel = ds(:, 1) == i;
    data = ds(validLabel, :);
    reducedSize = length(data) .* parts(i);
    for k = 1:reducedSize
      j(k) = randperm(length(data),(1:reducedSize));
    end
      reducedSet = [reducedSet;data(j,:)];
  end
  
	% zdecydowanie wypadaloby uzyc randperm do mieszania probek w klasach
	% ta implementacja jest daleka od doskonalosci
	rds = reducedSet;
