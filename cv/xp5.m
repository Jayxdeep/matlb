img = imread('peppers.png'); % Built-in sample image
gray_img = rgb2gray(img); % Convert RGB to grayscale
gray_img = double(gray_img); % Convert to double for FFT
%% DISPLAY ORIGINAL IMAGE
figure('Position', [100, 100, 1400, 900]);
subplot(2,3,1);
imshow(uint8(gray_img));
title('Original Image');
%% 2-D DISCRETE FOURIER TRANSFORM
F = fft2(gray_img); % 2-D FFT
F_shifted = fftshift(F); % Shift zero frequency to center
%% MAGNITUDE SPECTRUM
magnitude_spectrum = abs(F_shifted); % Magnitude
log_magnitude = log(1 + magnitude_spectrum); % Log scale
subplot(2,3,2);
imshow(log_magnitude, []);
colormap(gca, 'jet');
colorbar;
title('Magnitude Spectrum (Log Scale)');
%% PHASE SPECTRUM
phase_spectrum = angle(F_shifted); % Phase
subplot(2,3,3);
imshow(phase_spectrum, []);
colormap(gca, 'hsv');
colorbar;
title('Phase Spectrum')