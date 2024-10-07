clc
clear all
fsam=50;  % 连续信号离散化的采样率为50Hz, 即1秒长的信号采样成50个点的序列
Ts=1/fsam; % Ts为采样周期
Tp=6;     % Tp为待分析信号的总时长
N=512;    % N为FFT返回序列的长度
t=0:Ts:Tp-Ts; 
x=exp(-1*t); % 离散信号序列长度为300 
             % 下面的傅里叶变换取512点，相当于给信号序列后面补212个零点
X=Ts*fft(x,N); %由离散信号的频谱计算对应连续信号频谱的时候，幅值要乘以Ts
X_mag=abs(fftshift(X)); %中心化之后的幅度频谱
w=(-N/2:N/2-1)*(2*pi/N)/Ts; % 频率轴完成中心化，
              % 计算对应连续信号的真实频率时，注意频率轴要除以Ts（归一化）
f=w./(2*pi);  % 计算对应的频率（以Hz为单位）
Y=1./(j*w+1); %信号x(t)=e^{-t}u(t)的频谱的理论值

subplot(3,1,1)
plot(t,x);
xlabel('时间 t(秒)');
title('连续信号x(t)=e^{-t}u(t)的时域波形');

subplot(3,1,2)
plot(w,X_mag,w,abs(Y),'r-.');
title('幅度频谱');
xlabel('角频率\omega rad/s(弧度/秒) ');
legend('计算值','理论值');  
axis([-63,63,0,1.4])

subplot(3,1,3)
plot(f,X_mag)             % 10Hz处信号的频谱已经几乎衰减到0，
title('幅度频谱');         % 所以信号x(t)时域采样频率取大于20Hz即可
xlabel('频率f  Hz(周/秒) '); 
axis([-10,10,0,1.4])
