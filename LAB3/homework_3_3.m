clear all
close all
T=0.4;          % 连续周期信号x=cos(2*pi*f1*t)+0.75*cos(2*pi*f2*t)长度0.4秒
%T=2; %如果把信号长度调整为2s,能看到几个窗函数(截断型矩形窗除外)的效果都不错
f1=100; f2=110; % 信号包含两个频率成分，分别为100Hz和110Hz(最大频率fm)             
           % 该信号基本频率f0为10Hz,基本周期为0.1秒（0.4秒刚好为4个周期长度）
w0=20*pi;       % 信号x(t)的基本角频率为20pi 
T0=2*pi/w0;     % 连续信号x(t)的周期 T0=0.1
Ts=0.004;       % 对连续信号进行时域抽样，抽样间隔Ts秒
                % 抽样频率fs=1/Ts=250Hz > 220Hz=2*fm (满足采样定理的要求)
N0=T0/Ts;       % 由采样周期Ts=0.004计算出离散化后信号的整数周期 N0=25
t=0:Ts:(T-Ts);  
N1=length(t);   % 0.4秒长度的信号经采样（Ts）离散化后的序列长度 N1=100
x=cos(2*pi*f1*t)+0.75*cos(2*pi*f2*t);  % 离散周期序列的周期 N0=25 

figure
subplot(2,1,1)
plot(t,x)
xlabel('t');
title({['x(t)=cos(2\pi f_1t)+0.75 cos(2\pi f_2t),'];['其中,f_1=100Hz，f_2=110Hz']});

N=N1;          % 设定FFT返回序列的长度 N=100（刚好四个周期长度）
Xm=fft(x,N)/N; % 返回结果为离散周期信号傅里叶级数的系数a_k
w=((-N/2+1):N/2)*(2*pi/N)/Ts;% 频率轴完成中心化，
              % 计算对应连续信号的真实频率时，注意频率轴要除以Ts（归一化）
f=w./(2*pi);  % 计算对应的频率（以Hz为单位）

subplot(2,1,2)
stem(f,abs(fftshift(Xm)));     %画出中心化的幅度谱,频率轴为f (Hz)
xlabel('频率f (Hz)');
ylabel('magnitude');   
title('x(t)的傅里叶级数系数|{a_k}|'); 
axis([-150 150 0 0.6])

%***********************************************************************
w_rectangule=boxcar(N1);%矩形窗 
y_rectangule=x.*w_rectangule'; %要保证点乘的两个size相同，所以w需要转置。
Ym_rectangule=fft(y_rectangule,N)/N; % 返回经过矩形窗后信号的频谱（傅里叶系数）

figure
subplot(3,1,1)
plot(t,w_rectangule);
xlabel('t');
title('Rectangule Window 矩形窗');

subplot(3,1,2)
plot(t,y_rectangule)
xlabel('时间t (秒)');
title('y(t)_{Rectangule}');

subplot(3,1,3)
stem(f,abs(fftshift(Ym_rectangule)));     %画出中心化后的幅度谱
xlabel('f (Hz)');
ylabel('magnitude');   
title('y(t)_{Rectangule}的幅度谱（同x(t)的傅里叶级数系数|{a_k}|）'); 
axis([-150 150 0 0.6])

%***********************************************************************
k=0:N1-1;
w_rec=(k>=N1/4).*(k<=3*N1/4); %截断型矩形窗
y_rec=x.*w_rec;
Ym_rec=fft(y_rec,N)/N;

figure
subplot(3,1,1)
plot(t,w_rec);
xlabel('t');
title('截断型矩形窗');

subplot(3,1,2)
plot(t,y_rec)
xlabel('时间t (秒)');
title('y(t)_{Rec}');

subplot(3,1,3)
stem(f,abs(fftshift(Ym_rec)));     %画出中心化后的幅度谱
xlabel('f (Hz)');
ylabel('magnitude');   
title('y(t)_{Rec}的幅度谱）'); 

%***********************************************************************
w_hamming=0.54-0.46*cos(2*pi*k/(N1-1)); %Hamming Window 哈明窗
y_hamming=x.*w_hamming; %注意：这里生成的哈明窗不用转置，本身大小就是1*100
figure
subplot(3,1,1)
plot(t,w_hamming);
xlabel('t');
title('Hamming Window 哈明窗');

subplot(3,1,2)
plot(t,y_hamming)
xlabel('t');
title('y(t)_{Hamming}');

Ym_hamming=fft(y_hamming,N)/N;
subplot(3,1,3)
stem(f,abs(fftshift(Ym_hamming)));     %画出幅度谱
xlabel('f (Hz)');
ylabel('magnitude');   
title('y(t)_{Hamming}的幅度谱'); 

%***********************************************************************
beta=10;
w_kaiser=kaiser(N,beta); %Kaiser Window 凯泽窗
y_kaiser=x.*w_kaiser'; %注意：这里生产的哈明窗不用转置，本身大小就是1*100
figure
subplot(3,1,1)
plot(t,w_kaiser);
xlabel('t');
title('Kaiser Window 凯泽窗');

subplot(3,1,2)
plot(t,y_kaiser)
xlabel('t');
title('y(t)_{Kaiser}');

Ym_kaiser=fft(y_kaiser,N)/N;
subplot(3,1,3)
stem(f,abs(fftshift(Ym_kaiser)));     %画出幅度谱
xlabel('f (Hz)');
ylabel('magnitude');   
title('y(t)_{Kaiser}的幅度谱'); 