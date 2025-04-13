function [trainedClassifier, validationAcc, stats] = WeightedKNN(trainingData)
inputTable = trainingData;
predictorNames = {'avgEn', 'avgMn', 'avgZn'};
predictors = inputTable(:, predictorNames);
response = inputTable.label;
isCategoricalPredictor = [false, false, false];
classificationKNN = fitcknn(...
    predictors, ...
    response, ...
    'Distance', 'Euclidean', ...
    'Exponent', [], ...
    'NumNeighbors', 10, ...
    'DistanceWeight', 'SquaredInverse', ...
    'Standardize', true, ...
    'ClassNames', categorical({'0'; '1'; '2'; '3'; '4'; '5'; '6'; '7'; '8'; '9'}));
predictorExtractionFcn = @(t) t(:, predictorNames);
knnPredictFcn = @(x) predict(classificationKNN, x);
trainedClassifier.predictFcn = @(x) knnPredictFcn(predictorExtractionFcn(x));
trainedClassifier.RequiredVariables = {'avgEn', 'avgMn', 'avgZn'};
trainedClassifier.ClassificationKNN = classificationKNN;
inputTable = trainingData;
predictorNames = {'avgEn', 'avgMn', 'avgZn'};
predictors = inputTable(:, predictorNames);
response = inputTable.label;
isCategoricalPredictor = [false, false, false];
partitionedModel = crossval(trainedClassifier.ClassificationKNN, 'KFold', 5);
[validationPredictions, validationScores] = kfoldPredict(partitionedModel);
validationAcc = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');
ClassNames = categorical({'0'; '1'; '2'; '3'; '4'; '5'; '6'; '7'; '8'; '9'});
C = confusionmat(response, validationPredictions, 'Order', ClassNames);
figure()
confusionchart(response, validationPredictions)
stats = statsOfMeasure(C);

