'''
 * @file getaudio.py
 * @author Jiaxu Xiao
 * @brief getaudio
 * @version 0.1
 * @date 2024-10-13
 * 
 * @copyright Copyright (c) 2024
'''
import sounddevice as sd
import numpy as np
import matplotlib.pyplot as plt
from scipy.io.wavfile import write
Fs = 44100
nChannels = 1
time = 3
print("Start speaking.")
myRecording = sd.rec(int(time * Fs), samplerate=Fs, channels=nChannels, dtype='float64')
sd.wait()
print("End of Recording.")
sd.play(myRecording, Fs)
sd.wait()
plt.plot(myRecording)
plt.title("Recorded Audio Waveform")
plt.xlabel("Sample Index")
plt.ylabel("Amplitude")
plt.show()
filename = './audioLib/test.wav'
write(filename, Fs, np.array(myRecording))
