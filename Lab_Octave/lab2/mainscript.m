% malutki plik do uruchomienia funkcji pdf
load pdf_test.txt
size(pdf_test);
format short e
% ile jest klas?
labels = unique(pdf_test(:,1));

% ile jest pr�bek w ka�dej klasie?
number_of_samples = [labels'; sum(pdf_test(:,1) == labels')];
		  % ^^^ dobrze by�oby pomy�le� o tym wyra�eniu

% jak uk�adaj� si� pr�bki?
%plot2features(pdf_test, 2, 3);


pdfindep_para = para_indep(pdf_test);
% para_indep jest do zaimplementowania, tak �eby dawa�a:
% pdfindep_para =
%  scalar structure containing the fields:
%    labels =
%       1
%       2
%    mu =
%       0.7970000   0.8200000
%      -0.0090000   0.0270000
%    sig =
%       0.21772   0.19172
%       0.19087   0.27179

% teraz do zaimplementowania jest sama funkcja licz�ca pdf 
%  przygotowuj�c te dane skorzysta�em z funkcji normpdf
%  ta funkcja jest zdefiniowana w pakiecie statistics i w mojej
%  lokalnej konfiguracji musz� najpierw za�adowa� ten pakiet:

pkg load statistics % mo�e nie by� konieczne
pi_pdf = pdf_indep(pdf_test([2 7 12 17],2:end), pdfindep_para);

%pi_pdf =
%  1.4700e+000  4.5476e-007
%  3.4621e+000  4.9711e-005
%  6.7800e-011  2.7920e-001
%  5.6610e-008  1.8097e+000

% wielowymiarowy rozk�ad normalny - parametry ...

pdfmulti_para = para_multi(pdf_test);

%pdfmulti_para =
%  scalar structure containing the fields:
%    labels =
%       1
%       2
%    mu =
%       0.7970000   0.8200000
%      -0.0090000   0.0270000
%    sig =
%    ans(:,:,1) =
%       0.047401   0.018222
%       0.018222   0.036756
%    ans(:,:,2) =
%       0.036432  -0.033186
%      -0.033186   0.073868  

% ... i funkcja licz�ca g�sto��
% paradoksalnie sytuacja jest tutaj prostsza, bo w pakiecie
% macie Pa�stwo plik mvnpdf.m zawieraj�cy funkcj�, kt�ra
% liczy wielowymiarow� funkcj� g�sto�ci prawdobie�stwa rozk�adu
% normalnego

pm_pdf = pdf_multi(pdf_test([2 7 12 17],2:end), pdfmulti_para);

%pm_pdf =
%  7.9450e-001  6.5308e-017
%  3.9535e+000  3.8239e-013
%  1.6357e-009  8.6220e-001
%  4.5833e-006  2.8928e+000

% parametry dla aproksymacji oknem Parzena
% t� funkcj� macie Pa�stwo gotow� - u�ywam w niej cell arrays
% warto doczyta�: https://octave.org/doc/v4.2.1/Cell-Arrays.html

pdfparzen_para = para_parzen(pdf_test, 0.5);
									 % ^^^ szeroko�� okna

%pdfparzen_para =
%  scalar structure containing the fields:
%    labels =
%       1
%       2
%    samples =
%    {
%      [1,1] =
%         1.10000   0.95000
%         0.98000   0.61000
% .....
%         0.69000   0.93000
%         0.79000   1.01000
%      [2,1] =
%        -0.010000   0.380000
%         0.250000  -0.440000
% .....
%        -0.110000   0.030000
%         0.120000  -0.090000
%    }
%    parzenw =  0.50000

pp_pdf = pdf_parzen(pdf_test([2 7 12 17],2:end), pdfparzen_para);

%pp_pdf =
%  9.7779e-001  6.1499e-008
%  2.1351e+000  4.2542e-006
%  9.4059e-010  9.8823e-001
%  2.0439e-006  1.9815e+000


% wreszcie mo�na zaj�� si� kartami!
% wcze�niejszy fragment mo�na spokojnie usun�� po uruchomieniu
% funkcji licz�cych pdf
%[train test] = load_cardsuites_data()
load train.txt
load test.txt
for i=77:152:1824
	train(i:i+75,1) += 4;
	test(i:i+75,1) += 4;
end

% pierwszy rzut oka na dane
size(train);
size(test);
labels = unique(train(:,1));
unique(test(:,1));
[labels'; sum(train(:,1) == labels')];

% pierwszym zadaniem po za�adowaniu danych jest sprawdzenie,
% czy w zbiorze ucz�cym nie ma pr�bek odstaj�cych
% do realizacji tego zadania przydadz� si� funkcje licz�ce
% proste statystyki: mean, median, std, 
% wy�wietlenie histogramu cech(y): hist
% spojrzenie na dwie cechy na raz: plot2features (dostarczona w pakiecie)

