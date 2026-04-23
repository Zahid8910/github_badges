clc;
clear all;
close all;

% Define 12-bit bit stream
bit_stream = [0 1 0 1 0 1 1 0 0 1 1 1];  
no_bits = length(bit_stream); 
bit_rate = 2000; % 2 kbps
pulse_duration = 1 / bit_rate; % Duration of one bit
samples_per_pulse = 500; 
fs = samples_per_pulse / pulse_duration; % Sampling frequency
t = 0:1/fs:(no_bits * pulse_duration); % Time vector
no_samples = length(t); 

% Initialize Manchester encoded signal
manchester_sig = zeros(1, no_samples); 
max_voltage = 5;
min_voltage = -5;

% Generate Manchester Encoded Signal
for i = 1:no_bits
    start_idx = (i - 1) * samples_per_pulse + 1;
    mid_idx = start_idx + samples_per_pulse / 2;
    end_idx = i * samples_per_pulse;
    
    if bit_stream(i) == 0
        % '0' ? High to Low transition (5V ? -5V)
        manchester_sig(start_idx:mid_idx) = max_voltage;
        manchester_sig(mid_idx+1:end_idx) = min_voltage;
    else
        % '1' ? Low to High transition (-5V ? 5V)
        manchester_sig(start_idx:mid_idx) = min_voltage;
        manchester_sig(mid_idx+1:end_idx) = max_voltage;
    end
end

% Plot the waveform
plot(t, manchester_sig, 'linewidth', 1.5); 
grid on;
xlabel('Time (seconds)');
ylabel('Voltage (V)');
ylim([min_voltage - 2, max_voltage + 2]); 
title('Manchester Encoded Digital Signal');
