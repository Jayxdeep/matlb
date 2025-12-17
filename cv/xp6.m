img = rgb2gray(imread('peppers.png'));
figure('Position',[100 100 1500 900])
subplot(3,5,1), imshow(img), title('Original')
% --- Noise Addition ---
g1 = imnoise(img,'gaussian',0,0.01);
g2 = imnoise(img,'gaussian',0,0.05);
sp1 = imnoise(img,'salt & pepper',0.05);
sp2 = imnoise(img,'salt & pepper',0.10);
subplot(3,5,2), imshow(g1), title('Gaussian 0.01')
subplot(3,5,3), imshow(g2), title('Gaussian 0.05')
subplot(3,5,4), imshow(sp1), title('S&P 5%')
subplot(3,5,5), imshow(sp2), title('S&P 10%')
% --- Mean Filters ---
k = [3 5 7];
for i = 1:3
    subplot(3,5,5+i)
    imshow(imfilter(g2, fspecial('average',[k(i) k(i)])))
    title(['Mean ',num2str(k(i)),'x',num2str(k(i))])
end
% --- Gaussian Filters ---
subplot(3,5,9), imshow(imgaussfilt(g2,1)), title('Gaussian \sigma=1')
subplot(3,5,10), imshow(imgaussfilt(g2,2)), title('Gaussian \sigma=2')

% --- Median Filters ---
for i = 1:3
    subplot(3,5,10+i)
    imshow(medfilt2(sp2,[k(i) k(i)]))
    title(['Median ',num2str(k(i)),'x',num2str(k(i))])
end
