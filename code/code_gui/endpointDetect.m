function [start, final] = endpointDetect(En, Zn)
% 基于双门限法的端点检测
frameNum = length(En);

% 测量背景噪声参数, 用于选取阈值
noise_begin = length(En) - 19;
noise_end = length(En) - 1;                     % 假定环境噪声区间
avgNoiseEn = mean(En(noise_begin:noise_end));   % 计算环境噪声的平均短时能量
stdNoiseEn = std(En(noise_begin:noise_end));    % 计算环境噪声短时能量的标准差
avgNoiseZn = mean(Zn(noise_begin:noise_end));   % 环境噪声的平均过零率
stdNoiseZn = std(Zn(noise_begin:noise_end));    % 环境噪声的过零率的标准差

% 选取阈值
MH = mean(En) / 4;                  % 较高的能量阈值
ML = (avgNoiseEn + MH) / 4;         % 较低的能量阈值
Zs = avgNoiseZn + 3 * stdNoiseZn;   % 过零率阈值

% 验证帧数
M = 3;

% 初判起止点 (MH)
% begin_1
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
    % 为了防止是突发噪声，继续向后搜索 M 帧，看是否是真正的语音
    for j = (i + 1):(i + M)
        if j >= frameNum
            break;
        end
        if En(j) < MH
            % 后一帧能量低于门限，说明前一帧大概率不是语音
            i = j + 1;
            flag = 1;
        end
    end
end
% end_1
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
    % 为了防止是突发噪声，继续向后搜索 M 帧，看是否是真正的语音
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

% 判定语音段 (ML)
% begin_2
i = begin_1 - 1;
while i > 1
    if En(i) > ML
        i = i - 1;
    else
        break;
    end
end
begin_2 = i;
% end_2
i = end_1 + 1;
while i < frameNum
    if En(i) > ML
        i = i + 1;
    else
        break;
    end
end
end_2 = i;

% 语音段起止点 (Zs)
% begin_3
i = begin_2 - 1;
while i > 1 && Zn(i) > Zs
    i = i - 1;
end
begin_3 = i;
% end_3
i = end_2 + 1;
while i < frameNum && Zn(i) > Zs
    i = i + 1;
end
end_3 = i;

start = begin_3;
final = end_3;
