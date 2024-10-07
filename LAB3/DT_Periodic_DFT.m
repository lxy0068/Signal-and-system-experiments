N=16;    % w0=pi/8
k=0:N-1;
x=cos(pi/8*k+pi/3)+0.5*cos(7*pi/8*k);
X=fft(x,N); 

subplot(3,1,1);
stem(k-N/2,abs(fftshift(X))/N); %画出傅里叶级数的系数a[k]=X[k]/N
axis([-8 8 0 0.6])
ylabel('Magnitude');   
xlabel('k');
title('x[k]=cos(k\pi/8+\pi/3)+0.5cos(7k\pi/8)的傅里叶级数系数')

subplot(3,1,2);
stem((k-N/2)*(2*pi/N),abs(fftshift(X)),'r-^');
axis([-pi pi 0 10])
xlabel('\omega');
title('x[k]的幅度频谱|X(e^{jw})|')


subplot(3,1,3);
stem((k-N/2)*(2*pi/N),angle(fftshift(X)),'m-*');
xlabel('\omega');
title('x[k]的相位频谱<X(e^{jw})')
axis([-pi pi -4 4])
