function [a b S_a S_b] = lin_dist(X, Y, n)
  % this script DOES NOT require optim - you can use it with basic Octave build. 

  % format: X = [1 2 ... n]
  %         Y = [1 2 ... n]; 
  
  if(rows(X) != 1 || rows(Y) != 1)
    error("X and Y vectors must both have 1 row");
  endif
  
  if(columns(Y) != n || columns(X) != n)
    error("Vector sizes don't match");
  endif
  
  xx = sum(X .^ 2);
  yy = sum(Y .^ 2);
  xy = sum(X .* Y);
  x = sum(X);
  y = sum(Y);
  
  a = (n * xy - x * y) / (n * xx - x ^ 2);
  b = (1/n) * (y - a * x);
  S_a = sqrt((n * (yy - a * xy - b * y)) / ((n - 2) * (n * xx - x * x)));
  S_b = sqrt((1/n) * (S_a ^ 2) * x);
  
endfunction
