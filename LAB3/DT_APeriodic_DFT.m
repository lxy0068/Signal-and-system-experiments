k=0:30;   
N=200;      % N��ʾFFT�������еĳ���
x=0.8.^k;
subplot(3,1,1);
stem(k,x);    %�������е�ʱ����
X=fft(x,N); %X�ǳ���Ϊ200������(��ʾ��һ������(0��2pi)�ϵ�Ƶ����ɢ��Ϊ200��������У�
Y=fftshift(X); %Ƶ�����Ļ��������أ�-pi,pi����Ƶ��
xlabel('k');
title('�ź� x[k]=0.8^ku[k] ʱ����');

subplot(3,1,2);
w1=[-N/2:N/2-1]*(2*pi/N);      
plot(w1, abs(Y));
axis([-pi pi 0 6])
xlabel('��Ƶ��\omega��rad��');
title('���Ļ��ķ���Ƶ��|X(e^{jw})|');

subplot(3,1,3);
w1=[1:N]*(2*pi/N);      
plot(w1, abs(X));
axis([0 2*pi 0 6])
xlabel('��Ƶ��\omega��rad��');
title('δ���Ļ��ķ���Ƶ��|X(e^{jw})|');