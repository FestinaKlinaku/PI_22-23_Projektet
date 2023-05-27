function [noise] = zhurma(distribution, x, y, z, k, s, a, b)

  % Vlerat e paracaktuara te parametrave a dhe b
  if nargin < 8
      a = 0;
      b = 0;
  end

  % Krijimi i matrices se zhurmes
  noise = zeros(z - x + 1, k - y + 1, s);

  % Gjenerimi i shurmes duke u bazuar ne tipin e shperndarjes
  switch lower(distribution)
      case 'rayleigh'
          for i = 1:s
              noise(:,:,i) = a + b*random('Rayleigh', 1, [z - x + 1, k - y + 1]);
          end

      case 'exponential'
          for i = 1:s
              noise(:,:,i) = a + b*random('Exponential', 1, [z - x + 1, k - y + 1]);
          end

      case 'lognormal'
          for i = 1:s
              noise(:,:,i) = a + b*random('Lognormal', 0, 1, [z - x + 1, k - y + 1]);
          end

      case 'salt&pepper'
          for i = 1:s
              noise(:,:,i) = a + b*imnoise(zeros(z - x + 1, k - y + 1), 'salt & pepper');
          end

      case 'erlang'
          for i = 1:s
              noise(:,:,i) = a + b*random('Erlang', 2, 1, [z - x + 1, k - y + 1]);
          end

      otherwise
          error('Invalid distribution type');
  end

end
