clear all;
clc;
close all;
%% Region growing algorithm tests
% Compare results with different thresholds
image = double(imread('coins.png')); % Reading the image and converting it to
                                     % double to not have problems in the
                                     % mean calculation
% Setting threshold values for testing
thres_1 = 30;
thres_2 = 50;
thres_3 = 100;
thres_4 = 150;

connect_8 = 8;   % Defining connectivities
connect_4 = 4;

% Testing our function with 8 pixel connectivity
tic
[seg_image1,regions1] = region_growing(image,thres_1,connect_8); %Threshold of 30
toc
figure, imagesc(seg_image1)
map1 = rand(regions1,3);
figure(1),colormap(map1)
title('Segmented image with threshold of 30')

tic
[seg_image2,regions2] = region_growing(image,thres_2,connect_8); %Threshold of 50
toc
figure, imagesc(seg_image2)
map2 = rand(regions2,3);
figure(2),colormap(map2)
title('Segmented image with threshold of 50')

tic
[seg_image3,regions3] = region_growing(image,thres_3,connect_8); %Threshold of 100
toc
figure, imagesc(seg_image3)
map3 = rand(regions3,3);
figure(3),colormap(map3)
title('Segmented image with threshold of 100')

tic
[seg_image4,regions4] = region_growing(image,thres_4,connect_8); %Threshold of 150
toc
figure, imagesc(seg_image4)
map4 = rand(regions4,3);
figure(4),colormap(map4)
title('Segmented image with threshold of 150')

%% 4-pixel connectivity tests
tic
[seg_image1,regions1] = region_growing(image,thres_1,connect_4); %Threshold of 30
toc
figure, imagesc(seg_image1)
map1 = rand(regions1,3);
figure(1),colormap(map1)
title('4-connectivity with threshold of 30')

tic
[seg_image2,regions2] = region_growing(image,thres_2,connect_4); %Threshold of 50
toc
figure, imagesc(seg_image2)
map2 = rand(regions2,3);
figure(2),colormap(map2)
title('4-connectivity with threshold of 50')

tic
[seg_image3,regions3] = region_growing(image,thres_3,connect_4); %Threshold of 100
toc
figure, imagesc(seg_image3)
map3 = rand(regions3,3);
figure(3),colormap(map3)
title('4-connectivity with threshold of 100')

tic
[seg_image4,regions4] = region_growing(image,thres_4,connect_4); %Threshold of 150
toc
figure, imagesc(seg_image4)
map4 = rand(regions4,3);
figure(4),colormap(map4)
title('4-connectivity with threshold of 150')

%% Applying Gaussian filter
image2 = imgaussfilt(image,0.5);
tic
[new_image,number_regions] = region_growing(image2,thres_2,connect_8);
toc
figure,imagesc(new_image)
map1 = rand(number_regions,3);
figure(1),colormap(map1)

tic
[new_image1,number_regions1] = region_growing(image2,thres_2,connect_4);
toc
figure,imagesc(new_image1)
map2 = rand(number_regions1,3);
figure(2),colormap(map2)

%% RGB tests
imagergb1 = double(imread('woman.tif'));
imagergb2 = double(imread('gantrycrane.png'));
imagergb3 = double(imread('color.tif'));

% Woman image test
tic
[seg_imagergb1,regions_rgb1] = region_growing(imagergb1,50,4);
toc
figure,imagesc(seg_imagergb1)
title('Segmented woman image with threshold of 50')

tic
[seg_imagergb11,regions_rgb11] = region_growing(imagergb1,100,4);
toc
figure,imagesc(seg_imagergb11)
title('Segmented woman image with threshold of 100')

% Gantrycrane image test
tic
[seg_imagergb2,regions_rgb2] = region_growing(imagergb2,50,4);
toc
figure,imagesc(seg_imagergb2)
title('Segmented gantrycrane image with threshold of 50')

tic
[seg_imagergb21,regions_rgb21] = region_growing(imagergb2,100,4);
toc
figure,imagesc(seg_imagergb21)
title('Segmented gantrycrane image with threshold of 100')

% Color image test
tic
[seg_imagergb3,regions_rgb3] = region_growing(imagergb3,50,4);
toc
figure,imagesc(seg_imagergb3)
title('Segmented color image with threshold of 50')

tic
[seg_imagergb31,regions_rgb31] = region_growing(imagergb3,100,4);
toc
figure,imagesc(seg_imagergb31)
title('Segmented color image with threshold of 100')