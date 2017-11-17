%%
clear
close all

I = imread('D:\Opiskelu\TUT\4 Semester2\SGN-12007, Introduction to Image and Video Processing\Exercise\Ex1\peppers.png');
A = 0:1:255;
step = 256/4; % 64
QA1 = quant(A, step); % 1-256 64 量化为64的倍数 A/step四舍五入*step
partition = step:step:256-step; % 64 128 192 根据它来划分量化区域
codebook = step/2:step:256-step/2; % 32 96 160 224 将A量化成它们
[indx,QA2] = quantiz(A, partition, codebook);

% unique 从小到大排列
Q1 = unique(QA1);
Q2 = unique(QA2);


%%
clear
close all

I = imread('lena_face.png');
I = reshape(I, 1, 256*256);
maxI = max(I);
minI = min(I);

for level = [128 64 32 16 8 4]
step = (maxI-minI) / level;
QA = quant(I, step);
%partition = step:step:length-step;
%codebook = minI:(maxI-minI)/level:maxI;
%[indx, QA] = quantiz(I, partition, codebook);
I2 = reshape(QA, 256, 256);
figure;imshow(I2);
end


level = 16;
step = (maxI-minI) / level;
QA = quant(I, step);
I2 = reshape(QA, 256, 256);
figure;subplot(2,1,1);imshow(I2);

I3 = imread('lena_face.png');
Inoise = uint8(randn(size(I3)))*10;
I3 = I3 + Inoise;
I3 = reshape(I3, 1, 256*256);
step = (max(I3) - min(I3)) / level;
QA = quant(I3, step);
In = reshape(QA, 256, 256);
subplot(2,1,2);imshow(In);


%%
clear
close all

A = ones(8,8) * 63;
A(3:6,3:6) = 127;
B = ones(8,8) * 223;
B(3:6,3:6) = 127;
C = [A, B];
figure;
subplot(2,1,1);
imshow(uint8(C), 'InitialMagnification', 'fit');

changes = -27;
A(3:6,3:6) = A(3:6,3:6) + changes;
C = [A, B];
subplot(2,1,2);
imshow(uint8(C), 'InitialMagnification', 'fit');
