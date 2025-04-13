clc, clear, close all
M = 26;
L = 12; 
wordNum = 10;
wordList = char('Zero','One','Two','Three','Four','Five','Six','Seven','Eight','Nine');
dataName = '.\audioLib\nine_4.wav';
[inputData, Fs] = audioread(dataName);
if Fs == 44100
    frameLen = 1024;
    inc = frameLen / 2;
else
    frameLen = 256;
    inc = frameLen / 2;
end
inputData = inputData / max(abs(inputData));
inputData = validAudio(inputData, frameLen, Fs, 'hamming', inc);
inputMat = countMFCC(inputData, frameLen, Fs, 'hamming', inc, M, L);
inputMat  = CMN(inputMat);
allScores = DTWScores(inputMat, wordNum);
[sortedScores, index] = sort(allScores, 2);
bestWords = index(:, 1:2);
[result, freq] = mode(bestWords, 'all');
if mean(abs(inputData)) < 0.01
    fprintf('No microphone connected or you have not said anything.\n');
elseif (freq <= 2)
    fprintf('The word you have said could not be properly recognized.\n');
else
    fprintf("You have just said '%s'.\n", wordList(result, :)); 
end
