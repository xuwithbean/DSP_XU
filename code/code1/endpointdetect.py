'''
 * @file endpointdetect.py
 * @author Jiaxu Xiao
 * @brief Endpoint detection with double thresholds
 * @version 0.1
 * @date 2024-10-13
 * 
 * @copyright Copyright (c) 2024
'''
import numpy as np
def endpoint_detect(En, Zn):
    frame_num = len(En)
    noise_begin = len(En) - 19
    noise_end = len(En) - 1
    avg_noise_en = np.mean(En[noise_begin:noise_end])
    std_noise_en = np.std(En[noise_begin:noise_end])
    avg_noise_zn = np.mean(Zn[noise_begin:noise_end])
    std_noise_zn = np.std(Zn[noise_begin:noise_end])
    MH = np.mean(En) / 4
    ML = (avg_noise_en + MH) / 4
    Zs = avg_noise_zn + 3 * std_noise_zn
    M = 3
    i = 0
    flag = True
    while flag:
        while En[i] < MH:
            if i >= frame_num - 1:
                break
            i += 1
        flag = False
        begin_1 = i
        for j in range(i + 1, i + M + 1):
            if j >= frame_num - 1:
                break
            if En[j] < MH:
                i = j + 1
                flag = True
    i = frame_num - 1
    flag = True
    while flag:
        while En[i] < MH:
            if i <= 0:
                break
            i -= 1
        flag = False
        end_1 = i
        for j in range(i - 1, i - M - 1, -1):
            if j <= 0:
                break
            if En[j] < MH:
                i = j - 1
                flag = True
    i = begin_1 - 1
    while i > 0:
        if En[i] > ML:
            i -= 1
        else:
            break
    begin_2 = i
    i = end_1 + 1
    while i < frame_num:
        if En[i] > ML:
            i += 1
        else:
            break
    end_2 = i
    i = begin_2 - 1
    while i > 0 and Zn[i] > Zs:
        i -= 1
    begin_3 = i
    i = end_2 + 1
    while i < frame_num and Zn[i] > Zs:
        i += 1
    end_3 = i
    start = begin_3
    final = end_3
    return start, final
