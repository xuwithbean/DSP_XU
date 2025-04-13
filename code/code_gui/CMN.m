function normMat = CMN(mat)
% 对矩阵数据进行归一化处理

[r, c] = size(mat);
normMat = zeros(r, c);
for i = 1:c
    matMean = mean(mat(:, i));
    normMat(:, i) = mat(:, i) - matMean;
end