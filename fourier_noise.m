% Define signal parameters
frequency = 5000; % Fundamental frequency
samplingRate = 100000; % Sampling frequency
period = 1/frequency; % Signal period
harmonics = 50; % Number of Fourier series terms

% Create time vector and generate the signal
timeVec = linspace(0, period, samplingRate*period); % Time vector
sawWave = sawtooth(2*pi*frequency*timeVec); % Sawtooth wave signal

% Calculate Fourier coefficients
a0 = mean(sawWave);
coeffA = zeros(1, harmonics);
coeffB = zeros(1, harmonics);
for harmonic = 1:harmonics
    coeffA(harmonic) = 2/period * trapz(timeVec, sawWave .* cos(2*pi*harmonic*frequency*timeVec));
    coeffB(harmonic) = 2/period * trapz(timeVec, sawWave .* sin(2*pi*harmonic*frequency*timeVec));
end

% Reconstruct the signal using the Fourier series
reconstructedSignal = a0/2;
for harmonic = 1:harmonics
    reconstructedSignal = reconstructedSignal + coeffA(harmonic)*cos(2*pi*harmonic*frequency*timeVec) + coeffB(harmonic)*sin(2*pi*harmonic*frequency*timeVec);
end

% Plot the original and reconstructed signals
figure;
plot(timeVec, sawWave, 'r', timeVec, reconstructedSignal, 'b');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Original Signal', 'Reconstructed Signal');
