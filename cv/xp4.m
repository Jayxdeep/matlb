img = imread('peppers.png');
figure('Position', [100, 100, 1400, 900]);
% Display original image
subplot(3,4,1);
imshow(img);
title('Original Image');
%% SCALING TRANSFORMATION
scaled_up = imresize(img, 1.5);
scaled_down = imresize(img, 0.7);
subplot(3,4,2);
imshow(scaled_up);
title('Scaled Up (1.5x)');
subplot(3,4,3);
imshow(scaled_down);
title('Scaled Down (0.7x)');
%% ROTATION TRANSFORMATION
rotated_30 = imrotate(img, 30);
rotated_45 = imrotate(img, 45);
subplot(3,4,4);
imshow(rotated_30);
title('Rotated 30°');
subplot(3,4,5);
imshow(rotated_45);
title('Rotated 45°');
%% TRANSLATION TRANSFORMATION
translated_img = circshift(img, [30, 40, 0]);
subplot(3,4,6);
imshow(translated_img);
title('Translated Image');
%% COMBINED TRANSFORMATION (EASY WAY)
% Step 1: Scale
combined_img = imresize(img, 0.8);
% Step 2: Rotate
combined_img = imrotate(combined_img, 30);
% Step 3: Translate
combined_img = circshift(combined_img, [20, 40, 0]);
subplot(3,4,7);
imshow(combined_img);
title('Combined Transform');