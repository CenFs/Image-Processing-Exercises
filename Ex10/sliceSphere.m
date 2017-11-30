function I = sliceSphere(I, dist) % Euclidean distance
    C = impixel(I); close
    if size(C, 1) > 1
        C = round(mean(C));
    end
    IR = double(I(:, :, 1)); IG = double(I(:, :, 2)); IB = double(I(:, :, 3));
    CR = C(1); CG = C(2); CB = C(3);
    Cmask = zeros(size(IR));
    for i = 1:size(I, 1)
        for j = 1:size(I, 2)
            if (IR(i, j)-CR)^2 + (IG(i, j)-CG)^2 + (IB(i, j)-CB)^2 <= dist^2
                Cmask(i, j) = 1;
            end
        end
    end
    Cmask = cat(3, Cmask, Cmask, Cmask);
    I = I .* uint8(Cmask);
end