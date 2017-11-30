%% Histogram Equalization for Color Images
clear
close all
clc

I1 = imread('fruits.jpg');
I2 = imread('festia.jpg');

R1 = histeq(I1(:, :, 1));
G1 = histeq(I1(:, :, 2));
B1 = histeq(I1(:, :, 3));
R2 = histeq(I2(:, :, 1));
G2 = histeq(I2(:, :, 2));
B2 = histeq(I2(:, :, 3));

I1a = cat(3, R1, G1, B1);
I2a = cat(3, R2, G2, B2);

I1b = intensityeq(I1);
I2b = intensityeq(I2);

figure;
subplot 231; imshow(I1); title('Orginal');
subplot 232; imshow(I1a); title('histeq');
subplot 233; imshow(I1b); title('intensityeq rgb2hsv');
subplot 234; imshow(I2); title('Orginal');
subplot 235; imshow(I2a); title('histeq');
subplot 236; imshow(I2b); title('intensityeq rgb2hsv');

% explain the effects of processing
% Hue, Saturation, Value(Brightness)

%% Object Extraction
clear
close all
clc

I = imread('lake.jpg');
hsv = rgb2hsv(I);
s = hsv(:, :, 2);
bw = im2bw(s, graythresh(s));
figure; imshow(bw); title('Binary image');
[L, num] = bwlabel(bw, 8);
matrix = zeros(1, num);
for i = 1:num
    matrix(i) = length(find(L == i));
end
[value, index] = max(matrix);
bw_biggest_area = (L == index);

I = uint8(cat(3, bw_biggest_area, bw_biggest_area, bw_biggest_area)) .* I;
figure; imshow(I); title('Biggest lake');




