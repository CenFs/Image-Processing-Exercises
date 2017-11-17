%% Signal Creation
clear
close all
clc

Ia = 0.5 * ones(128);

Ib = Ia;
Ib(55:74, 55:74) = 1;

Ic = nncopy(0:1/127:1, 128, 1);

Id = zeros(128, 128);
Id(64, 64) = 1;

% % 2 period = 2 pi = cos(2x);
% % x should be 0-127 because we are dealing with image, no negative values
% x1 = -2*pi:0.1:2*pi;
% cosine1 = cos(2 * x1); 
% figure;
% subplot 121; plot(x1, cosine1);
x = 0:1:127;
cosine = cos(2 * x * pi / 32);
[X, Y] = meshgrid(cosine, cosine);
Ie = (X + Y) / 2;
% subplot 122; plot(x, cosine);

figure;
subplot(151), imshow(Ia);
subplot(152), imshow(Ib);
subplot(153), imshow(Ic);
subplot(154), imshow(Id);
subplot(155), imshow(Ie);



%% DFT
Fa = fft2(Ia);
Fb = fft2(Ib);
Fc = fft2(Ic);
Fd = fft2(Id);
Fe = fft2(Ie);
Fca = fftshift(Fa);
Fcb = fftshift(Fb);
Fcc = fftshift(Fc);
Fcd = fftshift(Fd);
Fce = fftshift(Fe);

figure;
subplot(251),imshow(log(abs(Fa) + 0.0001));
subplot(252),imshow(log(abs(Fb) + 0.0001));
subplot(253),imshow(log(abs(Fc) + 0.0001));
title('Fourier transform');
subplot(254),imshow(log(abs(Fd) + 0.0001));
subplot(255),imshow(log(abs(Fe) + 0.0001));

subplot(256), imshow(log(abs(Fca) + 0.0001));
subplot(257), imshow(log(abs(Fcb) + 0.0001));
subplot(258), imshow(log(abs(Fcc) + 0.0001));
title('Move the zero-frequency component to the center of the matrix');
subplot(259), imshow(log(abs(Fcd) + 0.0001));
subplot(2, 5, 10), imshow(log(abs(Fce) + 0.0001));

% Ha = zeros(length(Ia));
% Ga = Ha .* Fca;
% gia = ifft2(ifftshift(Ga));
% ga = real(gia);



% Ia
% The gray value of original pic is constant
% Energy: 0, except the DC value at(0,0). 128*128*0.5 = 8192
% After the use of fftshift, DC value is at center

% Ib
% Original img has white square in the middle, other area is black
% Energy: horizontal + vertical
% Edge between white and black -> the corresponding frequency is high, other area is low

% Ic
% Original pic ramps from 0 to 1 in horizontal axis
% Energy: horizontal
% In frequency matrix only the first row has high value
% After fftshift, the light line is at center

% Id
% No obvious change in original pic, only one pixel in the center is 1
% Energy: almost 0

% Ie
% Cosine in horizontal + vertical
% Energy:
% Horizontal cosine -> two [w]s(points) in horizontal direction
% Vertical cosine -> two [w]s(points) in vertical direction
% 4 points looks different because of the noise or because the signal is discrete



%% Filtering in the Frequency Domain
clear
close all
clc

I = imread('cameraman.tif');
D0 = 20; % cut-off frequency distance, 2 is too small
n = 2;

Hlp = BWLPfilter(I, D0, n);
Hhp = 1 - Hlp;
figure;
subplot(221), imshow(Hlp); title('Low-pass filter');
subplot(222), imshow(Hhp); title('High-pass filter');

F = fft2(I);
Fc = fftshift(F);
G1 = Hlp .* Fc;
gi1 = ifft2(ifftshift(G1));
G2 = Hhp .* Fc;
gi2 = ifft2(ifftshift(G2));

subplot(223), imshow(uint8(real(gi1))); title('Low-pass filtered image');
subplot(224), imshow(uint8(real(gi2))); title('High-pass filtered image');




