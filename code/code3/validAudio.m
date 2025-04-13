function [validData, avgEn, avgMn, avgZn, startTime, finalTime] = validAudio(data, frameLen, Fs, windowName, inc)
[frameData, frameNum] = enFrame(data, frameLen, windowName, Fs, inc);
En = zeros(1, frameNum);
Mn = zeros(1, frameNum);
Zn = zeros(1, frameNum);
for i = 1:frameNum
    x = frameData(i, :);
    En(i) = sum(x.*x);
    Mn(i) = sum(abs(x));
    for j = 1:(frameLen - 1)
        Zn(i) = Zn(i) + abs(sign(x(j + 1))-sign(x(j))) / 2;
    end
end
[start, final] = endpointDetect(En, Zn);
startIdx = (start - 1) * inc + 1;
if ((final - 1) * inc + frameLen) <= length(data)
    finalIdx = (final - 1) * inc + frameLen;
else
    finalIdx = length(data);
end
validData = data(startIdx:finalIdx);
avgEn = mean(En(start:final));
avgMn = mean(Mn(start:final));
avgZn = mean(Zn(start:final));
startTime = startIdx / Fs;
finalTime = finalIdx / Fs;