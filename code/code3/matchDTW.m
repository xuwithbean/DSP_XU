function [result, freq] = matchDTW(inputData, Fs, frameLen, inc, M, L, wordNum)
inputMat = countMFCC(inputData, frameLen, Fs, 'hamming', inc, M, L);
inputMat  = CMN(inputMat);
allScores = DTWScores(inputMat, wordNum);
[~, index] = sort(allScores, 2);
bestWords = index(:, 1:2);
[result, freq] = mode(bestWords, 'all');
