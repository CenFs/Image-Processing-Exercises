function pic = ContrastStretch(I)
minvalue = min(I(:));
maxvalue = max(I(:));
pic = (I - minvalue) .* (255 / (maxvalue - minvalue)); 
% Formula
% Pout = (Pin - lowest pixel value) * 
% ((upper limits - lower) / (highest pixel value - lowest)) + lower limits
end