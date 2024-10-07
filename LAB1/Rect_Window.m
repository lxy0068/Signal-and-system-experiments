%分析长度N=51点矩形窗的时域波形及频谱
N=51;
w=boxcar(N);
Y=fft(w,256);
subplot(2,1,1);
stem([0:N-1],w);
title('长度N=51点矩形窗的时域波形');
subplot(2,1,2);
Y0= abs(fftshift(Y));
plot([-128:127], Y0)
title('矩形窗的频谱');