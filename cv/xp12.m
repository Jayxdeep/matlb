img = imread('peppers.png');
bw = bwareaopen(imcomplement(imbinarize(rgb2gray(img))),100);
 
l = bwlabel(bw);
s = regionprops(l,'Area','Perimeter','BoundingBox','Eccentricity');
 
n = numel(s); 
f = zeros(n,3);
 
for k = 1:n
    f(k,1) = (s(k).Perimeter^2)/(4*pi*s(k).Area);      
    f(k,2) = s(k).Eccentricity;                        
    f(k,3) = s(k).BoundingBox(3)/s(k).BoundingBox(4);  
end
%% Automatic Class Labels = 1,2,3,4,...n
labels = 1:n;     
pred = zeros(1,n);
 
for i = 1:n
    d = bsxfun(@minus, f, f(i,:));     
    dist = sqrt(sum(d.^2, 2));         
    [~,idx] = min(dist);
    pred(i) = labels(idx);
end
 
fprintf('Accuracy: %.2f%%\n', sum(pred==labels)/n*100);
 
disp(table(f(:,1),f(:,2),f(:,3),pred','VariableNames', ...
    {'Compact','Ecc','AR','PredictedClass'}));
 
imshow(img); hold on;
for k = 1:n
    rectangle('Position',s(k).BoundingBox,'EdgeColor','g','LineWidth',2);
    text(s(k).BoundingBox(1),s(k).BoundingBox(2)-10, ...
        sprintf('Class %d',pred(k)), ...
        'Color','r','FontSize',12,'FontWeight','bold');
end
hold off;
