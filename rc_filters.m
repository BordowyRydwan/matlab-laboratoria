function rc_filters(R, C, n)

  freqs = rand(n, 1) .* 99 + 1;
  amps = rand(n, 1);
  dt = 0.05;
  t_max = 5;
  
  t = [0 : dt : t_max];
  
  %--liczenie napiec w dziedzinie czasu-- 

  U_sym = amps ./ sqrt(2);
  
  Z_R = R;
  Z_C = -j ./ (C .* freqs);
  Z = Z_R + Z_C;
  
  I_sym = U_sym ./ Z;
  
  U_R_sym = R .* I_sym;
  U_C_sym = Z_C .* I_sym;
  
  U_R = sum(sqrt(2) .* U_R_sym .* cos(freqs .* t + arg(U_R_sym)));
  U_C = sum(sqrt(2) .* U_C_sym .* cos(freqs .* t + arg(U_C_sym)));
  U_in = sum(amps .* cos(freqs .* t));
  
  %--liczenie napiec w dziedzinie czestotliwosci
  
  n = t_max / dt; %liczba probek
  
  df = 1 / dt;
  f = [0 : df : df * n];
  
  %--obliczanie widma czestotliwosciowego
  u_in = (2 / n) .* abs(fft(U_in));
  u_R = (2 / n) .* abs(fft(U_R));
  u_C = (2 / n) .* abs(fft(U_C));
  
  %--wykresy--
  
  figure(1)
  subplot(2, 1, 1);
  plot(t, U_in, t, U_R);
  xlabel("Czas - t[s]");
  ylabel("Napiecie - U[V]");
  legend("U_{in}", "U_{out}");
  title("Napiecie w filtrze gornoprzepustowym od czasu");
  
  subplot(2, 1, 2);
  plot(t, U_in, t, U_C);
  xlabel("Czas - t[s]");
  ylabel("Napiecie - U[V]");
  legend("U_{in}", "U_{out}");
  title("Napiecie w filtrze dolnoprzepustowym od czasu");
  
  figure(2)
  subplot(2, 1, 1);
  plot(f, u_in, f, u_R);
  xlabel("Czestotliwosc - f[Hz]");
  ylabel("Napiecie - U[V]");
  legend("U_{in}", "U_{out}");
  title("Napiecie w filtrze gornoprzepustowym od czestotliwosci");
  xlim([0, n * df / 2]);
  
  subplot(2, 1, 2);
  plot(f, u_in, f, u_C);
  xlabel("Czestotliwosc - f[Hz]");
  ylabel("Napiecie - U[V]");
  legend("U_{in}", "U_{out}");
  title("Napiecie w filtrze dolnoprzepustowym od czestotliwosci");
  xlim([0, n * df / 2]);
  
endfunction