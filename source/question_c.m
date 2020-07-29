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

% to name output
global index;
index = 1;

% read highway images
hw_0 = imread( strcat(dataPath, 'highway/in000470.jpg'));
hw_1 = imread( strcat(dataPath, 'highway/in000550.jpg'));
hw_2 = imread( strcat(dataPath, 'highway/in000750.jpg'));
hw_3 = imread( strcat(dataPath, 'highway/in000850.jpg'));

% convert to grayscale
hw_0 = rgb2gray(hw_0);
hw_1 = rgb2gray(hw_1);
hw_2 = rgb2gray(hw_2);
hw_3 = rgb2gray(hw_3);

% first
se_c = strel('square', 3);
se_o = strel('square', 6);
imageOperations(hw_0, hw_1, 40, se_c, se_o);

% second
se_c = strel('diamond', 1);
se_o = strel('square', 4);
imageOperations(hw_0, hw_2, 40, se_c, se_o);

% third
se_c = strel('diamond', 2);
se_o = strel('square', 10);
imageOperations(hw_0, hw_3, 30, se_c, se_o);

% read pedestrian images
p_0 = imread( strcat(dataPath, 'pedestrians/in000300.jpg'));
p_1 = imread( strcat(dataPath, 'pedestrians/in000356.jpg'));
p_2 = imread( strcat(dataPath, 'pedestrians/in000475.jpg'));
p_3 = imread( strcat(dataPath, 'pedestrians/in000575.jpg'));

% convert to grayscale
p_0 = rgb2gray(p_0);
p_1 = rgb2gray(p_1);
p_2 = rgb2gray(p_2);
p_3 = rgb2gray(p_3);

% first
se_c = strel('diamond', 2);
se_o = strel('rectangle',[8 2]);
imageOperations(p_0, p_1, 25, se_c, se_o);

% second
se_c = strel('square', 8);
se_o = strel('rectangle', [8 3]);
imageOperations(p_0, p_2, 30, se_c, se_o);

% third
se_c = strel('diamond', 1);
se_o = strel('rectangle',[10 3]);
imageOperations(p_0, p_3, 20, se_c, se_o);
