%% Noise generation and restoration
clear
close all
clc

pic = imread('lena.jpg');
pica = imnoise(pic, 'gaussian');
picb = imnoise(pic, 'salt & pepper');

height = size(pic, 1);
width = size(pic, 2);
b = 1;
noise = sqrt(-b * log(1 - rand(height, width)));
picc = uint8(double(pic) + noise);


figure;
subplot 221; imshow(pic); title('Original');
subplot 222; imshow(pica); title('Gaussian');
subplot 223; imshow(picb); title('Salt & pepper');
subplot 224; imshow(picc); title('Rayleigh');


%% Restoration of Noisy Images
picnames = {'Original', 'Gaussian', 'Salt & pepper', 'Rayleigh'};
pics = cat(3, pic, pica, picb, picc);
m = 3;
n = 3;

for i = 1:size(picnames, 2)
    g = double(pics(:, :, i));
    
    fa = imfilter(g, fspecial('average', [m n])); % Arithmetic mean filter
    fb = exp(imfilter(log(g), ones(m, n), 'replicate')) .^ (1 / (m * n)); % Geometric mean filter
    fc = (m * n) ./ imfilter(1 ./ (g + eps), ones(m, n), 'replicate'); % Harmonic mean filter
    
    figure;
    subplot 221; imshow(uint8(g)); title(picnames{i});
    subplot 222; imshow(uint8(fa)); title('Arithmetic mean filter');
    subplot 223; imshow(uint8(fb)); title('Geometric mean filter');
    subplot 224; imshow(uint8(fc)); title('Harmonic mean filter');
end



%% Noise cleaning with weighted Median Filter
clear
close all
clc

pic = imread('baboon.png');
noisy_pic = imnoise(pic, 'salt & pepper', 0.02);
median_pic = medfilt2(pic);

[m, n] = size(pic);
wmf_pic = double(pic);
w = ones(5,5);
w(3,3) = 5;
for x = 3:1:m - 2
    for y = 3:1:n - 2
        tmp = sort(w .* double(pic(x-2:x+2, y-2:y+2)));
        wmf_pic(x, y) = tmp(round(numel(w)/2));
    end
end
wmf_pic = uint8(wmf_pic);


figure;
subplot 221; imshow(pic); title('Original');
subplot 222; imshow(noisy_pic); title('Noisy');
subplot 223; imshow(median_pic); title('Original median filtered');
subplot 224; imshow(wmf_pic); title('Weighted median filtered');

