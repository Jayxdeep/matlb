img = im2double(imread('cameraman.tif'));
 
% Threshold value (0–1)
th = 0.1;
 
% Built-in edge detection
sobel_ed   = edge(img, 'sobel', th);
prewitt_ed = edge(img, 'prewitt', th);
canny_ed   = edge(img, 'canny', th);
 
% Display main results
figure;
subplot(2,2,1); imshow(img);        title('Original');
subplot(2,2,2); imshow(sobel_ed);   title('Sobel');
subplot(2,2,3); imshow(prewitt_ed); title('Prewitt');
subplot(2,2,4); imshow(canny_ed);   title('Canny');
[Gx_s, Gy_s] = imgradientxy(img, 'sobel');
sobel_manual = sqrt(Gx_s.^2 + Gy_s.^2) > th;
 
[Gx_p, Gy_p] = imgradientxy(img, 'prewitt');
prewitt_manual = sqrt(Gx_p.^2 + Gy_p.^2) > th;
 
figure;
subplot(1,3,1); imshow(sobel_manual);   title('Manual Sobel');
subplot(1,3,2); imshow(prewitt_manual); title('Manual Prewitt');
subplot(1,3,3); imshow(canny_ed);       title('Canny');
 
fprintf('Edge detection completed. Threshold = %.2f\n', th);
