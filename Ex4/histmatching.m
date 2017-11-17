function out = histmatching(A, B) % Apply histogram matching from image A to image B (CDFs ����ƥ��)
L = 256;
G1 = 1:1:L; % 0-255

%% Compute their histograms
histA = hist_of_pic(A);
histB = hist_of_pic(B);
% histx = 0:1:255;
% bar(histx, histA);

%% Calculate the cumulative distribution functions of the two images' histograms
% histA = imhist(A);
% cdfA = cumsum(histA) / numel(A);
F1 = histA;
for i = 2:1:L
    F1(i) = F1(i-1) + F1(i);
end
F1 = F1 / numel(A);

F2 = histB;
for i = 2:1:L
    F2(i) = F2(i-1) + F2(i);
end
F2 = F2 / numel(B);



%% Compute the mapping
% % F1(G1) = F2(G2); M(G2) = G1; 
% % A - ref, B - target
% M = zeros(1, L, 'uint8'); % Store mapping, cast to uint8 to respect data type
% for idx = 1:L
%     [~, ind] = min(abs(F2(idx) - F1)); % F2(x2)�ҵ���֮�����С��F1���ڵ�x1=A�ĻҶ�+1
%     M(idx) = ind - 1; % M(x2) = graylevel of A % ����A�ı�B
% end
% % apply the mapping to get B to make it look like the distribution of A
% out = M(double(B) + 1); % index = graylevel + 1


% F1(G1) = F2(G2); M(G1) = G2; 
% B - ref, A - target
M = zeros(1, L, 'uint8'); % Store mapping, cast to uint8 to respect data type
for idx = 1:L
    [~, ind] = min(abs(F1(idx) - F2)); % F1(x1)�ҵ���֮�����С��F2���ڵ�x2=B�ĻҶ�+1
    M(idx) = ind - 1; % M(x1) = graylevel of B % ����B�ı�A
end
% apply the mapping to get B to make it look like the distribution of A
out = M(double(A) + 1); % index = graylevel + 1


%%
histout = hist_of_pic(out);
Fout = histout;
for i = 2:1:L
    Fout(i) = Fout(i-1) + Fout(i);
end
Fout = Fout / numel(out);


figure; 
plot(G1, F1, 'b-'); hold on; plot(G1, F2, 'r-'); hold on; plot(G1, Fout, 'p-');
% legend('Image A', 'Image B', 'Image outB');
legend('Image A', 'Image B', 'Image outA');

end