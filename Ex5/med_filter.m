function picout = med_filter(pic, ksize)
% func = @(block_struct) median(median(block_struct.data(:)));
% picout = uint8(blockproc(pic, [ksize ksize], func));

M = size(pic, 1);
N = size(pic, 2);
edge = round(ksize/2);
picout = pic;

for x = edge:M-edge
    for y = edge:N-edge
        kernel = pic(x-edge+1:x+edge-1, y-edge+1:y+edge-1);
        if mod(ksize, 2) == 0
            kernel = pic(x-edge+1:x+edge, y-edge+1:y+edge);
        end
        picout(x, y) = median(median(kernel));
%         foutput = median(median(kernel)) * ones(ksize);
%         if mod(ksize, 2) == 1
%             O(x-edge+1:x+edge, y-edge+1:y+edge) = foutput;
%         end
%         if mod(ksize, 2) == 0
%             O(x-edge+1:x+edge, y-edge+1:y+edge) = foutput;
%         end
    end
end


end