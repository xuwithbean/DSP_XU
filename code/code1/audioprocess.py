
'''
 * @file endpointdetect.py
 * @author Jiaxu Xiao
 * @brief process the audio we got
 * @version 0.1
 * @date 2024-10-13
 * 
 * @copyright Copyright (c) 2024
'''
import numpy as np
import  enframe
import matplotlib.pyplot as plt
import endpointdetect
def audio_process(data, Fs, windowName, idx):
    frameLen = 1024 if Fs == 44100 else 256
    frameData, frameNum = enframe.enFrame(data, frameLen, windowName, Fs)
    En = np.zeros(frameNum)
    Mn = np.zeros(frameNum)
    Zn = np.zeros(frameNum)
    for i in range(frameNum):
        x = frameData[i, :]
        En[i] = np.sum(x ** 2)
        Mn[i] = np.sum(np.abs(x))
        Zn[i] = np.sum(np.abs(np.sign(x[1:]) - np.sign(x[:-1]))) / 2
# draw
    time = np.arange(len(data)) / Fs
    frame_data_hanning, _ = enframe.enFrame(data, frameLen, 'hanning', Fs)
    frame_data_rect, _ = enframe.enFrame(data, frameLen, 'rectangle', Fs)
    frame_data_hamming, _ = enframe.enFrame(data, frameLen, 'hamming', Fs)
    
    plt.figure(idx)
    plt.subplot(4, 2, 1)
    plt.plot(time, data, 'k')
    plt.title('audio signal')
    plt.xlabel('time/s')
    plt.ylabel('value')
    
    plt.subplot(4, 2, 3)
    plt.plot(frame_data_rect)
    plt.title('Rectangle')
    plt.xlabel('time/s')
    plt.ylabel('value')
    
    plt.subplot(4, 2, 5)
    plt.plot(frame_data_hanning)
    plt.title('Hanning')
    plt.xlabel('time/s')
    plt.ylabel('value')
    
    plt.subplot(4, 2, 7)
    plt.plot(frame_data_hamming)
    plt.title('Hamming')
    plt.xlabel('time/s')
    plt.ylabel('value')
    
    plt.subplot(4, 2, 2)
    plt.plot(En, 'b')
    plt.title('energy')
    plt.xlabel('time/s')
    plt.ylabel('value')
    
    plt.subplot(4, 2, 4)
    plt.plot(Mn, 'b')
    plt.title('average value')
    plt.xlabel('time/s')
    plt.ylabel('value')
    
    plt.subplot(4, 2, 6)
    plt.plot(Zn, 'b')
    plt.title('overzero')
    plt.xlabel('time/s')
    plt.ylabel('value')
    start, final = endpointdetect.endpoint_detect(En, Zn)
    avgEn = np.mean(En[start:final])
    avgMn = np.mean(Mn[start:final])
    avgZn = np.mean(Zn[start:final])
    overlapLen = frameLen // 2
    inc = frameLen - overlapLen
    startTime = (start - 1) * inc / Fs
    finalTime = ((final - 1) * inc + frameLen) / Fs
    return avgEn, avgMn, avgZn, startTime, finalTime
    