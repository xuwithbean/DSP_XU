'''
 * @file main.py
 * @author Jiaxu Xiao
 * @brief get the windows of the endpoint detection with double thresholds
 * @version 0.1
 * @date 2024-10-13
 * 
 * @copyright Copyright (c) 2024
'''
import numpy as np
from scipy.signal import windows
def enFrame(audio_data, frame_len, window_name, Fs):
    time = len(audio_data) / Fs
    overlap_len = frame_len // 2
    frame_num = int(np.floor((Fs * time / (frame_len / 2)) - 1))
    frame_data = np.zeros((frame_num, frame_len))
    audio_index = 0
    if window_name == 'hanning':
        win = windows.hann(frame_len)
    elif window_name == 'hamming':
        win = windows.hamming(frame_len)
    else:
        win = windows.boxcar(frame_len)
    for i in range(frame_num):
        start_flag = int(audio_index)
        end_flag = int(audio_index + frame_len)
        frame_data[i, :] = win * audio_data[start_flag:end_flag]
        audio_index = end_flag - overlap_len
    return frame_data, frame_num
