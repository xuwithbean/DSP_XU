function [start, final] = endpointDetect(En, Zn)
frameNum = length(En);
noise_begin = length(En) - 19;
noise_end = length(En) - 1;
avgNoiseEn = mean(En(noise_begin:noise_end));
stdNoiseEn = std(En(noise_begin:noise_end));
avgNoiseZn = mean(Zn(noise_begin:noise_end));
stdNoiseZn = std(Zn(noise_begin:noise_end));
MH = mean(En) / 4;
ML = (avgNoiseEn + MH) / 4;
Zs = avgNoiseZn + 3 * stdNoiseZn;
M = 3;
i = 1;
flag = 1;
while flag
    while En(i) < MH
        if i >= frameNum
            break;
        end
        i = i + 1;
    end
    flag = 0;
    begin_1 = i;
    for j = (i + 1):(i + M)
        if j >= frameNum
            break;
        end
        if En(j) < MH
            i = j + 1;
            flag = 1;
        end
    end
end
i = frameNum;
flag = 1;
while flag
    while En(i) < MH
        if i <= 1
            break;
        end
        i = i - 1;
    end
    flag = 0;
    end_1 = i;
    for j = (i - 1):(i - M)
        if j <= 1
            break;
        end
        if En(j) < MH
            i = j - 1;
            flag = 1;
        end
    end
end
i = begin_1 - 1;
while i > 1
    if En(i) > ML
        i = i - 1;
    else
        break;
    end
end
begin_2 = i;
i = end_1 + 1;
while i < frameNum
    if En(i) > ML
        i = i + 1;
    else
        break;
    end
end
end_2 = i;
i = begin_2 - 1;
while i > 1 && Zn(i) > Zs
    i = i - 1;
end
begin_3 = i;
i = end_2 + 1;
while i < frameNum && Zn(i) > Zs
    i = i + 1;
end
end_3 = i;
start = begin_3;
final = end_3;
