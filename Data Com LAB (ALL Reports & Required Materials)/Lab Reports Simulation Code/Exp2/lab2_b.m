% Define given values
E = 1;
F = 8;
G = 7;

% Compute amplitudes and frequencies
a1 = F + 1;  % 9
a2 = G + 2;  % 9
a3 = E + 3;  % 4
f1 = E + 1;  % 2 Hz
f2 = G + 2;  % 9 Hz
f3 = F + 3;  % 11 Hz

% Time vector
fs = 100;       
t = 0:1/fs:1;  

% Generate signals
x1 = a1 * cos(2 * pi * f1 * t);
x2 = a2 * sin(2 * pi * f2 * t);
x3 = a3 * cos(2 * pi * f3 * t);

% Composite signal
signal_x = x1 + x2 + x3;

% Quantization Process
num_levels = 4;  % 4 quantization levels
min_val = min(signal_x);  
max_val = max(signal_x);  

% Define quantization levels
partition = linspace(min_val, max_val, num_levels-1); 
codebook = linspace(min_val, max_val, num_levels);

% Quantize the signal
[index, quantized_signal] = quantiz(signal_x, partition, codebook);

% Extract one cycle of the original and quantized signal
T = 1 / f1;  
idx = t <= T; 

% Plot the original and quantized signal for one cycle
figure;
plot(t(idx), signal_x(idx), 'b', 'LineWidth', 1.5); hold on;
stairs(t(idx), quantized_signal(idx), 'r', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Original and Quantized Signal (One Cycle)');
legend('Original Signal', 'Quantized Signal');
grid on;
xlim([0 T]); % Display only one cycle
ylim([min_val-1, max_val+1]); % Adjust Y-axis limits
