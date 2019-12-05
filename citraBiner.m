% clc; clear; close all; warning off all;
 
Img = imread('m20.jpg');
subplot(2,3,1);
imshow(Img);
 
I = double(rgb2gray(Img));
d1x = [-1 0 1];
d1y = [-1;0;1];
Ix = conv2(I,d1x,'same');
Iy = conv2(I,d1y,'same');
J = sqrt((Ix.^2)+(Iy.^2));
subplot(2,3,2);
imshow(J,[]);
	
K = J>10;
L = imclearborder(K);
M = imfill(L,'holes');
N = bwareaopen(M,100);
subplot(2,3,3);
imshow(N);
area = sum(sum(N));
O = bwmorph(N,'remove');
subplot(2,3,4);
imshow(O);
perimeter = sum(sum(O));
[B,L] = bwboundaries(N,'noholes');
subplot(2,3,5);
imshow(Img)
hold on
for k = 1:length(B)
boundary = B{k};
plot(boundary(:,2), boundary(:,1), 'y', 'LineWidth', 2)
end
[row,col] = find(N==1);
  
[a,b] = size(N);
mask = false(a,b);
mask(min(row):max(row),min(col):max(col)) = 1;
 
mask =  bwperim(mask,8);
mask = imdilate(mask,strel('square',4));
 
R = Img(:,:,1);
G = Img(:,:,2);
B = Img(:,:,3);
 
R(mask) = 255;
G(mask) = 255;
B(mask) = 0;
 
RGB = cat(3,R,G,B);
subplot(2,3,6);
imshow(RGB);