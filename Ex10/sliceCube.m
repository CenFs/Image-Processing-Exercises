function I = sliceCube(I, dist) % Manhattan distance
    C = impixel(I); close
    if size(C, 1) > 1
        C = round(mean(C));
    end
    IR = double(I(:, :, 1)); IG = double(I(:, :, 2)); IB = double(I(:, :, 3));
    CR = C(1) * ones(size(I, 1), size(I, 2));
    CG = C(2) * ones(size(I, 1), size(I, 2));
    CB = C(3) * ones(size(I, 1), size(I, 2));
    Cmask = abs(IR-CR) + abs(IG-CG) + abs(IB-CB) <= dist;
    Cmask = cat(3, Cmask, Cmask, Cmask);
    I = I .* uint8(Cmask);
end