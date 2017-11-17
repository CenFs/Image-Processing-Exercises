function histeq = histequal(pic)
% h(v) = round((cdf(v)-cdfmin) / (M*N-cdfmin) * (L-1))
pic = double(pic);
% minvalue = max(max(pic));
% maxvalue = min(min(pic));
M = size(pic, 1);
N = size(pic, 2);
L = 256; % Grayscale

histy = zeros(1, L); % 1-256
for x = 1:1:M
    for y = 1:1:N
        index = pic(x, y) + 1;
        histy(index) = histy(index) + 1;
    end
end

cdf = histy;
for i = 2:1:L
    cdf(i) = cdf(i-1) + cdf(i);
end
cdfmin = min(cdf(cdf>0)); % Minimum value of cumulative distribution function

for v = 1:1:L
    h(v) = round((cdf(v)-cdfmin) / (M*N-1) * (L-1));
end

histeq = pic;
for x = 1:1:M
    for y = 1:1:N
        histeq(x, y) = uint8(h(pic(x, y) + 1));
    end
end

% figure, imshow(uint8([pic histeq]));
% title('Original image (left) and histogram equalized image (right).');

end