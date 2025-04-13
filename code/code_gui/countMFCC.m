function mfcc = countMFCC(data, frameLen, Fs, windowName, inc, M, L)

%% 参数设置
N = 2 ^ nextpow2(frameLen);
halfN = floor(N/2) + 1;

% Mel 滤波器组
bank = melbankm(M, N, Fs, 0, 0.5, 't');
% 归一化 Mel 滤波器组系数
bank = full(bank);
bank = bank / max(bank(:));

% DCT系数矩阵
DCTcoef = zeros(L, M);
m = 0:(M - 1);
for n = 1:L
    DCTcoef(n, :) = cos((2 * m + 1) * n * pi / (2 * M));
end

% % 倒谱提升
% i = 1:L;
% w = 1 + (22/2) * sin(pi*i./22);
% % 归一化
% w = w/max(w);

%% 数据预处理
% 预加重
b = [1, -0.97];
a = 1;
dataF = filter(b, a, double(data));
% 分帧加窗
[frameData, frameNum] = enFrame(dataF, frameLen, windowName, Fs, inc);

%% 求 MFCC
mfcc = zeros(frameNum, L);
for i = 1:frameNum
    frame = frameData(i, :);
    X = abs(fft(frame, N));
    E = X.^2;       % E = X.^2 / N;
    S = bank * E(1:halfN).';
    % 滤波并加 1e-22, 防止进行对数运算后变成无穷
    mfcc(i, :) = sqrt(2 / M) .* (DCTcoef * log(S + 1e-22)).';
end
