function [trainedClassifier, validationAcc, stats] = WeightedKNN(trainingData)
% 提取预测变量和响应
inputTable = trainingData;
predictorNames = {'avgEn', 'avgMn', 'avgZn'};
predictors = inputTable(:, predictorNames);
response = inputTable.label;
isCategoricalPredictor = [false, false, false];

% 训练分类器
classificationKNN = fitcknn(...
    predictors, ...
    response, ...
    'Distance', 'Euclidean', ...
    'Exponent', [], ...
    'NumNeighbors', 10, ...
    'DistanceWeight', 'SquaredInverse', ...
    'Standardize', true, ...
    'ClassNames', categorical({'0'; '1'; '2'; '3'; '4'; '5'; '6'; '7'; '8'; '9'}));

% 使用预测函数创建结果结构体
predictorExtractionFcn = @(t) t(:, predictorNames);
knnPredictFcn = @(x) predict(classificationKNN, x);
trainedClassifier.predictFcn = @(x) knnPredictFcn(predictorExtractionFcn(x));

% 向结果结构体中添加字段
trainedClassifier.RequiredVariables = {'avgEn', 'avgMn', 'avgZn'};
trainedClassifier.ClassificationKNN = classificationKNN;

% 提取预测变量和响应
inputTable = trainingData;
predictorNames = {'avgEn', 'avgMn', 'avgZn'};
predictors = inputTable(:, predictorNames);
response = inputTable.label;
isCategoricalPredictor = [false, false, false];

% 执行交叉验证
partitionedModel = crossval(trainedClassifier.ClassificationKNN, 'KFold', 5);

% 计算验证预测
[validationPredictions, validationScores] = kfoldPredict(partitionedModel);

% 计算验证准确度
validationAcc = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');

% 计算其他指标
ClassNames = categorical({'0'; '1'; '2'; '3'; '4'; '5'; '6'; '7'; '8'; '9'});
% 先计算混淆矩阵
C = confusionmat(response, validationPredictions, 'Order', ClassNames);
% 绘制混淆矩阵
figure()
confusionchart(response, validationPredictions)
stats = statsOfMeasure(C);

