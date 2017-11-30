%% Color distances and slicing
clear
close all
clc

I = imread('cheetah.jpg');
I2 = imread('chameleon.jpg');

dist = 80;
Isc = sliceCube(I, dist);
Iss = sliceSphere(I, dist);
I2sc = sliceCube(I2, dist);
I2ss = sliceSphere(I2, dist);

figure;
subplot 231; imshow(I); title('Original');
subplot 232; imshow(Isc); title('sliceCube');
subplot 233; imshow(Iss); title('sliceSphere');
subplot 234; imshow(I2); title('Original');
subplot 235; imshow(I2sc); title('sliceCube');
subplot 236; imshow(I2ss); title('sliceSphere');

%% Noise and filtering across different colorspaces
clear
close all
clc

% a
I = imread('lena.tiff');
HSV = rgb2hsv(I);
R = I(:, :, 1);
G = I(:, :, 2);
B = I(:, :, 3);
H = HSV(:, :, 1);
S = HSV(:, :, 2);
V = HSV(:, :, 3);

figure;
subplot 231; imshow(R); title('R');
subplot 232; imshow(G); title('G');
subplot 233; imshow(B); title('B');
subplot 234; imshow(H); title('H');
subplot 235; imshow(S); title('S');
subplot 236; imshow(V); title('V');


% b
NoisyG = imnoise(G, 'gaussian');
Ib = cat(3, R, NoisyG, B);
figure; imshow(Ib);

HSV = rgb2hsv(Ib);
H = HSV(:, :, 1);
S = HSV(:, :, 2);
V = HSV(:, :, 3);

figure;
subplot 231; imshow(R); title('R');
subplot 232; imshow(NoisyG); title('G');
subplot 233; imshow(B); title('B');
subplot 234; imshow(H); title('H');
subplot 235; imshow(S); title('S');
subplot 236; imshow(V); title('V');
% which of them are affected by the noise, which are not
% HS are affected. H = which color, S = how strong the color is
% V is affected a little bit but not obviously, because V = (R+G+B)/3
% RB are not affected

% c
NoisyR = imnoise(R, 'gaussian');
NoisyG = imnoise(G, 'gaussian');
NoisyB = imnoise(B, 'gaussian');
Ic = cat(3, NoisyR, NoisyG, NoisyB);
HSV = rgb2hsv(Ic);
H = HSV(:, :, 1);
S = HSV(:, :, 2);
V = HSV(:, :, 3);


figure;
subplot 231; imshow(NoisyR); title('R');
subplot 232; imshow(NoisyG); title('G');
subplot 233; imshow(NoisyB); title('B');
subplot 234; imshow(H); title('H');
subplot 235; imshow(S); title('S');
subplot 236; imshow(V); title('V');
% Are there any differences between the results of this step and step b
% Noise in V, because V is the average of RGB (brightness)

% d
h = fspecial('gaussian', 5, 1);
fI = imfilter(Ic, h);
figure, imshow(fI); title('Filtered');
% rgb
filteredR = imfilter(NoisyR, h);
filteredG = imfilter(NoisyG, h);
filteredB = imfilter(NoisyB, h);
fIR = cat(3, filteredR, NoisyG, NoisyB);
fIG = cat(3, NoisyR, filteredG, NoisyB);
fIB = cat(3, NoisyR, NoisyG, filteredB);

% hsv
filteredH = imfilter(H, h);
filteredS = imfilter(S, h);
filteredV = imfilter(V, h);
fIH = hsv2rgb(cat(3, filteredH, S, V));
fIS = hsv2rgb(cat(3, H, filteredS, V));
fIV = hsv2rgb(cat(3, H, S, filteredV));

figure;
subplot 231; imshow(fIR); title('Filtered R');
subplot 232; imshow(fIG); title('Filtered G');
subplot 233; imshow(fIB); title('Filtered B');
subplot 234; imshow(fIH); title('Filtered H');
subplot 235; imshow(fIS); title('Filtered S');
subplot 236; imshow(fIV); title('Filtered V');

% Which component should be filtered for best results
% G looks good. For HSV colorspace, we should filter V

% Which will damage the image further when filtered
% H, the filter damage the color

