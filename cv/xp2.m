%POINT OPERATIONS AND HISTOGRAM PROCESSING
img = imread('peppers.png'); % Built-in sample image
gray_img = rgb2gray(img); % Convert to grayscale
%% DISPLAY ORIGINAL IMAGE AND HISTOGRAM
figure('Position', [100, 100, 1200, 800]);
subplot(3,4,1);
imshow(gray_img);
title('Original Image');
subplot(3,4,5);
imhist(gray_img);
title('Original Histogram');
%% 1. IMAGE NEGATIVE
negative_img = 255 - gray_img; % Image negative for uint8 image
subplot(3,4,2);
imshow(negative_img);
title('Image Negative');
subplot(3,4,6);
imhist(negative_img);
title('Negative Histogram');
%% 2. CONTRAST STRETCHING (USING STRETCHLIM & IMADJUST)
low_high = stretchlim(gray_img); % Find intensity limits
stretched_img = imadjust(gray_img, low_high, [0 1]);
subplot(3,4,3);
imshow(stretched_img);
title('Contrast Stretched Image');
subplot(3,4,7);
imhist(stretched_img);
title('Stretched Histogram');
%% 3. HISTOGRAM EQUALIZATION
equalized_img = histeq(gray_img);
subplot(3,4,4);
imshow(equalized_img);
title('Histogram Equalized Image');
subplot(3,4,8);
imhist(equalized_img);
title('Equalized Histogram');