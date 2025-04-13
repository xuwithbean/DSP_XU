'''
 * @file main.py
 * @author Jiaxu Xiao
 * @brief detect 0-9 from voice
 * @version 0.1
 * @date 2024-10-13
 * 
 * @copyright Copyright (c) 2024
'''
import os
import numpy as np
import pandas as pd
from sklearn.preprocessing import MinMaxScaler
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.metrics import classification_report
import matplotlib.pyplot as plt
import librosa
import audioprocess
import warnings
warnings.filterwarnings("ignore")
avg_en_list = np.zeros(100)
avg_mn_list = np.zeros(100)
avg_zn_list = np.zeros(100)
label_list = np.zeros(100)
maindir = './audioLib'
subdirs = [d for d in os.listdir(maindir) if os.path.isdir(os.path.join(maindir, d))]
idx = 0

for subdir in subdirs:
    data_path = os.path.join(maindir, subdir, '*.wav')
    wav_files = [f for f in os.listdir(os.path.join(maindir, subdir)) if f.endswith('.wav')]
    
    for wav_file in wav_files:
        data_name = os.path.join(maindir, subdir, wav_file)
        data, Fs = librosa.load(data_name, sr=None)
        data = data / np.max(np.abs(data))
        time = np.arange(len(data)) / Fs
        avg_en, avg_mn, avg_zn, start_time, final_time = audioprocess.audio_process(data, Fs, 'hamming', idx)
        plt.figure(figsize=(10, 6))
        plt.subplot(4, 2, 8)
        plt.plot(time, data, 'k')
        plt.title('Endpoint detection with double thresholds')
        plt.xlabel('time/s')
        plt.ylabel('value')
        plt.axis([0, np.max(time), -1, 1])
        plt.axvline(x=start_time, color='r', linestyle='-')
        plt.axvline(x=final_time, color='b', linestyle='-')
        plt.tight_layout()
        plt.show()
        avg_en_list[idx] = avg_en
        avg_mn_list[idx] = avg_mn
        avg_zn_list[idx] = avg_zn
        label_list[idx] = int(subdir)
        idx += 1
U = np.array([avg_en_list, avg_mn_list, avg_zn_list])
scaler = MinMaxScaler()
Z = scaler.fit_transform(U.T).T
avg_en_list_1 = Z[0, :]
avg_mn_list_1 = Z[1, :]
avg_zn_list_1 = Z[2, :]
train_data = pd.DataFrame({
    'avgEn': avg_en_list_1,
    'avgMn': avg_mn_list_1,
    'avgZn': avg_zn_list_1,
    'label': label_list
})
train_data.to_excel('./train.xlsx', index=False)
training_data = pd.read_excel('./train.xlsx')
X = training_data[['avgEn', 'avgMn', 'avgZn']]
y = training_data['label']
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=330)
knn_classifiers = {
    'WeightedKNN': KNeighborsClassifier(n_neighbors=5, weights='distance'),
    'FineKNN': KNeighborsClassifier(n_neighbors=1),
    'MediumNN': KNeighborsClassifier(n_neighbors=10),
    'WideNN': KNeighborsClassifier(n_neighbors=20),
    'SubspaceKNN': KNeighborsClassifier(n_neighbors=5, metric='manhattan')
}
validation_acc = []
for name, clf in knn_classifiers.items():
    clf.fit(X_train, y_train)
    scores = cross_val_score(clf, X_train, y_train, cv=5)
    validation_acc.append(np.mean(scores))
    print(f'{name} Validation Accuracy: {np.mean(scores):.2f}')
    y_pred = clf.predict(X_test)
    print(f'{name} Classification Report:')
    print(classification_report(y_test, y_pred))
# predict_label = knn_classifiers['WeightedKNN'].predict(predict_data)
