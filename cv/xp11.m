img = imread('peppers.png');
% Convert to grayscale if needed
if size(img,3) == 3
    gray_img = rgb2gray(img);
else
    gray_img = img;
end
% Convert to binary
bw = imbinarize(gray_img);
figure, imshow(bw), title('Binary Image');
% Structuring element
se = strel('disk', 3);
%% Erosion
eroded = imerode(bw, se);
figure, imshow(eroded), title('Eroded Image');
%% Dilation
dilated = imdilate(bw, se);
figure, imshow(dilated), title('Dilated Image');
%% Opening
opened = imopen(bw, se);
figure, imshow(opened), title('Opened Image');
%% Closing
closed = imclose(bw, se);
figure, imshow(closed), title('Closed Image');
%% Hit-or-Miss (MATLAB 9 compatible)
% bwhitmiss requires logical arrays only
se1 = [0 1 0; 1 1 1; 0 1 0];   % Hit pattern
se2 = [1 0 1; 0 0 0; 1 0 1];   % Miss pattern
hitmiss_img = bwhitmiss(bw, se1, se2);
figure, imshow(hitmiss_img), title('Hit-or-Miss Transformation');