clc, clear, close all
M = 26;
L = 12;
maindir = '.\audioLib';
subdir = dir(maindir);
idx = 1;
for i = 1:length(subdir)
    if (isequal(subdir(i).name, '.') || isequal(subdir(i).name, '..') || ~subdir(i).isdir)
        continue;
    end
    dataPath = fullfile(maindir, subdir(i).name, '*.wav');
    datas = dir(dataPath);
    for j = 1:length(datas)
        dataName = fullfile(maindir, subdir(i).name, datas(j).name);
        [data, Fs] = audioread(dataName);
        if Fs == 44100
            frameLen = 1024;
            inc = frameLen / 2;
        else
            frameLen = 256;
            inc = frameLen / 2;
        end
        data = data / max(abs(data));
        time = (0:length(data) - 1) / Fs;
        mfcc = countMFCC(data, frameLen, Fs, 'hamming', inc, M, L);
        frameTime = (((1:size(mfcc, 1)) - 1) * inc + frameLen / 2) / Fs;
        figure(idx)
        subplot(2, 1, 1)
        plot(time, data, 'b')
        title('语音信号'); xlabel('时间/s'); ylabel('幅值');
        subplot(2, 1, 2)
        plot(frameTime, mfcc)
        title('MFCC系数'); xlabel('时间/s'); ylabel('幅值');
        idx = idx + 1;
    end
end