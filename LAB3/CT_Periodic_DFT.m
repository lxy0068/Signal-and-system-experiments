clc
clear all
w0=2*pi;
T0=1;% ���źŻ���Ƶ��Ϊ2pi,����T0=1
N0=300;  Ts=T0/N0;   % �����������ź�x(t)ȡһ�����ڳ���ΪN0����
N=N0;                % �õ���ɢ�����źŵĻ�������ΪN0, ����FFT�ĵ���N=N0
t=0:Ts:T0-Ts;        % �������Ts
x=cos(2*pi*5*t)+2*sin(2*pi*9*t);  

figure
subplot(3,1,1)
plot(t,x)
xlabel('ʱ�� t���룩');
title({['x(t)=cos(10\pit)+2sin(18\pit),']; ['����Ƶ��\omega_0=2\pi, ��������T0=1']});

Xm=fft(x,N);  % 
Ak=Xm/N;                       %�����źŵĸ���Ҷ����ϵ��
k=[-N/2:N/2-1]*(2*pi/N)/Ts/w0; % NΪż��
w=k*w0;                        % wΪ��Ӧ�Ľ�Ƶ��

subplot(3,1,2)
stem(k,abs(fftshift(Ak)));     %����������
axis([-15 15 0 1])
title('���������ź�x(t)�ĸ���Ҷ����ϵ��a_k  (\omega_0=2\pi)');
xlabel('k');


subplot(3,1,3)
stem(w,abs(fftshift(Xm)),'r-^'); %���������źŵĸ���Ҷ�任����ֵ�ϴ󣬽��Ƴ弤��
xlabel('��Ƶ��\omega (rad);')
title('�����źŸ���Ҷ�任�ķ����ף���ֵ�ϴ󣬽��Ƴ弤��'); 
axis([-30*pi 30*pi 0 400])