[mean(train); median(train)];
% hist domy�lnie dzieli zakres warto�ci na 10 koszyk�w
% wy�wietlenie w ten spos�b 8 etykiet do�� dobrze ilustruje 
% dzia�anie hist
hist(train(:,1));

% to nie s� cechy, kt�re wykorzysta�bym do klasyfikacji - mo�na
% znale�� du�o lepsze; do sprawdzania, czy s� warto�ci odstaj�ce
% nawet te cechy wystarcz�
figure(1)
plot2features(train, 4, 6);
grid on
% do identyfikacji odstaj�cych pr�bek doskonale nadaj� si� wersje
% funkcji min i max z dwoma argumentami wyj�ciowymi

[mv midx] = min(train);

% poniewa� warto�ci minimalne czy maksymalne da si� wyznaczy� zawsze,
% dobrze zweryfikowa� ich odstawanie spogl�daj�c przynajmniej na s�siad�w
% podejrzanej pr�bki w zbiorze ucz�cym

% powiedzmy, �e podejrzana jest pr�bka 41
midx = 642;
train(midx-1:midx+1, :);

% je�li nabra�em przekonania, �e pr�bka midx jest do usuni�cia, to:

size(train);
train(midx, :) = [];
size(train);

% procedur� szukania i usuwania warto�ci odstaj�cych trzeba powtarza� do skutku

midx = 186;
train(midx-1:midx+1, :);

size(train);
train(midx, :) = [];
size(train);

% po usuni�ciu warto�ci odstaj�cych mo�na zaj�� si� wyborem DW�CH cech dla klasyfikacji
% w tym przypadku w zupe�no�ci wystarczy poogl�da� wykresy dw�ch cech i wybra� te, kt�re
% daj� w miar� dobrze odseparowane od siebie klasy

plot2features(train, 3, 4)

% Po ustaleniu cech (dok�adniej: indeks�w kolumn, w kt�rych cechy siedz�):
first_idx = 3;
second_idx = 4;
train = train(:, [1 first_idx second_idx]);
test = test(:, [1 first_idx second_idx]);

% to nie jest najros�dniejszy wyb�r; 4 i 6 na pewno trzeba zmieni�

% tutaj jawnie tworz� struktur� z parametrami dla klasyfikatora Bayesa 
% (po prawdzie, to dla funkcji licz�cej g�sto�� prawdobie�stwa) z za�o�eniem,
% �e cechy s� niezale�ne

pdfindep_para = para_indep(train);
pdfmulti_para = para_multi(train);
pdfparzen_para = para_parzen(train, 0.001); 
% w sprawozdaniu trzeba podawa� szeroko�� okna (nie liczymy tego parametru z danych!)	

% wyniki do punktu 3
base_ercf = zeros(1,3);
base_ercf(1) = mean(bayescls(test(:,2:end), @pdf_indep, pdfindep_para) != test(:,1));
base_ercf(2) = mean(bayescls(test(:,2:end), @pdf_multi, pdfmulti_para) != test(:,1));
base_ercf(3) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para) != test(:,1));
base_ercf

   

% W kolejnym punkcie przyda si� funkcja reduce, kt�ra redukuje liczb� pr�bek w poszczeg�lnych
% klasach (w tym przypadku redukcja b�dzie taka sama we wszystkich klasach - ZBIORU UCZ�CEGO)
% Poniewa� reduce ma losowa� pr�bki, to eksperyment nale�y powt�rzy� 5 (lub wi�cej) razy
% W sprawozdaniu prosz� poda� tylko warto�� �redni� i odchylenie standardowe wsp�czynnika b��du
% Wyobra�am sobie, �e w ka�dym powt�rzeniu eksperymentu tworz�
% now� wersj� zbioru ucz�cego:
%   reduced_train = reduce(train, parts(i) * ones(1, class_count))

parts = [0.1 0.25 0.5 1];
rep_cnt = 15;
% YOUR CODE GOES HERE 
base_ercf = zeros(rep_cnt,3, length(parts));
  for i = 1:rep_cnt
    %newTrain = randi([min(train(:,i)),max(train(:,i))],prod(size(train(:,i))),1)
    for j = 1:length(parts)
        %newPartsofNewTrain = newTrain(1:(round(length(newTrain).*parts(1)+1)))
        newSetReduced = reduce(train ,parts(j) .* ones(1,length(unique(train(:,1)))));
        pdfindep_para = para_indep(newSetReduced);
        pdfmulti_para = para_multi(newSetReduced);
        pdfparzen_para = para_parzen(newSetReduced, 0.001);
        base_ercf(i,1,j) = mean(bayescls(test(:,2:end), @pdf_indep, pdfindep_para) != test(:,1));
        base_ercf(i,2,j) = mean(bayescls(test(:,2:end), @pdf_multi, pdfmulti_para) != test(:,1));
        base_ercf(i,3,j) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para) != test(:,1));
        
        %newTrain(k,j,i) = randi([min(train(:,1)),max(train(:,1))])
    end
  end
  base_ercf
  result1 = mean(base_ercf)
  
  
  
