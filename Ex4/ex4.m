%% Image Enhancement Intensity Transformations
% An application of intensity transformations is to increase the contrast
% between certain intensity values so that you can pick out things in an image

% 为什么用log和power low?
% 因为曲线从左下-左上-右上
% 在靠x=0的地方比较陡，可以stretch到value较大的y，暗的地方变得很亮
% 而靠近x=255的地方比较平缓，亮的地方不会太亮

clear
close all
clc

pic = imread('university.png');
figure(1);
subplot 221; imshow(pic); title('original image');
% Image Negative
% L = 256;
% s = (L - 1) - pic;
% figure, imshow(s); title('Image negative -> s=L-1-r');

% Log Transformation % s = clog(1+r)
r = double(pic);
c = 1;
s1 = c * log(1 + r);
lt_pic = uint8(255 / (c * log(256)) * s1); % Map the obtained values to the range [0 255]
subplot 222; imshow(lt_pic);
title('log transformation -> s=clog(1+r)  c=1');

% Power-Law Transformation % s = cr^gamma
c = 1;
gamma = 0.4;
s2 = c * (r .^ gamma);
plt_pic = uint8(255 / (c * (255 .^ gamma)) * s2); % Map the obtained values to the range [0 255]
subplot 223; imshow(plt_pic);
title('power law transformation -> s=cr^\gamma  \gamma=0.4 c=1');


% The transformation is plotted for different values of gamma for the intensity levels [0 255]
% The output image intensity values are mapped to the range [0 255]
GRng = [0.04; 0.10; 0.20; 0.40; 0.67; 1; 1.5; 2.5; 5.0; 10.0; 25.0];
R = 0:255;
figure(2);
for i = 1:size(GRng, 1)
    x = c * (R .^ GRng(i));
    s = 256 / x(256) * x;
    plot(R, s);
    title('Plot Equation s = cr^\gamma');
    xlabel('Input Intensity Level,r');
    ylabel('Output Intensity Level,s');
    text(R(175), s(175), ['\gamma = ', num2str(GRng(i))], 'HorizontalAlignment', 'left');
    hold all
    axis([0 255 0 255]);
end


%% Histogram Equalization
% Histogram equalization is a technique for adjusting image intensities to enhance contrast

% HE只equalize峰值的部分(peak area)，也就是同灰度值的数量很多的给分散开了
% CS会equalize全部的，所有的都被stretch开了
clear
close all
clc

histx = 0:1:255;
pics = {'moon.png'; 'house.png'; 'spine.jpg'; 'church.png'};

for i = 1:size(pics, 1)
    pic = imread(char(pics(i)));
    cs = uint8(ContrastStretch(pic, 0, 255));
    eq = uint8(histequal(pic)); % Histogram Equalization

    figure; % Compare the images and histograms before and after processing
    subplot 231; imshow(pic); title('Original');
    subplot 232; imshow(cs); title('Contrast stretched');
    subplot 233; imshow(eq); title('Histogram equalized');
    subplot 234; bar(histx, hist_of_pic(pic));
    subplot 235; bar(histx, hist_of_pic(cs));
    subplot 236; bar(histx, hist_of_pic(eq));
end


%% Histogram Matching
% Histogram matching is the transformation of an image so that its histogram matches a specified histogram
% The histogram equalization method is a special case in which the specified histogram is uniformly distributed

% Used to balance detector responses as a relative detector calibration technique

clear
close all
clc

A = imread('corel.png'); % ref
B = imread('spine.jpg'); % target spine.jpg church.png
histx = 0:1:255;

% outB = histmatching(A, B);
% figure;
% subplot 231; imshow(A); title('Reference');
% subplot 232; imshow(B); title('Target - original');
% subplot 233; imshow(outB); title('Target - matched');
% subplot 234; bar(histx, hist_of_pic(A));
% subplot 235; bar(histx, hist_of_pic(B));
% subplot 236; bar(histx, hist_of_pic(outB));


% B - ref, A - target
outA = histmatching(A, B); 
figure;
subplot 231; imshow(B); title('Reference');
subplot 232; imshow(A); title('Target - original');
subplot 233; imshow(outA); title('Target - matched');
subplot 234; bar(histx, hist_of_pic(B));
subplot 235; bar(histx, hist_of_pic(A));
subplot 236; bar(histx, hist_of_pic(outA));

%% 4
% Why applying histogram equalization multiple times will have no additional effect
% ANSWER: The luminance is equalized after the first histogram
% equalization, so the distribution will not change that much.

% OTHERS
% Its function is to produce an equalized histogram (that is an uniform probability density function)
% The algorithm used there will always have trouble producing a flat histogram
% What the equalizer tries to do is to make the cumulative distribution of the signal as linear as possible
% 用来增加许多图像的全局对比度，尤其是当图像的有用数据的对比度相当接近的时候
% 通过这种方法，亮度可以更好地在直方图上分布，这样就可以用于增强局部的对比度而不影响整体的对比度
% 对于背景和前景都太亮或者太暗的图像非常有用
% 缺点是它对处理的数据不加选择，可能会增加背景噪声的对比度并且降低有用信号的对比度



%% 5
% For the case of the localized histogram equalization,
% how do you think the images moon.png and spine.jpg would look like after processing?
% ANSWER: More details and more noises in picture with high pixel intensity.

% OTHERS
% Local histogram equalization spreads out the most frequent intensity values in an image
% The local version of the histogram equalization emphasized every local graylevel variations


