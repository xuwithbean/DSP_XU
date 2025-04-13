function mfcc = countMFCC(data, frameLen, Fs, windowName, inc, M, L)
N = 2 ^ nextpow2(frameLen);
halfN = floor(N/2) + 1;
bank = melbankm(M, N, Fs, 0, 0.5, 't');
bank = full(bank);
bank = bank / max(bank(:));
DCTcoef = zeros(L, M);
m = 0:(M - 1);
for n = 1:L
    DCTcoef(n, :) = cos((2 * m + 1) * n * pi / (2 * M));
end
b = [1, -0.97];
a = 1;
dataF = filter(b, a, double(data));
[frameData, frameNum] = enFrame(dataF, frameLen, windowName, Fs, inc);
mfcc = zeros(frameNum, L);
for i = 1:frameNum
    frame = frameData(i, :);
    X = abs(fft(frame, N));
    E = X.^2;
    S = bank * E(1:halfN).';
    mfcc(i, :) = sqrt(2 / M) .* (DCTcoef * log(S + 1e-22)).';
end
