clc
clear all
w0=2*pi;
T0=1;% 此信号基本频率为2pi,周期T0=1
N0=300;  Ts=T0/N0;   % 把连续周期信号x(t)取一个周期抽样为N0个点
N=N0;                % 得到离散周期信号的基本周期为N0, 所以FFT的点数N=N0
t=0:Ts:T0-Ts;        % 抽样间隔Ts
x=cos(2*pi*5*t)+2*sin(2*pi*9*t);  

figure
subplot(3,1,1)
plot(t,x)
xlabel('时间 t（秒）');
title({['x(t)=cos(10\pit)+2sin(18\pit),']; ['基本频率\omega_0=2\pi, 基本周期T0=1']});

Xm=fft(x,N);  % 
Ak=Xm/N;                       %周期信号的傅里叶级数系数
k=[-N/2:N/2-1]*(2*pi/N)/Ts/w0; % N为偶数
w=k*w0;                        % w为对应的角频率

subplot(3,1,2)
stem(k,abs(fftshift(Ak)));     %画出幅度谱
axis([-15 15 0 1])
title('连续周期信号x(t)的傅里叶级数系数a_k  (\omega_0=2\pi)');
xlabel('k');


subplot(3,1,3)
stem(w,abs(fftshift(Xm)),'r-^'); %画出周期信号的傅里叶变换（数值较大，近似冲激）
xlabel('角频率\omega (rad);')
title('周期信号傅里叶变换的幅度谱（数值较大，近似冲激）'); 
axis([-30*pi 30*pi 0 400])
