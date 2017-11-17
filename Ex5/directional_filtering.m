function [pic0, pic45, pic90, pic135] = directional_filtering(pic, ksize)
filter0 = zeros(ksize, ksize);
filter0(round(ksize/2), :) = ones(1, ksize) / ksize;
filter45 = eye(ksize) / ksize;
filter90 = filter0';
filter135 = imrotate(filter45, 90);

% filter135 = zeros(ksize, ksize);
% for i = 1:ksize
%     filter135(:, i) = filter45(:, ksize-i+1);
% end


pic0 = imfilter(pic, filter0);
pic45 = imfilter(pic, filter45);
pic90 = imfilter(pic, filter90);
pic135 = imfilter(pic, filter135);
% conv2?
end