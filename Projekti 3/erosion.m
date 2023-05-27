% Load the original binary image and the output binary image
original_bw = imread('original_image.png');
eroded_bw = imread('eroded_image.png');

% Convert to grayscale (if necessary)
if size(original_bw, 3) == 3
    original_bw = rgb2gray(original_bw);
end
if size(eroded_bw, 3) == 3
    eroded_bw = rgb2gray(eroded_bw);
end

% Convert to binary images using Otsu's threshold
original_bw = im2bw(original_bw, 0.5);
eroded_bw = im2bw(eroded_bw, 0.5);

% Define a structuring element to try
se = strel('square',26);

%  Perform erosion using the structuring element
output_bw = imerode(original_bw, se);

% Show image
figure, imshow(output_bw);
