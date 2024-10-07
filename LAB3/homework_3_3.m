clear all
close all
T=0.4;          % ���������ź�x=cos(2*pi*f1*t)+0.75*cos(2*pi*f2*t)����0.4��
%T=2; %������źų��ȵ���Ϊ2s,�ܿ�������������(�ض��;��δ�����)��Ч��������
f1=100; f2=110; % �źŰ�������Ƶ�ʳɷ֣��ֱ�Ϊ100Hz��110Hz(���Ƶ��fm)             
           % ���źŻ���Ƶ��f0Ϊ10Hz,��������Ϊ0.1�루0.4��պ�Ϊ4�����ڳ��ȣ�
w0=20*pi;       % �ź�x(t)�Ļ�����Ƶ��Ϊ20pi 
T0=2*pi/w0;     % �����ź�x(t)������ T0=0.1
Ts=0.004;       % �������źŽ���ʱ��������������Ts��
                % ����Ƶ��fs=1/Ts=250Hz > 220Hz=2*fm (������������Ҫ��)
N0=T0/Ts;       % �ɲ�������Ts=0.004�������ɢ�����źŵ��������� N0=25
t=0:Ts:(T-Ts);  
N1=length(t);   % 0.4�볤�ȵ��źž�������Ts����ɢ��������г��� N1=100
x=cos(2*pi*f1*t)+0.75*cos(2*pi*f2*t);  % ��ɢ�������е����� N0=25 

figure
subplot(2,1,1)
plot(t,x)
xlabel('t');
title({['x(t)=cos(2\pi f_1t)+0.75 cos(2\pi f_2t),'];['����,f_1=100Hz��f_2=110Hz']});

N=N1;          % �趨FFT�������еĳ��� N=100���պ��ĸ����ڳ��ȣ�
Xm=fft(x,N)/N; % ���ؽ��Ϊ��ɢ�����źŸ���Ҷ������ϵ��a_k
w=((-N/2+1):N/2)*(2*pi/N)/Ts;% Ƶ����������Ļ���
              % �����Ӧ�����źŵ���ʵƵ��ʱ��ע��Ƶ����Ҫ����Ts����һ����
f=w./(2*pi);  % �����Ӧ��Ƶ�ʣ���HzΪ��λ��

subplot(2,1,2)
stem(f,abs(fftshift(Xm)));     %�������Ļ��ķ�����,Ƶ����Ϊf (Hz)
xlabel('Ƶ��f (Hz)');
ylabel('magnitude');   
title('x(t)�ĸ���Ҷ����ϵ��|{a_k}|'); 
axis([-150 150 0 0.6])

%***********************************************************************
w_rectangule=boxcar(N1);%���δ� 
y_rectangule=x.*w_rectangule'; %Ҫ��֤��˵�����size��ͬ������w��Ҫת�á�
Ym_rectangule=fft(y_rectangule,N)/N; % ���ؾ������δ����źŵ�Ƶ�ף�����Ҷϵ����

figure
subplot(3,1,1)
plot(t,w_rectangule);
xlabel('t');
title('Rectangule Window ���δ�');

subplot(3,1,2)
plot(t,y_rectangule)
xlabel('ʱ��t (��)');
title('y(t)_{Rectangule}');

subplot(3,1,3)
stem(f,abs(fftshift(Ym_rectangule)));     %�������Ļ���ķ�����
xlabel('f (Hz)');
ylabel('magnitude');   
title('y(t)_{Rectangule}�ķ����ף�ͬx(t)�ĸ���Ҷ����ϵ��|{a_k}|��'); 
axis([-150 150 0 0.6])

%***********************************************************************
k=0:N1-1;
w_rec=(k>=N1/4).*(k<=3*N1/4); %�ض��;��δ�
y_rec=x.*w_rec;
Ym_rec=fft(y_rec,N)/N;

figure
subplot(3,1,1)
plot(t,w_rec);
xlabel('t');
title('�ض��;��δ�');

subplot(3,1,2)
plot(t,y_rec)
xlabel('ʱ��t (��)');
title('y(t)_{Rec}');

subplot(3,1,3)
stem(f,abs(fftshift(Ym_rec)));     %�������Ļ���ķ�����
xlabel('f (Hz)');
ylabel('magnitude');   
title('y(t)_{Rec}�ķ����ף�'); 

%***********************************************************************
w_hamming=0.54-0.46*cos(2*pi*k/(N1-1)); %Hamming Window ������
y_hamming=x.*w_hamming; %ע�⣺�������ɵĹ���������ת�ã������С����1*100
figure
subplot(3,1,1)
plot(t,w_hamming);
xlabel('t');
title('Hamming Window ������');

subplot(3,1,2)
plot(t,y_hamming)
xlabel('t');
title('y(t)_{Hamming}');

Ym_hamming=fft(y_hamming,N)/N;
subplot(3,1,3)
stem(f,abs(fftshift(Ym_hamming)));     %����������
xlabel('f (Hz)');
ylabel('magnitude');   
title('y(t)_{Hamming}�ķ�����'); 

%***********************************************************************
beta=10;
w_kaiser=kaiser(N,beta); %Kaiser Window ����
y_kaiser=x.*w_kaiser'; %ע�⣺���������Ĺ���������ת�ã������С����1*100
figure
subplot(3,1,1)
plot(t,w_kaiser);
xlabel('t');
title('Kaiser Window ����');

subplot(3,1,2)
plot(t,y_kaiser)
xlabel('t');
title('y(t)_{Kaiser}');

Ym_kaiser=fft(y_kaiser,N)/N;
subplot(3,1,3)
stem(f,abs(fftshift(Ym_kaiser)));     %����������
xlabel('f (Hz)');
ylabel('magnitude');   
title('y(t)_{Kaiser}�ķ�����'); 