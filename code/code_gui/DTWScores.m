function allScores = DTWScores(inputMat, N)
% 动态时间规整（DTW）寻找最小失真
% input: 
%     inputMat: 输入语音 MFCC 矩阵
%     N: 各模板内词汇总数
% output: 
%     allScores: 各模板匹配得分序列

% 加载模板数据
struct = load('templateMats0.mat');
templateMats0 = struct2cell(struct);
struct = load('templateMats1.mat');
templateMats1 = struct2cell(struct);
struct = load('templateMats2.mat');
templateMats2 = struct2cell(struct);
struct = load('templateMats3.mat');
templateMats3 = struct2cell(struct);
struct = load('templateMats4.mat');
templateMats4 = struct2cell(struct);
struct = load('templateMats5.mat');
templateMats5 = struct2cell(struct);
struct = load('templateMats6.mat');
templateMats6 = struct2cell(struct);
struct = load('templateMats7.mat');
templateMats7 = struct2cell(struct);
struct = load('templateMats8.mat');
templateMats8 = struct2cell(struct);
struct = load('templateMats9.mat');
templateMats9 = struct2cell(struct);

% 计算 DTW
scores0 = zeros(1, N);
scores1 = zeros(1, N);
scores2 = zeros(1, N);
scores3 = zeros(1, N);
scores4 = zeros(1, N);
scores5 = zeros(1, N);
scores6 = zeros(1, N);
scores7 = zeros(1, N);
scores8 = zeros(1, N);
scores9 = zeros(1, N);

for i = 1:N
    templateMat0 = templateMats0{i, 1};
    templateMat1 = templateMats1{i, 1};
    templateMat2 = templateMats2{i, 1};
    templateMat3 = templateMats3{i, 1};
    templateMat4 = templateMats4{i, 1};
    templateMat5 = templateMats5{i, 1};
    templateMat6 = templateMats6{i, 1};
    templateMat7 = templateMats7{i, 1};
    templateMat8 = templateMats8{i, 1};
    templateMat9 = templateMats9{i, 1};
    % 标准化
    templateMat0 = CMN(templateMat0);
    templateMat1 = CMN(templateMat1);
    templateMat2 = CMN(templateMat2);
    templateMat3 = CMN(templateMat3);
    templateMat4 = CMN(templateMat4);
    templateMat5 = CMN(templateMat5);
    templateMat6 = CMN(templateMat6);
    templateMat7 = CMN(templateMat7);
    templateMat8 = CMN(templateMat8);
    templateMat9 = CMN(templateMat9);
    % 匹配最优距离
    scores0(i) = dtw(templateMat0, inputMat);
    scores1(i) = dtw(templateMat1, inputMat);
    scores2(i) = dtw(templateMat2, inputMat);
    scores3(i) = dtw(templateMat3, inputMat);
    scores4(i) = dtw(templateMat4, inputMat);
    scores5(i) = dtw(templateMat5, inputMat);
    scores6(i) = dtw(templateMat6, inputMat);
    scores7(i) = dtw(templateMat7, inputMat);
    scores8(i) = dtw(templateMat8, inputMat);
    scores9(i) = dtw(templateMat9, inputMat);
end

allScores = [scores0; scores1; scores2; scores3; scores4; scores5; scores6; scores7; scores8; scores9];
