% MATLAB script for Assessment Item-1
% Task-2
clear; close all; clc;

%read in input image 
I = imread('SC.png');

[row,col]= size(I);
newI = I; 

%values to be used within for loops below. 
A = 80;
B = 100;
C = 220;
% for every pixel in input image, if value is between 80-100 then change to value 220. 
% use variables set above  
for x=1:row
    for y=1:col
        %original pixel values 
        pixel = I(x,y);
        % if pixel value is between A(80) and B(100) then change to C(220)
       if pixel >= A && pixel <= B
           newPixel= C;
       % if not, keep all other pixel values the same.    
       else 
           newPixel = pixel;
       end
       % then assign new values to new image. 
       newI(x,y) = newPixel;
       
    end 
end 
% crop image around face area.
cropped = imcrop(I,[75 68 130 112]);
new_cropped = imcrop(newI,[75 68 130 112]);

% display input, and new image.
figure, imshow(I), title('Imput Image');
figure, imshow(newI), title('Pixels Changed')

figure, imshow(cropped), title('Original Crop')
figure, imshow(new_cropped), title('Cropped image');

% display histomgrams to show pixel values have changed.
figure, histogram(I),title('Graph A')
figure, histogram(newI), title('Graph B');


