function oscillator(omega_0, phi_0)  
  dt = 0.05; %krok calkowania przy rozwiazywaniu rownan
  g = 9.81; %przyspieszenie ziemskie
  l = 0.5; %dlugosc "sznurka" w wahadle
  
  %funkcja definiujaca uklad rownan macierzowy:
  % (1) omega' = (-g/l) * sin(phi)
  % (2) phi' = omega
  % f = @(x, t)[(2), (1)] - w tej macierzy rownania sa podane zgodna z kolejnoscia rozwiazywania
  
  uklad_rownan = @(x, t)[x(2), (-g/l).*sin(1.*x(1))];
  
  t = [0 : dt : 10];

  rozwiazanie = lsode(uklad_rownan, [phi_0, omega_0], t);
  % wynik w postaci R = [phi, omega]
  
  subplot(1, 2, 1);
  plot(t, rozwiazanie(:,1)); %wykres wychylenia od czasu
  title("Wykres wychylenia od czasu");
  xlabel("Czas");
  ylabel("Wychylenie");
  
  subplot(1, 2, 2);
  plot(rozwiazanie(:,1), rozwiazanie(:,2)); %wykres predkosci katowej od wychylenia
  title("Wykres predkosci katowej od wychylenia");
  xlabel("Wychylenie");
  ylabel("Predkosc katowa");
  
endfunction 




