clear all 
close all
T0=1;
N=300; %该信号最高频率为240*pi，所以采样率要大于480*pi，也就是Ts<1/240
Ts=T0/N;
t=0:Ts:T0;
x=sin(100*pi*t)+sin(240*pi*t); 
y=randn(length(x),1);
x=x+y';
Xm=fft(x,N);
%w=(-N/2:(N/2-1))*(2*pi/N)/Ts;
f=(-N/2:(N/2-1))/N/Ts; %换算成Hz单位的频率 f=w/2pi

figure
subplot(2,1,1)
plot(t,x)
xlabel('t');
title('x(t)');

subplot(2,1,2)
plot(f,abs(fftshift(Xm)));
xlabel('f(Hz)');
title('Magnitude')
