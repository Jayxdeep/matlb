clc; clear; close all;
img = im2double(imread('peppers.png'));
hsv_img = rgb2hsv(img);
[H, S, V] = deal(hsv_img(:,:,1), hsv_img(:,:,2), hsv_img(:,:,3));

% Define thresholds [H_min H_max S_min V_min] (Red needs 2 ranges)
masks = { (H<=0.1 | H>=0.9) & S>=.4 & V>=.2; % Red
          (H>=.25 & H<=.45) & S>=.3 & V>=.2; % Green
          (H>=.55 & H<=.75) & S>=.3 & V>=.2; % Blue
          (H>=.12 & H<=.22) & S>=.4 & V>=.4}; % Yellow
titles = {'Red', 'Green', 'Blue', 'Yellow'};

% Morphological cleaning & Segmenting
se = strel('disk', 3);
for i = 1:4
    masks{i} = imclose(imopen(masks{i}, se), se);
    segs{i} = img .* repmat(double(masks{i}), [1 1 3]);
end

% Combined logic
combined = double(cat(3, masks{1}, (masks{2} | masks{4}), masks{3}));
overlay = img*0.7 + combined*0.3;

% Display in a compact loop
figure('Name', 'Color Segmentation');
data = {img, H, S, V, hsv_img, masks{:}, combined, segs{:}, overlay};
lbls = {'Original', 'Hue', 'Sat', 'Val', 'HSV', 'Red M', 'Grn M', 'Blu M', 'Yel M', 'Comb', 'Red S', 'Grn S', 'Blu S', 'Yel S', 'Overlay'};

for i = 1:15
    subplot(3,5,i), imshow(data{i}), title(lbls{i})
    if i==2, colormap(gca, 'hsv'); colorbar; end
    if i==3 || i==4, colormap(gca, 'gray'); end
end
