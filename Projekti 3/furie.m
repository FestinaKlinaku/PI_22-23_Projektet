% Importimi i paketave te nevojshme
pkg load image
pkg load statistics

% Leximi i imazhit dhe konvertimi ne double
img = imread('lena.tif');
img = im2double(img);

% Gjenerimi i imazhit te zhurmshem
noisy_img = img + zhurma('rayleigh', 1, 1, size(img,1), size(img,2), 1, 0, 0.1);

% Perdorimi i transformimit Furie ne imazhit e zhurmshem
F = fft2(noisy_img);

% Krijimi i grid per frekuencat
[X,Y] = meshgrid(1:size(noisy_img,2),1:size(noisy_img,1));

% Llogaritja e frekuencave spatiale permes formules
H = 25*cos((pi*X)/4+(pi*Y)/3) + 10*sin((pi*X)/2+(pi*Y)/9);

% Nderrimi i vendeve te frekuencave spatiale
H_shifted = fftshift(H);

% Shumezimi i tranformimit Furie te imazhit te zhurmshem me frekuencen spatiale
G = F .* H_shifted;

% Tranformimi invers Furie
g = ifft2(G);

% Shfaqja e imazhit pas tranformimit
imshow(g, [])
