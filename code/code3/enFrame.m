function [frameData, frameNum] = enFrame(audioData, frameLen, windowName, Fs, inc)
if (nargin < 5)
    inc = len;
end
time = length(audioData) / Fs;
frameNum = floor((Fs * time - frameLen + inc) / inc);
frameData = zeros(frameNum, frameLen);
frameIndex = inc * (0:(frameNum - 1)).';
index = 1:frameLen;
if strcmp(windowName, 'hanning')
    win = hanning(frameLen);
elseif strcmp(windowName, 'hamming')
    win = hamming(frameLen);
else
    win = rectwin(frameLen);
end
frameData(:) = audioData(frameIndex(:, ones(1, frameLen)) + index(ones(frameNum, 1), :));
frameData = frameData .* (win.');
