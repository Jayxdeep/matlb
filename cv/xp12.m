clc; clear; close all;
img = imread('peppers.png');
bw  = bwareaopen(imcomplement(imbinarize(rgb2gray(img))),100);
L = bwlabel(bw);
S = regionprops(L,'Area','Perimeter','BoundingBox','Eccentricity');
n = numel(S);

% Feature matrix: [Compactness, Eccentricity, Aspect Ratio]
F = zeros(n,3);
for i = 1:n
    F(i,:) = [ ...
        (S(i).Perimeter^2)/(4*pi*S(i).Area), ...
        S(i).Eccentricity, ...
        S(i).BoundingBox(3)/S(i).BoundingBox(4) ];
end
labels = (1:n)'; pred = labels;
for i = 1:n
    [~,pred(i)] = min(vecnorm(F - F(i,:),2,2));
end
fprintf('Accuracy: %.2f%%\n', mean(pred==labels)*100)
disp(table(F(:,1),F(:,2),F(:,3),pred, ...
    'VariableNames',{'Compact','Ecc','AR','Class'}))
imshow(img); hold on
for i = 1:n
    rectangle('Position',S(i).BoundingBox,'EdgeColor','g','LineWidth',2)
    text(S(i).BoundingBox(1),S(i).BoundingBox(2)-10, ...
        ['Class ',num2str(pred(i))],'Color','r','FontSize',12)
end
hold off