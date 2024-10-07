% Loading the audio signal
audioFile = 'myspeech.wav';
[signal, origSampleRate] = audioread(audioFile);
signal = signal(:, 1); % Selecting the left channel

% New sampling rates
newFs1 = 1000;
newFs2 = 2000;
newFs3 = 4000;
newFs4 = 8000;

% Downsampling the signal
downSampled1 = resample(signal, newFs1, origSampleRate);
downSampled2 = resample(signal, newFs2, origSampleRate);
downSampled3 = resample(signal, newFs3, origSampleRate);
downSampled4 = resample(signal, newFs4, origSampleRate);

% Plotting the signals
timeVec1 = (0:length(downSampled1)-1)/newFs1;
timeVec2 = (0:length(downSampled2)-1)/newFs2;
timeVec3 = (0:length(downSampled3)-1)/newFs3;
timeVec4 = (0:length(downSampled4)-1)/newFs4;

figure;
subplot(5,1,1);
plot(timeVec1, downSampled1);
title(['Sampled at ' num2str(newFs1) ' Hz']);
ylabel('Amplitude');

subplot(5,1,2);
plot(timeVec2, downSampled2);
title(['Sampled at ' num2str(newFs2) ' Hz']);
ylabel('Amplitude');

subplot(5,1,3);
plot(timeVec3, downSampled3);
title(['Sampled at ' num2str(newFs3) ' Hz']);
ylabel('Amplitude');

subplot(5,1,4);
plot(timeVec4, downSampled4);
title(['Sampled at ' num2str(newFs4) ' Hz']);
ylabel('Amplitude');

subplot(5,1,5);
plot((0:length(signal)-1)/origSampleRate, signal);
title('Original Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Plotting the spectrograms
figure;
subplot(5,1,1);
spectrogram(downSampled1, [], [], [], newFs1, 'yaxis');
title(['Spectrogram at ' num2str(newFs1) ' Hz']);

subplot(5,1,2);
spectrogram(downSampled2, [], [], [], newFs2, 'yaxis');
title(['Spectrogram at ' num2str(newFs2) ' Hz']);

subplot(5,1,3);
spectrogram(downSampled3, [], [], [], newFs3, 'yaxis');
title(['Spectrogram at ' num2str(newFs3) ' Hz']);

subplot(5,1,4);
spectrogram(downSampled4, [], [], [], newFs4, 'yaxis');
title(['Spectrogram at ' num2str(newFs4) ' Hz']);

subplot(5,1,5);
spectrogram(signal, [], [], [], origSampleRate, 'yaxis');
title('Original Signal Spectrogram');

% Playing the sounds
sound(signal, origSampleRate);
pause(length(signal)/origSampleRate);
sound(downSampled1, newFs1);
pause(length(downSampled1)/newFs1);
sound(downSampled2, newFs2);
pause(length(downSampled2)/newFs2);
sound(downSampled3, newFs3);
pause(length(downSampled3)/newFs3);
sound(downSampled4, newFs4);
