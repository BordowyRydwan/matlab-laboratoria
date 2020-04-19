function [h_max z] = rzut_ukosny(m, v0, fi, c)
  %h_max - wysokosc maksymalna
  %z - zasieg rzutu
  
  %m - masa ciala
  %v_0 - predkosc poczatkowa
  %fi - kat wyrzutu
  %c - wspolczynnik oporu powietrza
  
  g = 9.81; % przyspieszenie ziemskie
  t_c = 0; %czas lotu, bedzie pozniej poprawnie ustawiony w petli
  dt = 0.005; %krok calkowania
  
  v0_x = v0 * cos(fi);
  v0_y = v0 * sin(fi);
  
  rown_ruchu_x = @(x, t) [x(2), -(c/m) .* x(2) .^ 2];
  rown_ruchu_y = @(y, t) [y(2), -(g + (c/m) .* y(2) .^ 2)];
  
  while(true) 
    t_c += dt;
    t_test = [0 : dt : t_c];
    
    ruch_test = lsode(rown_ruchu_y, [0, v0_y], t_test);
    y_test = ruch_test(end , 1);
    
    if(y_test <= 0)
      break;
    endif
    
  endwhile
  
  t = [0 : 0.005 : t_c];
  
  ruch_x = lsode(rown_ruchu_x, [0, v0_x], t);
  ruch_y = lsode(rown_ruchu_y, [0, v0_y], t);
  
  v_x = ruch_x(:, 2);
  x = ruch_x(:, 1);
  
  v_y = ruch_y(:, 2);
  y = ruch_y(:, 1);
  
  h_max = max(y);
  z = max(x);
  
  plot(x, y); %wykres trajektorii lotu ciala
  title("Wykres y(x)");
  ylim([0, 1.2 * h_max]);

endfunction