% Punkt 5 dotyczy jedynie klasyfikatora z oknem Parzena (na pe�nym zbiorze ucz�cym) 
parzen_widths = [0.0001, 0.0005, 0.001, 0.005, 0.01];
parzen_res = zeros(1, columns(parzen_widths));

% YOUR CODE GOES HERE 
for i = 1:columns(parzen_widths)
    parzenTemp = para_parzen(train, parzen_widths(i));
    parzen_res(i) = mean(bayescls(test(:,2:end), @pdf_parzen, parzenTemp) != test(:,1));
end



[parzen_widths; parzen_res]
% Tu a� prosi si� do�o�y� do danych numerycznych wykres
semilogx(parzen_widths, parzen_res)
xlabel("Window Width")
ylabel("Error")
grid on
% W punkcie 6 redukcja dotyczy ZBIORU TESTOWEGO, natomiast warto
% zadba� o to, �eby parametry dla funkcji pdf by�y policzone
% na ca�ym zbiorze ucz�cym (po poprzednich eksperymentach tak 
% raczej nie jest)
% Poniewa� losujemy pr�bki, to wypada powt�rzy� eksperyment 
% stosown� liczb� razy i u�redni� wyniki
% reduced_test = reduce(test, parts) 

apriori = [0.125 0.125 0.125 0.125 0.125 0.125 0.125 0.125];
parts = [1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0];

rep_cnt = 5;
base_ercf = zeros(rep_cnt,3);
cfMxRes = {};
  for i = 1:rep_cnt
        newSetReduced = reduce(test ,parts);
        
        pdfindep_para = para_indep(train);
        pdfmulti_para = para_multi(train);
        pdfparzen_para = para_parzen(train, 0.001); 
        
        base_ercf(i,1) = mean(bayescls(newSetReduced(:,2:end), @pdf_indep, pdfindep_para, apriori) != newSetReduced(:,1));
        base_ercf(i,2) = mean(bayescls(newSetReduced(:,2:end), @pdf_multi, pdfmulti_para, apriori) != newSetReduced(:,1));
        base_ercf(i,3) = mean(bayescls(newSetReduced(:,2:end), @pdf_parzen, pdfparzen_para, apriori) != newSetReduced(:,1));
        
        cfRes(:, 1) = newSetReduced(:, 1);
        cfRes(:, 2) = bayescls(newSetReduced(:,2:end), @pdf_indep, pdfindep_para, apriori);
        cfRes(:, 3) = bayescls(newSetReduced(:,2:end), @pdf_multi, pdfmulti_para, apriori);
        cfRes(:, 4) = bayescls(newSetReduced(:,2:end), @pdf_parzen, pdfparzen_para, apriori);
        
        cfMxRes{1, i} = confMx(cfRes(:, 1), cfRes(:, 2));
	      cfMxRes{2, i} = confMx(cfRes(:, 1), cfRes(:, 3));
	      cfMxRes{3, i} = confMx(cfRes(:, 1), cfRes(:, 4));
 end
  base_ercf
  result2 = mean(base_ercf)
  cfMxRes
% W ostatnim punkcie trzeba zastanowi� si� nad normalizacj�
std(train(:,2:end))
% Mo�e warto sprawdzi�, jak to wygl�da w poszczeg�lnych klasach?

cls1nn(train(:,2:end), train(:,2:end))

% Normalizacja potrzebna?
% Je�li TAK, to jej parametry s� liczone TYLKO na zbiorze ucz�cym
% Procedura normalizacji jest aplikowana do zbioru ucz�cego i testowego
% Poniewa� zbiory ucz�cy i testowy s� przyzwoitej wielko�ci 
% klasyfikujecie Pa�stwo testowy za pomoc� ucz�cego (nie ma
% potrzeby u�ycia leave-one-out)

% YOUR CODE GOES HERE 

ClassValues = zeros(8, 5);
for i=1:8;
	ClassValues(i, 1) = i;
	ClassValues(i, 2:3) = mean(train(train(:, 1) == i, 2:end));
	ClassValues(i, 4:5) = std(train(train(:, 1) == i, 2:end));
end
ClassValues
for i=1:rows(test);
    Result(i, 1) = cls1nn(train, test(i, 2:end));
end
err = mean(Result != test(:,1))
confMx(test(:, 1), Result(:, 1))
