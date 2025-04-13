function dist = dtw(templateMat, inputMat)
% input
%     templateMat: 模板语音 MFCC 矩阵, size: r1(帧) * L(阶)
%     inputMat: 输入语音 MFCC 矩阵, size: r2(帧) * L(阶)
% output
%     dist: 最优距离

r1 = size(templateMat, 1);
r2 = size(inputMat, 1);
L = size(templateMat, 2);
distMat = zeros(r1, r2);
for i = 1:r1
    for j = 1:r2
        vecT = templateMat(i, :);
        vecI = inputMat(j, :);
        % 采用欧氏距离
        distMat(i, j) = sqrt(sum((vecT - vecI).^2)) / L;
    end
end

D = zeros(r1+1, r2+1);
D(1, :) = inf;
D(:, 1) = inf;
D(1, 1) = 0;
D(2:(r1+1), 2:(r2+1)) = distMat;

% 寻找整个过程的最短匹配距离
for i = 1:r1
    for j = 1:r2
        dmin = min([D(i, j), D(i, j+1), D(i+1, j)]);
        D(i+1, j+1) = D(i+1, j+1) + dmin;
    end
end

% 返回最终距离
dist = D(r1+1, r2+1);
