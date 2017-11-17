%% Laplacian filter with high-boost filtering
clear
close all
clc

pic = imread('cameraman.tif');
A = {8, 9, 9.7};
A = cell2mat(A);
h = -1 * ones(3, 3);
figure;
subplot 221; imshow(pic); title('Original');
for i = 1:length(A)
    % h = -1 * fspecial('laplacian');
    h(2, 2) = A(i);
    subplot(2,2,i+1); imshow(imfilter(pic, h)); title(A(i));
end



%% Directional filtering
clear
close all
clc

% a
pic = imread('cameraman.tif');
noise = 10 * randn(size(pic));
pic_noisy = uint8(double(pic) + noise);
figure;
subplot 121; imshow(pic);
subplot 122; imshow(pic_noisy);

% b
for i = 3:2:7
[pic0, pic45, pic90, pic135] = directional_filtering(pic_noisy, i);
figure(i);
subplot 221; imshow(pic0); title('pic0');
subplot 222; imshow(pic45); title('pic45');
subplot 223; imshow(pic90); title('pic90');
subplot 224; imshow(pic135); title('pic135');
figure;
imshow(uint8((double(pic0)+double(pic45)+double(pic90)+double(pic135))/4));
end

% How would you combine the results from 4 filtered images?
% Take the average of 4 pics



%% Threshold Median Filtering
clear
close all
clc

% a
pic = imread('miranda1.tif');
noise = 10 * randn(100);
pic_noisy = double(pic);
pic_noisy(151:250, 151:250) = pic_noisy(151:250, 151:250) + noise;
pic_noisy = uint8(pic_noisy);
figure;
subplot 121; imshow(pic); title('Original');
subplot 122; imshow(pic_noisy); title('Noisy');

% b
figure;
for i = 1:4
    ksize = i * 2 + 1; % 3:2:9
    subplot(2,2,i); imshow(med_filter(pic_noisy, ksize)); title(ksize);
end

% c
figure;
ksize = 5;
for i = 1:4
    alpha = 5 * i; % alpha = 20 is the best in this case
    [O, count] = med_filter_alpha(pic_noisy, ksize, alpha); % count
    subplot(2,2,i); imshow(O); title(alpha);
end

% In what situation we would like to use a thresholded median filter?
% The situation when the median value in the kernel is the noise
% [4 2 3; 6 200 178; 188 101 135]
% 2 3 4 6 101 135 178 188 200 -> 101 larger than threshold(alpha)
% We don't want to emphasize the noise, so replace it with the original pixel


% It seems no difference when we applied different alpha here,
% because the noise in picture is not very strong. 
 
% count:
% ksize = 3
 % 0 1 2 3 -> 32700, 20428, 14614, 10817
 % 1 3 5 7 -> 20428, 10817, 6451, 4169
 % 5 10 15 20 -> 6451, 2326, 944, 351
% ksize = 5
 % 5 10 15 20 -> 14605, 5631, 2335, 950
