function Ex1_batch()
for img = 1:6
    % name = sprintf('%s%d', 'c_', img);
    name = ['c_', num2str(img), '.jpg'];
    I = imread(name);
    A = Process(I);
    imwrite(A, ['c_', num2str(img), '.bmp']);
end
end

function A = Process(I)
% scale down to 75%
A = imresize(I, 0.75);

% take the right half of the image
x_middle = size(A) / 2;
A = A(:,x_middle + 1:end,:);

% mirror it along the center
A = fliplr(A);

% rotate 90 degrees counterclockwise
A = imrotate(A, 90);
end