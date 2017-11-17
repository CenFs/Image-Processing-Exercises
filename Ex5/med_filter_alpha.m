function [O, count] = med_filter_alpha(I, ksize, alpha)
% func = @(block_struct) median(median(block_struct.data(:)));
% picout = uint8(blockproc(pic, [ksize ksize], func));

M = size(I, 1);
N = size(I, 2);
edge = round(ksize/2);
O = I;
count = 0;

for x = edge:M-edge
    for y = edge:N-edge
        kernel = I(x-edge+1:x+edge-1, y-edge+1:y+edge-1);
        if mod(ksize, 2) == 0
            kernel = I(x-edge+1:x+edge, y-edge+1:y+edge);
        end
        O(x, y) = median(median(kernel));
    end
end

for x = 1:M
    for y = 1:N
        if abs(I(x, y) - O(x, y)) > alpha
            O(x, y) = I(x, y);
            count = count + 1;
        end
    end
end

end