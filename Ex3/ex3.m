%%
clear
close all

% a
pic = imread('wom1.png');
% I = reshape(pic, 1, 256*256)';
% I = im2double(pic);
bin = 256;
% figure(1); hist(I, bin);

histx = 0:1:255;
histy = zeros(1, bin); % 0-255
for x = 1:1:256
    for y = 1:1:256
        index = pic(x, y) + 1; % index = value + 1
        histy(index) = histy(index) + 1;
    end
end

figure(1); bar(histx, histy);


% c
pic2 = imread('man8.png');

pic1 = ContrastStretch(pic);
pic3 = ContrastStretch(pic2);

pics(:,:,1) = pic;
pics(:,:,2) = pic1;
pics(:,:,3) = pic2;
pics(:,:,4) = pic3;

hists = zeros(4, bin);
hists(1,:) = histy;
for i = 2:1:4
    histy = zeros(1, bin); % 0-255
    tmp = pics(:,:,i);
    for x = 1:1:256
        for y = 1:1:256
            index = tmp(x, y) + 1; % index = value + 1
            histy(index) = histy(index) + 1;
        end
    end
    hists(i,:) = histy;
end


figure(2);
subplot(2,2,1); imshow(pic); title('Original Image');
subplot(2,2,2); bar(histx, hists(1,:));
subplot(2,2,3); imshow(pic1); title('Contrast Streached Image');
subplot(2,2,4); bar(histx, hists(2,:));

figure(3);
subplot(2,2,1); imshow(pic2); title('Original Image');
subplot(2,2,2); bar(histx, hists(3,:));
subplot(2,2,3); imshow(pic3); title('Contrast Streached Image');
subplot(2,2,4); bar(histx, hists(4,:));




%%
clear
close all

% a
pic = imread('mbaboon.bmp');
func = @(block_struct) block_struct.data(2,2);
pic2 = blockproc(pic, [4 4], func);
figure(1); 
subplot(2,2,1); imshow(pic); title('Original Image');
subplot(2,2,2); imshow(pic2); title('Down sampled - (2,2)');


% b
func = @(block_struct) block_struct.data(1,1);
pic3 = blockproc(pic, [4 4], func);
subplot(2,2,3); imshow(pic3); title('Down sampled - (1,1)');

% c
func = @(block_struct) mean(block_struct.data(:)); % * ones(size(block_struct.data))
pic4 = uint8(blockproc(pic, [4 4], func));
subplot(2,2,4); imshow(pic4); title('Down sampled - Average intensity');





%% 3 Visual Perception: Diameter of pupil becomes larger

%%
pic = imread('wom1.png');
maxvalue = max(pic(:));
minvalue = min(pic(:));

c = 1.7;
pic2 = pic * c;
figure(1);
subplot(2,1,1); imhist(pic);
subplot(2,1,2); imhist(pic2);

c = 100;
pic3 = pic + c;
figure(2);
subplot(2,1,1); imhist(pic);
subplot(2,1,2); imhist(pic3);


pic4 = imrotate(pic, 270);
figure(3);
subplot(2,1,1); imhist(pic);
subplot(2,1,2); imhist(pic4);





