k=0:30;   
N=200;      % N表示FFT返回序列的长度
x=0.8.^k;
subplot(3,1,1);
stem(k,x);    %画出序列的时域波形
X=fft(x,N); %X是长度为200的序列(表示把一个周期(0，2pi)上的频谱离散化为200个点的序列）
Y=fftshift(X); %频谱中心化，即返回（-pi,pi）的频谱
xlabel('k');
title('信号 x[k]=0.8^ku[k] 时域波形');

subplot(3,1,2);
w1=[-N/2:N/2-1]*(2*pi/N);      
plot(w1, abs(Y));
axis([-pi pi 0 6])
xlabel('角频率\omega（rad）');
title('中心化的幅度频谱|X(e^{jw})|');

subplot(3,1,3);
w1=[1:N]*(2*pi/N);      
plot(w1, abs(X));
axis([0 2*pi 0 6])
xlabel('角频率\omega（rad）');
title('未中心化的幅度频谱|X(e^{jw})|');