clc; clear; close all;

% Given values
A = 2; B = 2; C = 4; D = 8; E = 4; F = 8; G = 3; H = 3;

% Compute amplitudes
A1 = A + B + H;  % 7
A2 = B + C + H;  % 9
s = (C + D + H) / 30; % 0.5

% Compute frequencies
f1 = (C + D + H) * 100;  % 1500 Hz
f2 = (D + E + H) * 100;  % 1500 Hz

% Bandwidth of the signal (highest frequency component)
B_signal = max(f1, f2);  % 1500 Hz

% Time vector
fs = 10 * B_signal;  % Sampling frequency
t = 0:1/fs:0.01; 

% Generate original signal (without noise)
signal_clean = A1 * sin(2 * pi * f1 * t) + A2 * cos(2 * pi * f2 * t);

% Generate noise
noise = s * randn(size(t));

% Generate noisy signal
x = signal_clean + noise;

% Calculate power of signal and noise
P_signal = mean(signal_clean.^2); 
P_noise = mean(noise.^2);          

% Compute SNR (in dB)
SNR_dB = 10 * log10(P_signal / P_noise);

% Convert SNR to linear scale
SNR_linear = 10^(SNR_dB / 10);  

% Compute maximum channel capacity using Shannon-Hartley theorem
C = B_signal * log2(1 + SNR_linear); 

% Compute required SNR in linear scale to achieve the target capacity
SNR_required_linear = 2^(C / B_signal) - 1;

% Compute required signal power level
P_signal_required = P_noise * SNR_required_linear;

% Display results
fprintf('Bandwidth of the Signal: %.2f Hz\n', B_signal);
fprintf('SNR Value: %.2f dB\n', SNR_dB);
fprintf('Maximum Channel Capacity: %.2f bps\n', C);
fprintf('Required Signal Power to Achieve %.2f bps: %.2f W\n', C, P_signal_required);
