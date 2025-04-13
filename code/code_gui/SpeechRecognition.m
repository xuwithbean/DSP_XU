function varargout = SpeechRecognition(varargin)
% SPEECHRECOGNITION MATLAB code for SpeechRecognition.fig
%      SPEECHRECOGNITION, by itself, creates a new SPEECHRECOGNITION or raises the existing
%      singleton*.
%
%      H = SPEECHRECOGNITION returns the handle to a new SPEECHRECOGNITION or the handle to
%      the existing singleton*.
%
%      SPEECHRECOGNITION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPEECHRECOGNITION.M with the given input arguments.
%
%      SPEECHRECOGNITION('Property','Value',...) creates a new SPEECHRECOGNITION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SpeechRecognition_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SpeechRecognition_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SpeechRecognition

% Last Modified by GUIDE v2.5 01-Dec-2022 00:14:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SpeechRecognition_OpeningFcn, ...
                   'gui_OutputFcn',  @SpeechRecognition_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before SpeechRecognition is made visible.
function SpeechRecognition_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SpeechRecognition (see VARARGIN)

% Choose default command line output for SpeechRecognition
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SpeechRecognition wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SpeechRecognition_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_record.
function pushbutton_record_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_record (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fs = 44100;
nBits = 16;
nChannels = 1;
ID = -1;        % default audio input device
time = 3;

recObj = audiorecorder(Fs, nBits, nChannels, ID);
% 录制声音
set(handles.edit1, 'string', 'Start speaking.')
recordblocking(recObj, time);
% 回放录音数据
play(recObj);
% 获取录音数据
myRecording = getaudiodata(recObj);
set(handles.edit1, 'string', 'End of Recording.');
% 绘制录音数据波形
time = (0:length(myRecording) - 1) / Fs;
axes(handles.axes1);
plot(time, myRecording, 'b')
title('输入语音信号');
title('语音信号'); xlabel('时间/s'); ylabel('幅值');
grid on;
% 存储语音信号
filename = '.\speech\speechData.wav';
audiowrite(filename, myRecording, Fs);
handles.filename = filename;

% 存储参数
frameLen = 1024;
inc = frameLen / 2;
M = 26;
L = 12;             % MFCC 阶数
wordNum = 10;       % 识别词汇数, 0~9 共 10 个
handles.frameLen = frameLen;
handles.inc = inc;
handles.M = M;
handles.L = L;
handles.wordNum = wordNum;

% Update handles structure
guidata(hObject, handles);


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_time_analysis.
function pushbutton_time_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_time_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
frameLen = handles.frameLen;
inc = handles.inc;
filename = handles.filename;

[data, Fs] = audioread(filename);
data = data / max(abs(data));
[~, ~, ~, ~, startTime, finalTime] = validAudio(data, frameLen, Fs, 'hamming', inc);
time = (0:length(data) - 1) / Fs;
axes(handles.axes2);
plot(time, data, 'k');
title('双门限法的端点检测'); xlabel('时间/s'); ylabel('幅值');
axis([0, max(time), -1, 1]);
line([startTime, startTime], [-1.5, 1.5], 'color', 'r', 'LineStyle', '-');
line([finalTime, finalTime], [-1.5, 1.5], 'color', 'b', 'LineStyle', '-');


% --- Executes on button press in pushbutton_freq_analysis.
function pushbutton_freq_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_freq_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
frameLen = handles.frameLen;
inc = handles.inc;
M = handles.M;
L = handles.L;
filename = handles.filename;

[data, Fs] = audioread(filename);
data = data / max(abs(data));
[validData, ~, ~, ~, ~, ~] = validAudio(data, frameLen, Fs, 'hamming', inc);
mfcc = countMFCC(validData, frameLen, Fs, 'hamming', inc, M, L);
frameTime = (((1:size(mfcc, 1)) - 1) * inc + frameLen / 2) / Fs;
axes(handles.axes3);
plot(frameTime, mfcc)
title('MFCC系数'); xlabel('时间/s'); ylabel('幅值');


% --- Executes on button press in pushbutton_match.
function pushbutton_match_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_match (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
frameLen = handles.frameLen;
inc = handles.inc;
M = handles.M;
L = handles.L;                % MFCC 阶数
wordNum = handles.wordNum;    % 识别词汇数, 0~9 共 10 个
filename = handles.filename;

[data, Fs] = audioread(filename);
data = data / max(abs(data));
[validData, avgEn, avgMn, avgZn, ~, ~] = validAudio(data, frameLen, Fs, 'hamming', inc);

type = get(handles.popupmenu1, 'value');
switch type
    case 2
        load('.\trainedWeightedKNN.mat', 'trainedWeightedKNN')
        load('.\VarList.mat', 'avgEnList')
        load('.\VarList.mat', 'avgMnList')
        load('.\VarList.mat', 'avgZnList')
        tmp_min = min(avgEnList);
        tmp_max = max(avgEnList);
        avgEn_1 = (avgEn - tmp_min) / (tmp_max - tmp_min);
        tmp_min = min(avgMnList);
        tmp_max = max(avgMnList);
        avgMn_1 = (avgMn - tmp_min) / (tmp_max - tmp_min);
        tmp_min = min(avgZnList);
        tmp_max = max(avgZnList);
        avgZn_1 = (avgZn - tmp_min) / (tmp_max - tmp_min);
        data = table;
        data.avgEn = avgEn_1;
        data.avgMn = avgMn_1;
        data.avgZn = avgZn_1;
        label = trainedWeightedKNN.predictFcn(data);
        label = string(label);
        label = double(label);
        % 输出结果
        if mean(abs(validData)) < 0.01
            str = '无语音信号输入';
            set(handles.edit1, 'string', str);
        else
            str = ['时域特征识别: 您说的是 "' num2str(label) '".'];
            set(handles.edit1, 'string', str);
        end
    case 3
        [label, freq] = matchDTW(validData, Fs, frameLen, inc, M, L, wordNum);
        % 输出结果
        if mean(abs(validData)) < 0.01
            str = '无语音信号输入';
            set(handles.edit1, 'string', str);
        elseif (freq <= 2)       % 频率太低不确定
            str = '频域特征识别: 无法准确识别您的语音, 请重试';
            set(handles.edit1, 'string', str);
        else
            str = ['频域特征识别: 您说的是 "' num2str(label - 1) '".'];
            set(handles.edit1, 'string', str);
        end
end


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_reset.
function pushbutton_reset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
cla reset
axes(handles.axes2);
cla reset
axes(handles.axes3);
cla reset

handles.filename = '欢迎使用！';
handles.frameLen = 0;
handles.inc = 0;
handles.M = 0;
handles.L = 0;
handles.wordNum = 0;
set(handles.edit1, 'string', handles.filename);

% Update handles structure
guidata(hObject, handles);
