% MATLAB script for Assessment Item-1
% Task-1
clear; close all; clc;

% Step-1: Load input image
I = imread('Zebra.jpg');
figure, imshow(I), title('Figure 1 (Step-1: Load input image)');

% Step-2: Conversion of input image to grey-scale image
Igray = rgb2gray(I);
% figure,
% imshow(Igray),
% title('Step-2: Conversion of input image to greyscale');

% and following steps
[i,j]=size(Igray);

% %Dimensions for the new image
i_new = 1668;
j_new = 1836;

%%%%%% Nearest Neighbour Inpolation %%%%%%%

%looping through the new image to then divide by 3 as we need to scale up
%by 3. 
for row = 1 :i_new
    for col = 1:j_new
        % calculations for assign values to new image, e.g. 4/3 = 1.3 (
        % rounded down to 1). 
        new_row = round(row/3);
        new_col = round(col/3);
        % once rounded, if value equals 0 then assign the value 1 for both
        % rows and cols
        if new_row == 0 || new_col == 0
            new_row = 1;
            new_col = 1;
        end
        %assigning pixels to new image once scaled 
        new_pixel(row,col) = Igray(new_row,new_col);
    end 
end
%displaying  new image to the correct size *3.

figure,imshow(new_pixel),title ('Figure 2 (Nearest Neighbour Interpolation)');

%%%%% Bilinear Interpolation %%%%%%%%

for row = 1:i_new
    
        %%% X Calculations %%%
        % looping through the scaled matrix, divide by 3 not
        % multiply.
        x = row/3;

        %position of the value to the left of x, which will be x1
        x1 = floor(x);% floor will round x down to discover x1.
        % position of the value to the right of x, which will be x2.
        x2 = ceil(x); % ceil will round x up to discover x2, which will be to the right of x.
        % if x1 = 0 then x1 = 1
        if x1 == 0
            x1 = 1;
        end
        % gets the remainder of x using divisor 1.
        xRemain = rem(x,1);

        %%%%%%%%%%%%%
        %%% Y Calculations %%%
        for col = 1:j_new
            % looping through the scaled matrix, divide by 3 not
            % multiply.
            y = col/3;
            %  floor will round y down to discover y1.
            y1 = floor(y);
            % ceil rounds up to make y2
            y2 = ceil(y);
            % if y1 = 0 then y1 = 1
            if y1==0
                y1 = 1;
            end
             % gets the remainder of y using divisor 1.
            yRemain = rem(y,1);
            % points for around the (x,y) point, refer to graph shown. 
            Q11 = I(x1,y1);
            Q12 = I(x1,y2);
            Q21 = I(x2,y1);
            Q22 = I(x2,y2);
                    
                      
            % values, which are directly above and below (x,y).
            R1=Q21*yRemain+Q11*(1-yRemain);
            R2=Q22*yRemain+Q12*(1-yRemain);
            % assinging value to the new pixel in the new image.
            new_pixel_B(row,col)=R1*xRemain+R2*(1-xRemain);
        end      
end 
 
figure, imshow(new_pixel_B),title('Figure 3 (Bilinear Interpolation)');

cropped = imcrop(new_pixel,[250 350 400 400]);
new_cropped = imcrop(new_pixel_B,[250 350 400 400]); 
figure, subplot(1,2,1),imshow(cropped),title('Figure 4 NNI'),subplot(1,2,2),imshow(new_cropped), title('Bilinear');

