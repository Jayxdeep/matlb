% Read and preprocess image
clc; clear; close all;

I = im2double(imread('coins.png'));
if size(I,3)==3, I = rgb2gray(I); end

figure, imshow(I), title('Original')
disp('Select seed point'); s = round(ginput(1));
x = s(2); y = s(1);

T = 0.05; 
seg = false(size(I));
seg(x,y) = true;
meanVal = I(x,y);
queue = [x y];
nbr = [-1 0; 1 0; 0 -1; 0 1];

while ~isempty(queue)
    p = queue(1,:); queue(1,:) = [];
    for k = 1:4
        nx = p(1)+nbr(k,1); ny = p(2)+nbr(k,2);
        if nx>0 && ny>0 && nx<=size(I,1) && ny<=size(I,2) && ~seg(nx,ny)
            if abs(I(nx,ny)-meanVal) < T
                seg(nx,ny) = true;
                queue(end+1,:) = [nx ny];
                meanVal = (meanVal + I(nx,ny))/2;
            end
        end
    end
end
figure, imshow(seg), title('Region Growing Result')