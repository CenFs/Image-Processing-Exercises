function I = intensityeq(I)
H = rgb2hsv(I);
h = H(:, :, 1);
s = H(:, :, 2);
v = H(:, :, 3);
I = hsv2rgb(cat(3, h, s, histeq(v)));
end