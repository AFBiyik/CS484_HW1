clear;
clc;
close all;

img = imread('Input.jpg');
%figure;
%imshow( img );
%title('Original');

% rgb channels
red = img( :, :, 1 );
green = img( :, :, 2 );
blue = img( :, :, 3 );

i = (red > 200);
figure;
imshow(i);
title('Original');

SE = strel('rectangle',[2 2]);

out = dilation(i , SE);
figure;
imshow(out);
title('My dilation');

j = imdilate(i,SE);
figure;
imshow(j);
title('Matlab dilation');

out = erosion(i , SE);
figure;
imshow(out);
title('My erosion');

j = imerode(i,SE);
figure;
title('Matlab erosion');
imshow(j);