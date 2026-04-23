% Given values
A = 2; B = 2; C = 4; D = 8; E = 4; F = 8; G = 3; H = 3;

% Compute amplitudes
A1 = A + B + H;  % 7
A2 = B + C + H;  % 9
s = (C + D + H) / 30; % 0.5

% Compute frequencies
f1 = (C + D + H) * 100;  % 1500 Hz
f2 = (D + E + H) * 100;  % 1500 Hz

% Time vector
fs = 10 * f1;   
t = 0:1/fs:0.01;

% Generate signals
x = A1 * sin(2 * pi * f1 * t) + A2 * cos(2 * pi * f2 * t) + s * randn(size(t));

% Plot the signal
figure;
plot(t, x, 'b', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Composite Signal with Noise');
grid on;
xlim([0 0.01]); % Show only 10ms of signal
