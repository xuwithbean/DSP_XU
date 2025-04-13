function [frameData, frameNum] = enFrame(audioData, frameLen, windowName, Fs, inc)

if (nargin < 5) % 如果只有4个参数，设：帧移=帧长
    inc = len;
end
time = length(audioData) / Fs;
frameNum = floor((Fs * time - frameLen + inc) / inc);
frameData = zeros(frameNum, frameLen);
frameIndex = inc * (0:(frameNum - 1)).';
index = 1:frameLen;

% 判断窗函数
if strcmp(windowName, 'hanning')
    win = hanning(frameLen); % hanning 窗
elseif strcmp(windowName, 'hamming')
    win = hamming(frameLen); % hamming 窗
else
    win = rectwin(frameLen); % 矩形窗
end

% 分帧
frameData(:) = audioData(frameIndex(:, ones(1, frameLen)) + index(ones(frameNum, 1), :));

% 加窗
frameData = frameData .* (win.');
