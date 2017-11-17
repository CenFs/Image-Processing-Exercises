%% Image basics and useful commands
clear
close all

I = imread('peppers.png');
figure(1);imshow(I);

I1 = rgb2gray(I);
figure(2);imshow(I1);

% display only the red component of the original image
figure(3);imshow(I(:,:,1));

% Add value 50 to the green component of I2
I2 = I;
I2(:,:,2) = I2(:,:,2) + 50;
figure(4);imshow(I2);

% recombining the components in the order BGR
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);
I3 = cat(3, B, G, R);
figure(5);imshow(I3);

% display 4 images in a 2-by-2 layout
figure(6);
subplot(2, 2, 1);imshow(I);
subplot(2, 2, 2);imshow(I1);
subplot(2, 2, 3);imshow(I2);
subplot(2, 2, 4);imshow(I3);


%% Batch processing
% Clean the workspace memory
clear
close all

% Create a new m-file
% Create a function
% load Ex1_batch.m
Ex1_batch();

%% Binary processing

% a
A = [0 0 0 0 0 0 0 1 1 0;
    1 0 0 1 0 0 1 0 0 1;
    1 0 0 1 0 1 1 0 0 0;
    0 0 1 1 1 0 0 0 0 0;
    0 0 1 1 1 0 0 1 1 1];
imshow(A, 'InitialMagnification', 'fit');

% b
% load non_zero.m
S1 = A(1:4, 2:5);
S2 = A(1:4, 6:9);
fprintf('%s\t%d\n%s\t%d\n','S1', non_zero(S1), 'S2', non_zero(S2));

% c
load S.mat
fprintf('%s\t%d\n','S', non_zero(S));
