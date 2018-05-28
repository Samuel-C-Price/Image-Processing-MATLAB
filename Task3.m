% MATLAB script for Assessment Item-1
% Task-3
clear; close all; clc;

I = rgb2gray(imread('Noisy.png'));

% create an empty container to hold new image
new_I = uint8(zeros(size(I)));
new_I2 = uint8(zeros(size(I)));
% P = 2 x 2 zero padding around the image.
P = 255*im2double(padarray(I,[2,2]));
m = 255*im2double(padarray(I,[2,2]));
%set the size of P(padded image used for averaing) and size of m (used for median filter).
[row,col] = size(P);
[row,col] = size(m);
% loop through the image to complete average filter,  
% for every row within x(rows in image P).
% for every column within y(cols in image P).
for x=1:row
    for y = 1:col
        %if row = anything greater than 2, if col is a value greater than
        %2, row is less than the end rows-1, and col is less than the end
        %cols-1. sets the perimeters so the calculation doesnt exceed the
        %boundaries. 
        if(x>2 && y>2 && x<row-1 && y<col-1)
            P(x,y) = mean2(P(x-2:x+2,y-2:y+2));
            % using in built function calculates the average of the 5x5
            % matrix pixel-2, and pixel+2 creates the 5x5 matrix.
        end 
    end 
end 

%%% Median Filter %%%
for x = 1:row
    for y = 1:col
       if(x>2 && y>2 && x<row-1 && y<col-1)
           % p1 is the 5x5 matrix to be calculated. 
           p1 = m(x-2:x+2,y-2:y+2);
           % p2 is p1 reshaped to 1x25 to then sort and find median value.
           p2 = reshape(p1, 1, 25);% reshaped to sort.
           p3=sort(p2);% p3 is p2 sorted in ascending order. 
           medianValue = round(p3(13));%once sorted gets the median value of the sorted matrix.
           % new pixel vlaue is set using median value. 
           m(x,y) = medianValue; 
       end 
         
    end 
end 
%Removing padding to display averaging and median filter image.
new_I = uint8(P(3:end-3,3:end-3));
new_I2 = uint8(m(3:end-3,3:end-3));

figure,imshow(I), title('Original Image');
figure,imshow(new_I), title('Averaging Filter');
figure,imshow(uint8(new_I2)), title('Median Filter');







