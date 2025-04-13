'''
 * @file frame.py
 * @author Jiaxu Xiao
 * @brief draw frames' picture
 * @version 0.1
 * @date 2024-10-13
 * 
 * @copyright Copyright (c) 2024
'''
# 汉宁窗
import numpy as np
import matplotlib.pyplot as plt

N = 50  # 窗口长度
n = np.arange(N)
window = 0.5 * (1 - np.cos(2 * np.pi * n / (N - 1)))

plt.scatter(n, window)
plt.title('Hanning Window')
plt.xlabel('Sample points')
plt.ylabel('Amplitude')
plt.ylim(-0.1, 1.1)
plt.grid()
plt.show()

# 汉明窗
import numpy as np
import matplotlib.pyplot as plt

N = 50  # 窗口长度
n = np.arange(N)
window = 0.54 - 0.46 * np.cos(2 * np.pi * n / (N - 1))

plt.scatter(n, window)
plt.title('Hamming Window')
plt.xlabel('Sample points')
plt.ylabel('Amplitude')
plt.ylim(-0.1, 1.1)
plt.grid()
plt.show()

# 矩形窗
import numpy as np
import matplotlib.pyplot as plt

N = 50  # 窗口长度
n = np.arange(100)
window = np.zeros(100)
window[0:N] = 1 

plt.scatter(n,window)
plt.title('Rectangular Window')
plt.xlabel('Sample points')
plt.ylabel('Amplitude')
plt.ylim(-0.1, 1.1)
plt.grid()
plt.show()
