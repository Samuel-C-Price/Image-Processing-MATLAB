% MATLAB script for Assessment Item-1
% Task-4
clear; close all; clc;

I = rgb2gray(imread('Starfish.jpg'));
figure, imshow(I);
% use in built function to complete a median fiter on input image. 
I = medfilt2(I);


figure, imshow(I);
% first image  is binarized to become a binary image then imcomplement is
% used to reverse all values, meaing, 
% 0 now equals 1 & 1 now equals 0.
I = imcomplement(imbinarize(I,0.89));
figure, imshow(I);
% structuring element set to disk to get best results. se will be used to both erode and dilate. 
se = strel ('disk', 2);
% first erode the binarized image to segment objects. 
IE = imerode(I, se);
figure, imshow(IE);
% CC is the connected components within the image, in built function used
% to find all connected components.
CC = bwconncomp(IE);
% then elements are labelled depending on objects or background 
L = labelmatrix(CC);
% ObjAp is the area and perimeter of the objects found in CC. 
ObjAP = regionprops(CC,'area','perimeter');
% to find only starfish and no other objects, ismember says find objects
% with set areas and perimeters which will be the starfish in the image. 
Objects = ismember(L,find([ObjAP.Area]>500 & [ObjAP.Area]<987 & [ObjAP.Perimeter]<=335 & [ObjAP.Perimeter]>=200));
% then dilate the objects to expand all starfish. 
figure, imshow(imdilate(Objects,se));

% BW = imclose(I,se);
% BW1 = imcomplement(BW);
% imshow(BW1);

% 
% BW1 = imclose(BW,se);
% figure, imshow(BW1);
% I = medfilt2(I);
% I = imbinarize(I);
% I = imcomplement(I);
% 
%se = strel ('disk', 2);
% I1 = imdilate(I,se);
% I2 = imopen(I,se);
% I3 = imclose(I,se);
% I4 = imerode(I,se);
% 
% 
% figure,
% subplot(2,2,1),imshow(I3), title('close')
% subplot(2,2,2), imshow(I1), title('Dilation')
% subplot(2,2,3), imshow(I4), title('Erode')
% subplot(2,2,4), imshow(I2), title('Open');