%% RGB to HSV & YCbCr Conversion with Enhancement
img = im2double(imread('peppers.png'));

%% ---------- HSV Enhancement ----------
hsv = rgb2hsv(img);
hsv(:,:,2) = min(hsv(:,:,2)*1.3,1);
hsv(:,:,3) = histeq(hsv(:,:,3));
red = (hsv(:,:,1)<=0.1 | hsv(:,:,1)>=0.9);
hsv(:,:,1) = mod(hsv(:,:,1) + 0.05*red, 1);
img_hsv_enh = hsv2rgb(hsv);

%% ---------- YCbCr Enhancement ----------
ycbcr = rgb2ycbcr(img);
ycbcr(:,:,1) = adapthisteq(ycbcr(:,:,1),'ClipLimit',0.02);
img_ycbcr_enh = ycbcr2rgb(ycbcr);

%% ---------- FIGURE 1 : Images ----------
figure
subplot(2,3,1), imshow(img), title('Original')
subplot(2,3,2), imshow(img_hsv_enh), title('HSV Enhanced')
subplot(2,3,3), imshow(img_ycbcr_enh), title('YCbCr Enhanced')
subplot(2,3,4), imshow(hsv(:,:,2)), title('Saturation')
subplot(2,3,5), imshow(hsv(:,:,3)), title('Value')
subplot(2,3,6), imshow(ycbcr(:,:,1)), title('Luminance')

%% ---------- FIGURE 2 : Histograms ----------
figure
subplot(1,3,1), imhist(rgb2gray(img)), title('Original')
subplot(1,3,2), imhist(rgb2gray(img_hsv_enh)), title('HSV Hist')
subplot(1,3,3), imhist(rgb2gray(img_ycbcr_enh)), title('YCbCr Hist')

%% ---------- FIGURE 3 : Comparison ----------
figure
subplot(1,3,1), imshow(img), title('Original')
subplot(1,3,2), imshow(img_hsv_enh), title('HSV Enhanced')
subplot(1,3,3), imshow(img_ycbcr_enh), title('YCbCr Enhanced')