clc;
clear all;
close all;

% Define 12-bit bit stream
bit_stream = [0 1 0 1 0 1 1 0 0 1 1 1];  
no_bits = length(bit_stream); 
bit_rate = 5000; % 5 kbps
pulse_duration = 1 / bit_rate; % Duration of one bit
samples_per_pulse = 500; 
fs = samples_per_pulse / pulse_duration; % Sampling frequency
t = 0:1/fs:(no_bits * pulse_duration); % Time vector
no_samples = length(t); 

% Initialize AMI encoded signal
ami_sig = zeros(1, no_samples); 
max_voltage = 5;
min_voltage = -5;
current_polarity = max_voltage; % First '1' should be +5V

% Generate AMI Encoded Signal
for i = 1:no_bits
    start_idx = (i - 1) * samples_per_pulse + 1;
    end_idx = i * samples_per_pulse;
    
    if bit_stream(i) == 1
        ami_sig(start_idx:end_idx) = current_polarity; % Assign polarity
        current_polarity = -current_polarity; % Alternate polarity
    else
        ami_sig(start_idx:end_idx) = 0; % '0' is always 0V
    end
end

% Plot the waveform
plot(t, ami_sig, 'linewidth', 1.5); 
grid on;
xlabel('Time (seconds)');
ylabel('Voltage (V)');
ylim([min_voltage - 2, max_voltage + 2]); 
title('AMI (Alternate Mark Inversion) Encoded Digital Signal');
