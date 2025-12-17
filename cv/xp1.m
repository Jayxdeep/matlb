%basic Image Handling 
img = imread('peppers.png');
%% 2. IMAGE DISPLAYING
figure;
subplot(2,3,1);
imshow(img);
title('Original Image');
%% 3. BASIC IMAGE INFORMATION
[height, width, channels] = size(img);
fprintf('Image dimensions: %d x %d x %d\n', height, width, channels);
fprintf('Data type: %s\n', class(img));
%% 4. BASIC IMAGE MANIPULATIONS
% Convert RGB image to grayscale
gray_img = rgb2gray(img);
subplot(2,3,2);
imshow(gray_img);
title('Grayscale Image');
% Resize image to 50%
resized_img = imresize(img, 0.5);
subplot(2,3,3);
imshow(resized_img);
title('Resized Image (50%)');
% Rotate image by 45 degrees
rotated_img = imrotate(img, 45);
subplot(2,3,4);
imshow(rotated_img);
title('Rotated Image (45°)');
% Flip image vertically
flipped_img = flipud(img);
subplot(2,3,5);
imshow(flipped_img);
title('Vertically Flipped Image');
% Crop image
cropped_img = img(50:200, 100:300, :);
subplot(2,3,6);
imshow(cropped_img);
title('Cropped Image');
%% 5. BRIGHTNESS ADJUSTMENT
bright_img = imadjust(gray_img, [], [], 1.5);
figure;
subplot(1,2,1);
imshow(gray_img);
title('Original Grayscale Image');
subplot(1,2,2);
imshow(bright_img);
title('Brightness Adjusted Image');
%% 6. HISTOGRAM
figure;
imhist(gray_img);
title('Histogram of Grayscale Image');
%% 7. SAVE PROCESSED IMAGE
imwrite(gray_img, 'processed_image.jpg');
fprintf('Processed image saved as processed_image.jpg\n');
%% 8. BASIC FILTERING (GAUSSIAN FILTER)
filtered_img = imgaussfilt(gray_img, 2);
figure;
subplot(1,2,1);
imshow(gray_img);
title('Original Grayscale Image');
subplot(1,2,2);
imshow(filtered_img);
title('Gaussian Filtered Image')