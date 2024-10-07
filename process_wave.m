% Read voice file
[signal, sampleRate] = audioread('myspeech.wav');

% Perform spectrum analysis
numPoints = length(signal);
freqVector = (0:numPoints-1)*sampleRate/numPoints;
signalPower = abs(fft(signal)/numPoints).^2;

% Display the spectrum of the original signal
figure;
plot(freqVector, signalPower);
xlim([0, sampleRate/2]);
xlabel('Frequency (Hz)');
ylabel('power spectral density');
title('Spectrum of speech signal');

% Produce high frequency noise
additiveNoise = 0.03*randn(size(signal));

% Add noise to the speech signal
noisySignal = signal + additiveNoise;

% Play speech signals containing additive noise
sound(noisySignal, sampleRate);

% View and display sampling rate
disp(sampleRate);

% Draw signal waveforms containing noise
timeVector = (0:length(noisySignal)-1)/sampleRate;
figure;
plot(timeVector, noisySignal);
xlabel('time (s)');
ylabel('magnitude');
title('Sampled signal containing additive noise');

% Generate 5 seconds of multiplicative noise
time = 0:1/sampleRate:5-1/sampleRate;
sinFreq1 = 1000; 
sinFreq2 = 3000;
multiplicativeNoise = sin(2*pi*sinFreq1*time).*sin(2*pi*sinFreq2*time);

% Apply multiplicative noise to the speech signal
noisySignalMult = signal .* multiplicativeNoise';

% Play and display signals containing multiplicative noise
sound(noisySignalMult, sampleRate);
figure;
plot(timeVector, noisySignalMult);
xlabel('time (s)');
ylabel('magnitude');
title('Signal containing multiplicative noise');

% Implement signal translation
shiftAmount = 5*sampleRate;
shiftedSignal = [zeros(shiftAmount,1); signal(1:end-shiftAmount)];

% Play and display the translated signal
sound(shiftedSignal, sampleRate);
figure;
plot((0:length(shiftedSignal)-1)/sampleRate, shiftedSignal);
xlabel('time (s)');
ylabel('magnitude');
title('Signal after translation');

% Implement signal deconvolution
flippedSignal = flipud(signal);

% Play and display the reversed signal
sound(flippedSignal, sampleRate);
figure;
plot((0:length(flippedSignal)-1)/sampleRate, flippedSignal);
xlabel('time (s)');
ylabel('magnitude');
title('Signal after defolding');

% Perform spectrum analysis on signals containing multiplicative noise
numPointsMult = length(noisySignalMult);
freqVectorMult = (0:numPointsMult-1)*sampleRate/numPointsMult;
signalPowerMult = abs(fft(noisySignalMult)/numPointsMult).^2;

% show spectrum
figure;
plot(freqVectorMult, signalPowerMult);
xlim([0, sampleRate/2]);
xlabel('Frequency (Hz)');
ylabel('power spectral density');
title('Speech signal spectrum containing multiplicative noise');

% Design and apply filters
[b, a] = butter(6, [0.2, 0.4], 'bandpass');
filteredSignal1 = filter(b, a, noisySignalMult);

% Display the filtered signal
timeVectorFilt = (0:length(filteredSignal1)-1)/sampleRate;
figure;
subplot(2,1,1);
plot(timeVectorFilt, filteredSignal1);
title('Filtered signal (time domain)');
xlabel('time (s)');
ylabel('magnitude');

% Display the spectrum of the filtered signal
numPointsFilt1 = length(filteredSignal1);
freqVectorFilt1 = linspace(0, sampleRate/2, numPointsFilt1/2+1);
Y1 = fft(filteredSignal1);  % FFT
powerSpectrumFilt1 = abs(Y1(1:numPointsFilt1/2+1)).^2/numPointsFilt1;
subplot(2,1,2);
plot(freqVectorFilt1, powerSpectrumFilt1);
title('Filtered spectrum');
xlabel('Frequency (Hz)');
ylabel('power spectral density');

% Play the filtered signal
soundsc(filteredSignal1, sampleRate);

% Design another filter and apply
sampleRate2 = 8000;
freqVector2 = linspace(0, sampleRate2, length(noisySignalMult));
lowPassFilter = design(fdesign.lowpass('N,Fc', 6, 3000, sampleRate2));
filteredSignal2 = filter(lowPassFilter, noisySignalMult);

% Display another filtered signal
timeVectorFilt2 = (0:length(filteredSignal2)-1)/sampleRate2;
figure;
subplot(2,1,1);
plot(timeVectorFilt2, filteredSignal2);
title('Another filtered signal');
xlabel('time (s)');
ylabel('magnitude');

% Display the spectrum of another filtered signal
numPointsFilt2 = length(filteredSignal2);
freqVectorFilt2 = linspace(0, sampleRate2/2, numPointsFilt2/2+1);
Y2 = fft(filteredSignal2);  % FFT
powerSpectrumFilt2 = abs(Y2(1:numPointsFilt2/2+1)).^2/numPointsFilt2;
subplot(2,1,2);
plot(freqVectorFilt2, powerSpectrumFilt2);
title('Another filtered spectrum');
xlabel('Frequency (Hz)');
ylabel('power spectral density');

% Play another filtered signal
soundsc(filteredSignal2, sampleRate2);
