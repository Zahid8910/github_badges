clc;
clear;


% Define 12-bit bit stream
bit_stream = [0 1 0 1 0 1 1 0 0 1 1 1];  
no_bits = length(bit_stream); 
bit_rate = 4000; % 4 kbps
pulse_per_bit = 1; % 1 pulse per bit
pulse_duration = 1 / ((pulse_per_bit) * (bit_rate)); 
samples_per_pulse = 500; 
fs = samples_per_pulse / pulse_duration; % Sampling frequency
t = 0:1/fs:(no_bits * pulse_duration); % Time vector
no_samples = length(t); % Total samples

% Initialize digital signal
dig_sig = zeros(1, no_samples); 
max_voltage = 5;
min_voltage = -5;

% Generate Polar NRZ-L Signal
for i = 1:no_bits
    start_idx = (i - 1) * samples_per_pulse + 1;
    end_idx = i * samples_per_pulse;
    
    if bit_stream(i) == 1
        dig_sig(start_idx:end_idx) = max_voltage; % '1' ? +5V
    else
        dig_sig(start_idx:end_idx) = min_voltage; % '0' ? -5V
    end
end

% Plot the waveform
plot(t, dig_sig, 'linewidth', 1.5); 
grid on;
xlabel('Time (seconds)');
ylabel('Voltage (V)');
ylim([min_voltage - 2, max_voltage + 2]); 
title('Polar NRZ-L Digital Signal');
