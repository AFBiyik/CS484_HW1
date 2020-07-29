% Author: Ahmet Furkan Biyik
% ID: 21501084
% Date: 25.10.2019

clear;
clc;
close all;

% data folder path
dataPath = '../cs484_hw1_data/';

% for image output
outputFolder = '../output/';
if (~exist(outputFolder, 'dir'))
   mkdir(outputFolder);
end

% read image
img = imread( strcat(dataPath, 'CT/ct.png'));
figure;
imshow( img );
title('Original');

% thresholding
t = img > 130;
figure;
imshow(t);
title('After Thresholding');
imwrite(t, strcat(outputFolder,'2_1.png'));

% morphological operations
% fill gaps with closing
struct_el = strel('diamond',1);
t1 = dilation(t, struct_el);
t1 = erosion( t1, struct_el );

% eliminate noise with opening
struct_el = strel('diamond', 7);
t1 = erosion( t1, struct_el );
t1 = dilation( t1, struct_el );

figure;
imshow(t1);
title('After Morphology');
imwrite(t1,strcat(outputFolder,'2_2.png'));

% connected component labelling
l = bwlabel(t1);
dim = size(l);

% to colorize each label
dim = [dim 3];
lc = zeros(dim, 'uint8');

colors = [255 0 0; ...
          40 62 201; ...
          254 219 244; ...
          22 236 98; ...
          110 207 43; ...
          249 84 117; ...
          34 247 247; ...
          110 44 113; ...
          178 225 144; ...
          84 110 34;
          6 75 144;
          198 141 29];
      
% colorize loops
for i=1:dim(1)
   for j=1:dim(2)
      if (l(i,j)>0)
          lc(i,j,1) = uint8( colors(l(i,j),1));
          lc(i,j,2) = uint8( colors(l(i,j),2));
          lc(i,j,3) = uint8( colors(l(i,j),3));
      end
   end
end

figure;
imshow(lc);
title('After Labelling');
imwrite(lc, strcat(outputFolder,'2_3.png'));
