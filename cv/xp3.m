clc; clear; close all;
g = rgb2gray(imread('peppers.png'));
n = imnoise(g,'gaussian',0,0.01);
figure('Position',[100 100 1400 900])
subplot(3,5,1), imshow(g), title('Original')
subplot(3,5,2), imshow(n), title('Noisy')
subplot(3,5,3), imshow(imfilter(n,fspecial('average',[5 5]))), title('Average')
subplot(3,5,4), imshow(imfilter(n,fspecial('gaussian',[5 5],1))), title('Gaussian')
subplot(3,5,5), imshow(medfilt2(n,[5 5])), title('Median')
lap = imfilter(g,fspecial('laplacian',0));
subplot(3,5,6), imshow(lap,[]), title('Laplacian')
subplot(3,5,7), imshow(g-lap), title('Unsharp')
subplot(3,5,8), imshow(1.5*g-lap), title('High-Boost')
g = im2double(g);
sx = imfilter(g,fspecial('sobel'));
sy = imfilter(g,fspecial('sobel')');
subplot(3,5,9), imshow(sqrt(sx.^2+sy.^2),[]), title('Sobel')
subplot(3,5,10), imshow(imfilter(g,fspecial('prewitt')),[]), title('Prewitt')