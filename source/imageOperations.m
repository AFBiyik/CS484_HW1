% Author: Ahmet Furkan Biyik
% ID: 21501084
% Date: 25.10.2019

function [sub, th, mp, lc ] = imageOperations(background, image, threshold, se_c , se_o)
%imageOperations background subtraction with threshold, noise deletion with
%opening and connected component labelling
%   [sub, th, mp, lc] = backSub(background, image, threshold, se_c , se_o)
%   background grayscale background
%   image grayscale image
%   threshold threshold value
%   se_c structural element for closing
%   se_o structural element for opening

global index;
% for image output
outputFolder = '../output/';

% backgorund subtraction
sub = image;
sub = double(sub) - double(background);
sub = abs(sub);
sub = uint8(255 * mat2gray(sub));

figure;
imshow( sub );
title('After Background Subtraction');
imwrite(sub, strcat(outputFolder,sprintf('3_%d.png', index)));
index = index + 1;

% thresholding
th = sub > threshold;
figure;
imshow( th );
title('After Thresholding');
imwrite(th, strcat(outputFolder,sprintf('3_%d.png', index)));
index = index + 1;

% morphological operations
% fill gaps with closing
mp = dilation( th, se_c);
mp = erosion( mp, se_c);

% eliminate noise with opening
mp = erosion( mp, se_o);
mp = dilation( mp, se_o);

figure;
imshow( mp );
title('After Morphological Operations');
imwrite(mp, strcat(outputFolder,sprintf('3_%d.png', index)));
index = index + 1;

% connected component labelling
l = bwlabel(mp);
dim = size(mp);

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
          198 141 29;
          72 19 98;
          13 126 116;
          145 81 0];
      
% colorize loops
for k=1:dim(1)
   for j=1:dim(2)
      if (l(k,j)>0)
          lc(k,j,1) = uint8( colors(l(k,j),1));
          lc(k,j,2) = uint8( colors(l(k,j),2));
          lc(k,j,3) = uint8( colors(l(k,j),3));
      end
   end
end

figure;
imshow(lc);
title('After Labelling');
imwrite(lc, strcat(outputFolder,sprintf('3_%d.png', index)));
index = index + 1;

end

