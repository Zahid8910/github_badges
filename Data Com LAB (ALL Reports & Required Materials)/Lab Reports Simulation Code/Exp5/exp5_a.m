% Define parameters
F = 7;
G = 5;

% Amplitude values
a1 = F + 1;  % 8
a2 = F + 3;  % 10
a3 = F + 2;  % 9
a4 = F + 4;  % 11

% Frequency values
f1 = G + 5;  % 10 Hz
f2 = G + 7;  % 12 Hz
f3 = G + 1;  % 6 Hz
f4 = G + 2;  % 7 Hz

% Time parameters
fs = 50;     % Sampling frequency (Hz)
T = 1;       % Signal duration (1 second)
t = linspace(0, T, 1000); % Continuous time for analog signal

% Define the analog signal
analog_signal = a1 * sin(2 * pi * f1 * t) + ...
                a2 * cos(2 * pi * f2 * t) + ...
                a3 * sin(2 * pi * f3 * t) + ...
                a4 * sin(2 * pi * f4 * t);

% Sampling
t_sampled = 0:1/fs:T;
sampled_signal = a1 * sin(2 * pi * f1 * t_sampled) + ...
                 a2 * cos(2 * pi * f2 * t_sampled) + ...
                 a3 * sin(2 * pi * f3 * t_sampled) + ...
                 a4 * sin(2 * pi * f4 * t_sampled);

% Quantization (8-bit, 256 levels)
quantization_levels = 256;
min_val = min(sampled_signal);
max_val = max(sampled_signal);
quantized_signal = round(((sampled_signal - min_val) / (max_val - min_val)) * (quantization_levels - 1));
quantized_signal = (quantized_signal / (quantization_levels - 1)) * (max_val - min_val) + min_val;

% Plot results
figure;

% Plot Analog Signal
subplot(3,1,1);
plot(t, analog_signal, 'b');
title('Analog Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Plot Sampled Signal
subplot(3,1,2);
plot(t, analog_signal, 'b', 'LineWidth', 0.5);
hold on;
stem(t_sampled, sampled_signal, 'r', 'filled');
title('Sampled Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
hold off;

% Plot Quantized Signal
subplot(3,1,3);
stairs(t_sampled, quantized_signal, 'g', 'LineWidth', 1.5);
title('Quantized Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
