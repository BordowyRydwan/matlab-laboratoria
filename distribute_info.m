function [product average std_dev] = distribute_info (n) 
  product = 0;
  average = 0;
  std_mean = 0;
  
  if(nargin != 1) %sprawdzanie ilosci argumentow
    usage("[a b c] = distribute_info(int)");
  endif
  
  if(!isinteger(n))
    A = randn(n); %macierz o wyrazach z rozkladu norm., rozmiaru n x n
    avg_row = mean(A, 2); %srednia z wierszy
    avg_col = mean(A, 1); %srednia z kolumn
    
    product = dot(avg_row, avg_col); %iloczyn skalarny powyzszych srednich
    average = mean(A(:)); %srednia arytm. wszystkich elementow macierzy
    std_dev = std(A(:)); %odchylenie standardowe wszystkich elementow macierzy
    
    hist(A(:), 50); %histogram i jego opisy
    title("Liczba zliczen wartosci z rozkladu normalnego");
    xlabel("Wartosc");
    ylabel("Liczba zliczen");
  else
    error("distribute_info: Podaj liczbe calkowita jako argument");
  endif
  
endfunction 
