function normMat = CMN(mat)
[r, c] = size(mat);
normMat = zeros(r, c);
for i = 1:c
    matMean = mean(mat(:, i));
    normMat(:, i) = mat(:, i) - matMean;
end