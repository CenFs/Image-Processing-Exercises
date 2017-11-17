function histy = hist_of_pic(pic)
pic = double(pic);
M = size(pic, 1);
N = size(pic, 2);
L = 256;
histy = zeros(1, L);
for x = 1:1:M
    for y = 1:1:N
        index = pic(x, y) + 1;
        histy(index) = histy(index) + 1;
    end
end
end
