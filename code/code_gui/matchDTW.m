function [result, freq] = matchDTW(inputData, Fs, frameLen, inc, M, L, wordNum)
% 输入经端点检测后的有效输入信号, 获得匹配结果

% 计算 MFCC
inputMat = countMFCC(inputData, frameLen, Fs, 'hamming', inc, M, L);
% 标准化
inputMat  = CMN(inputMat);
allScores = DTWScores(inputMat, wordNum);
[~, index] = sort(allScores, 2);
% 得到各模板匹配的 2 个最低值对应的次序
bestWords = index(:, 1:2);
% 出现次数最高的词汇认定为识别结果
[result, freq] = mode(bestWords, 'all');
