clc, clear, close all

M = 26;
L = 12;             % MFCC 阶数
templateMats0 = cell(1, 10);
templateMats1 = cell(1, 10);
templateMats2 = cell(1, 10);
templateMats3 = cell(1, 10);
templateMats4 = cell(1, 10);
templateMats5 = cell(1, 10);
templateMats6 = cell(1, 10);
templateMats7 = cell(1, 10);
templateMats8 = cell(1, 10);
templateMats9 = cell(1, 10);

for i = 1:10
    switch i
        case 1
            dataName0 = '.\templateLib\template0\zero_0.wav';
            dataName1 = '.\templateLib\template1\zero_1.wav';
            dataName2 = '.\templateLib\template2\zero_2.wav';
            dataName3 = '.\templateLib\template3\zero_3.wav';
            dataName4 = '.\templateLib\template4\zero_4.wav';
            dataName5 = '.\templateLib\template5\zero_5.wav';
            dataName6 = '.\templateLib\template6\zero_6.wav';
            dataName7 = '.\templateLib\template7\zero_7.wav';
            dataName8 = '.\templateLib\template8\zero_8.wav';
            dataName9 = '.\templateLib\template9\zero_9.wav';
        case 2
            dataName0 = '.\templateLib\template0\one_0.wav';
            dataName1 = '.\templateLib\template1\one_1.wav';
            dataName2 = '.\templateLib\template2\one_2.wav';
            dataName3 = '.\templateLib\template3\one_3.wav';
            dataName4 = '.\templateLib\template4\one_4.wav';
            dataName5 = '.\templateLib\template5\one_5.wav';
            dataName6 = '.\templateLib\template6\one_6.wav';
            dataName7 = '.\templateLib\template7\one_7.wav';
            dataName8 = '.\templateLib\template8\one_8.wav';
            dataName9 = '.\templateLib\template9\one_9.wav';
        case 3
            dataName0 = '.\templateLib\template0\two_0.wav';
            dataName1 = '.\templateLib\template1\two_1.wav';
            dataName2 = '.\templateLib\template2\two_2.wav';
            dataName3 = '.\templateLib\template3\two_3.wav';
            dataName4 = '.\templateLib\template4\two_4.wav';
            dataName5 = '.\templateLib\template5\two_5.wav';
            dataName6 = '.\templateLib\template6\two_6.wav';
            dataName7 = '.\templateLib\template7\two_7.wav';
            dataName8 = '.\templateLib\template8\two_8.wav';
            dataName9 = '.\templateLib\template9\two_9.wav';
        case 4
            dataName0 = '.\templateLib\template0\three_0.wav';
            dataName1 = '.\templateLib\template1\three_1.wav';
            dataName2 = '.\templateLib\template2\three_2.wav';
            dataName3 = '.\templateLib\template3\three_3.wav';
            dataName4 = '.\templateLib\template4\three_4.wav';
            dataName5 = '.\templateLib\template5\three_5.wav';
            dataName6 = '.\templateLib\template6\three_6.wav';
            dataName7 = '.\templateLib\template7\three_7.wav';
            dataName8 = '.\templateLib\template8\three_8.wav';
            dataName9 = '.\templateLib\template9\three_9.wav';
        case 5
            dataName0 = '.\templateLib\template0\four_0.wav';
            dataName1 = '.\templateLib\template1\four_1.wav';
            dataName2 = '.\templateLib\template2\four_2.wav';
            dataName3 = '.\templateLib\template3\four_3.wav';
            dataName4 = '.\templateLib\template4\four_4.wav';
            dataName5 = '.\templateLib\template5\four_5.wav';
            dataName6 = '.\templateLib\template6\four_6.wav';
            dataName7 = '.\templateLib\template7\four_7.wav';
            dataName8 = '.\templateLib\template8\four_8.wav';
            dataName9 = '.\templateLib\template9\four_9.wav';
        case 6
            dataName0 = '.\templateLib\template0\five_0.wav';
            dataName1 = '.\templateLib\template1\five_1.wav';
            dataName2 = '.\templateLib\template2\five_2.wav';
            dataName3 = '.\templateLib\template3\five_3.wav';
            dataName4 = '.\templateLib\template4\five_4.wav';
            dataName5 = '.\templateLib\template5\five_5.wav';
            dataName6 = '.\templateLib\template6\five_6.wav';
            dataName7 = '.\templateLib\template7\five_7.wav';
            dataName8 = '.\templateLib\template8\five_8.wav';
            dataName9 = '.\templateLib\template9\five_9.wav';
        case 7
            dataName0 = '.\templateLib\template0\six_0.wav';
            dataName1 = '.\templateLib\template1\six_1.wav';
            dataName2 = '.\templateLib\template2\six_2.wav';
            dataName3 = '.\templateLib\template3\six_3.wav';
            dataName4 = '.\templateLib\template4\six_4.wav';
            dataName5 = '.\templateLib\template5\six_5.wav';
            dataName6 = '.\templateLib\template6\six_6.wav';
            dataName7 = '.\templateLib\template7\six_7.wav';
            dataName8 = '.\templateLib\template8\six_8.wav';
            dataName9 = '.\templateLib\template9\six_9.wav';
        case 8
            dataName0 = '.\templateLib\template0\seven_0.wav';
            dataName1 = '.\templateLib\template1\seven_1.wav';
            dataName2 = '.\templateLib\template2\seven_2.wav';
            dataName3 = '.\templateLib\template3\seven_3.wav';
            dataName4 = '.\templateLib\template4\seven_4.wav';
            dataName5 = '.\templateLib\template5\seven_5.wav';
            dataName6 = '.\templateLib\template6\seven_6.wav';
            dataName7 = '.\templateLib\template7\seven_7.wav';
            dataName8 = '.\templateLib\template8\seven_8.wav';
            dataName9 = '.\templateLib\template9\seven_9.wav';
        case 9
            dataName0 = '.\templateLib\template0\eight_0.wav';
            dataName1 = '.\templateLib\template1\eight_1.wav';
            dataName2 = '.\templateLib\template2\eight_2.wav';
            dataName3 = '.\templateLib\template3\eight_3.wav';
            dataName4 = '.\templateLib\template4\eight_4.wav';
            dataName5 = '.\templateLib\template5\eight_5.wav';
            dataName6 = '.\templateLib\template6\eight_6.wav';
            dataName7 = '.\templateLib\template7\eight_7.wav';
            dataName8 = '.\templateLib\template8\eight_8.wav';
            dataName9 = '.\templateLib\template9\eight_9.wav';
        case 10
            dataName0 = '.\templateLib\template0\nine_0.wav';
            dataName1 = '.\templateLib\template1\nine_1.wav';
            dataName2 = '.\templateLib\template2\nine_2.wav';
            dataName3 = '.\templateLib\template3\nine_3.wav';
            dataName4 = '.\templateLib\template4\nine_4.wav';
            dataName5 = '.\templateLib\template5\nine_5.wav';
            dataName6 = '.\templateLib\template6\nine_6.wav';
            dataName7 = '.\templateLib\template7\nine_7.wav';
            dataName8 = '.\templateLib\template8\nine_8.wav';
            dataName9 = '.\templateLib\template9\nine_9.wav';
    end
    [data0, Fs0] = audioread(dataName0);
    if Fs0 == 44100
        frameLen = 1024;
        inc = frameLen / 2;
    else
        frameLen = 256;
        inc = frameLen / 2;
    end
    data0 = data0 / max(abs(data0));
    data0 = validAudio(data0, frameLen, Fs0, 'hamming', inc);
    mfcc = countMFCC(data0, frameLen, Fs0, 'hamming', inc, M, L);
    templateMats0(1, i) = {mfcc};

    [data1, Fs1] = audioread(dataName1);
    if Fs1 == 44100
        frameLen = 1024;
        inc = frameLen / 2;
    else
        frameLen = 256;
        inc = frameLen / 2;
    end
    data1 = data1 / max(abs(data1));
    data1 = validAudio(data1, frameLen, Fs1, 'hamming', inc);
    mfcc = countMFCC(data1, frameLen, Fs1, 'hamming', inc, M, L);
    templateMats1(1, i) = {mfcc};

    [data2, Fs2] = audioread(dataName2);
    if Fs2 == 44100
        frameLen = 1024;
        inc = frameLen / 2;
    else
        frameLen = 256;
        inc = frameLen / 2;
    end
    data2 = data2 / max(abs(data2));
    data2 = validAudio(data2, frameLen, Fs2, 'hamming', inc);
    mfcc = countMFCC(data2, frameLen, Fs2, 'hamming', inc, M, L);
    templateMats2(1, i) = {mfcc};

    [data3, Fs3] = audioread(dataName3);
    if Fs3 == 44100
        frameLen = 1024;
        inc = frameLen / 2;
    else
        frameLen = 256;
        inc = frameLen / 2;
    end
    data3 = data3 / max(abs(data3));
    data3 = validAudio(data3, frameLen, Fs3, 'hamming', inc);
    mfcc = countMFCC(data3, frameLen, Fs3, 'hamming', inc, M, L);
    templateMats3(1, i) = {mfcc};

    [data4, Fs4] = audioread(dataName4);
    if Fs4 == 44100
        frameLen = 1024;
        inc = frameLen / 2;
    else
        frameLen = 256;
        inc = frameLen / 2;
    end
    data4 = data4 / max(abs(data4));
    data4 = validAudio(data4, frameLen, Fs4, 'hamming', inc);
    mfcc = countMFCC(data4, frameLen, Fs4, 'hamming', inc, M, L);
    templateMats4(1, i) = {mfcc};

    [data5, Fs5] = audioread(dataName5);
    if Fs5 == 44100
        frameLen = 1024;
        inc = frameLen / 2;
    else
        frameLen = 256;
        inc = frameLen / 2;
    end
    data5 = data5 / max(abs(data5));
    data5 = validAudio(data5, frameLen, Fs5, 'hamming', inc);
    mfcc = countMFCC(data5, frameLen, Fs5, 'hamming', inc, M, L);
    templateMats5(1, i) = {mfcc};

    [data6, Fs6] = audioread(dataName6);
    if Fs6 == 44100
        frameLen = 1024;
        inc = frameLen / 2;
    else
        frameLen = 256;
        inc = frameLen / 2;
    end
    data6 = data6 / max(abs(data6));
    data6 = validAudio(data6, frameLen, Fs6, 'hamming', inc);
    mfcc = countMFCC(data6, frameLen, Fs6, 'hamming', inc, M, L);
    templateMats6(1, i) = {mfcc};

    [data7, Fs7] = audioread(dataName7);
    if Fs7 == 44100
        frameLen = 1024;
        inc = frameLen / 2;
    else
        frameLen = 256;
        inc = frameLen / 2;
    end
    data7 = data7 / max(abs(data7));
    data7 = validAudio(data7, frameLen, Fs7, 'hamming', inc);
    mfcc = countMFCC(data7, frameLen, Fs7, 'hamming', inc, M, L);
    templateMats7(1, i) = {mfcc};

    [data8, Fs8] = audioread(dataName8);
    if Fs8 == 44100
        frameLen = 1024;
        inc = frameLen / 2;
    else
        frameLen = 256;
        inc = frameLen / 2;
    end
    data8 = data8 / max(abs(data8));
    data8 = validAudio(data8, frameLen, Fs8, 'hamming', inc);
    mfcc = countMFCC(data8, frameLen, Fs8, 'hamming', inc, M, L);
    templateMats8(1, i) = {mfcc};

    [data9, Fs9] = audioread(dataName9);
    if Fs9 == 44100
        frameLen = 1024;
        inc = frameLen / 2;
    else
        frameLen = 256;
        inc = frameLen / 2;
    end
    data9 = data9 / max(abs(data9));
    data9 = validAudio(data9, frameLen, Fs9, 'hamming', inc);
    mfcc = countMFCC(data9, frameLen, Fs9, 'hamming', inc, M, L);
    templateMats9(1, i) = {mfcc};
end

% 保存为 .mat
fields = {'Zero','One','Two','Three','Four','Five','Six','Seven','Eight','Nine'};
% fields 项作为行
s0 = cell2struct(templateMats0, fields, 2);
save templateMats0.mat -struct s0;
s1 = cell2struct(templateMats1, fields, 2);
save templateMats1.mat -struct s1;
s2 = cell2struct(templateMats2, fields, 2);
save templateMats2.mat -struct s2;
s3 = cell2struct(templateMats3, fields, 2);
save templateMats3.mat -struct s3;
s4 = cell2struct(templateMats4, fields, 2);
save templateMats4.mat -struct s4;
s5 = cell2struct(templateMats5, fields, 2);
save templateMats5.mat -struct s5;
s6 = cell2struct(templateMats6, fields, 2);
save templateMats6.mat -struct s6;
s7 = cell2struct(templateMats7, fields, 2);
save templateMats7.mat -struct s7;
s8 = cell2struct(templateMats8, fields, 2);
save templateMats8.mat -struct s8;
s9 = cell2struct(templateMats9, fields, 2);
save templateMats9.mat -struct s9;
