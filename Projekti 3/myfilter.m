function H = myfilter(M, N, u0, v0, d0, n)
  % Krijimi i grid per frekuencat
  [U, V] = meshgrid(1:N, 1:M);

  % Llogaritja e distances nga qendra per secilen frekuence
  D1 = sqrt((U - (M/2+u0)).^2 + (V - (N/2+v0)).^2);
  D2 = sqrt((U - (M/2-u0)).^2 + (V - (N/2-v0)).^2);

  % Funksioni per filtrim
  H = 1 ./ (1 + (d0 ./ (D1 .* D2)).^n);
end

img = imread('lena.tif');
img = im2double(img);

% Transformimi Furie
F = fftshift(fft2(img));

% Definimi i parametrave
u0 = 30;
v0 = 20;
d0 = 50;
n = 4;

% Perdorimi i funksionit per krijimit e filtit
H = myfilter(size(img,1), size(img,2), u0, v0, d0, n);

% Aplikimi i filtrit ne imazh
G = F .* H;

% Inversi i transformimit Furie
g = real(ifft2(ifftshift(G)));

% Shfaqja e imazhit
imshowpair(img, g, 'montage');
