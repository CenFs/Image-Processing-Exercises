%% Image Blurring
clear
close all
clc

% a
I = imread('DIP.jpg');
[row, col] = size(I);
[u, v] = meshgrid(-row/2+1:row/2, -col/2+1:col/2);

a = 0.1;
b = 0.1;
T = 1;

Hpi = pi .* (u .* a + v .* b);
Ha = sin(Hpi);
Hb = exp(-1i * Hpi);
Hc = T ./ (Hpi + eps); % All black without eps
H = Ha .* Hb .* Hc; % Motion blurring filter

% b Blur
F = fft2(I);
Fc = fftshift(F);
G = Fc .* H;
gi = ifft2(ifftshift(G));
Ib = uint8(real(gi));

% c Restore
invrG = fftshift(fft2(gi));
invrFc = invrG ./ (H + 0.01);
invrF = ifftshift(invrFc);
invrI = ifft2(invrF);
Ic = uint8(real(invrI));

% d
figure;
subplot 131; imshow(I); title('Original');
subplot 132; imshow(Ib); title('Motion blurred');
subplot 133; imshow(Ic); title('Restored');

% mse = mean(mean((double(I) - real(inver_I)) .^ 2));
errb = immse(Ib, I);
fprintf('\n Original vs Motion blurred: The mean-squared error is %0.4f.', errb);

errc = immse(Ic, I);
fprintf('\n Original vs Restored: The mean-squared error is %0.4f.\n\n', errc);

Iblurred = Ib;
Irestored = Ic;

%% Image Restoration via Wiener Filtering
% a
noise = sqrt(50) * randn(size(I));
Ia = Iblurred + uint8(noise); % Ib + noise
% Ia = gi + noise; % noise only
% Ia = imadd(Iblurred, uint8(noise));

% b Simple inverse filtering
invrG = fftshift(fft2(Ia)); % DFT of degraded image
invrFc = invrG ./ (H + 0.01); % normal filter H
invrI = ifft2(ifftshift(invrFc));
Ib = uint8(real(invrI));

% c Wiener filter
Hpower = abs(H) .^ 2;
Sn = abs(fftshift(fft2(noise))); % DFT of noise
Sf = abs(fftshift(fft2(I))); % DFT of original image
Sratio = Sn ./ (Sf + 0.01);
F = (1 ./ (H + 0.01)) .* (Hpower ./ (Hpower + Sratio)) .* invrG; % G = degraded image, but fomula all in DFT domain
Ic = uint8(real(ifft2(ifftshift(F))));

% invrGnoise = fftshift(fft2(noise));
% invrGa = fftshift(fft2(Ia));
% K = invrGnoise ./ Fc;
% H_Wa = conj(H) ./ ((H .* conj(H) + K));
% Jc = ifft2(ifftshift(H_Wa .* invrGa));
% Ic = uint8(real(Jc));

% invrGgi = fftshift(fft2(gi));
% H_Wgi = conj(H) ./ ((H .* conj(H) + 0.02));
% Jd = ifft2(ifftshift(H_Wgi .* invrGgi));
% Id = uint8(real(Jd));


% d
figure;
subplot 231; imshow(I); title('Original');
subplot 232; imshow(Iblurred); title('Blurred');
subplot 233; imshow(Irestored); title('Restored');
subplot 234; imshow(Ia); title('Blurred + noise');
subplot 235; imshow(Ib); title('Inverse filtering');
subplot 236; imshow(Ic); title('Blurred&Noisy + Winer');

% e
% Explain why simple inverse filtering generally cannot recover problems such as in Task 2a.
% (Image+Noise)*Filter/(Filter+eps) -> Density of noise boost


% f
% Bigger value of k, more blur of image
k1 = 0.01; % Energy of noise, ratio of Sn/(Sf+eps)
k2 = 0.1;
k3 = 1;
F1 = (1 ./ (H + 0.01)) .* (Hpower ./ (Hpower + k1)) .* invrG;
F2 = (1 ./ (H + 0.01)) .* (Hpower ./ (Hpower + k2)) .* invrG;
F3 = (1 ./ (H + 0.01)) .* (Hpower ./ (Hpower + k3)) .* invrG;
I1 = uint8(real(ifft2(ifftshift(F1))));
I2 = uint8(real(ifft2(ifftshift(F2))));
I3 = uint8(real(ifft2(ifftshift(F3))));

figure;
subplot 141; imshow(Ic); title('k = Sratio');
subplot 142; imshow(I1); title('k = 0.01');
subplot 143; imshow(I2); title('k = 0.05');
subplot 144; imshow(I3); title('k = 0.1');
