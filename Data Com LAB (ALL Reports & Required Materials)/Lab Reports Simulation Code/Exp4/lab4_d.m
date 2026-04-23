
bit_rate = 10000;        
bit_duration = 1 / bit_rate; 
fs = 1000000;               
samples_per_bit = fs * bit_duration; % Samples per bit

% Input bit sequence
bit_str = '010101100111';
bit_sequence = (bit_str == '1'); % Convert to logical array

% MLT-3 encoding logic
current_level = 0;     % Start at 0 level
direction = 1;         % Initial direction

% Initialize signal
total_bits = length(bit_sequence);
total_samples = total_bits * samples_per_bit;
signal = zeros(1, total_samples);
time = linspace(0, total_bits * bit_duration, total_samples);

% Generate MLT-3 signal
for i = 1:total_bits
    bit = bit_sequence(i);
    if bit
        if current_level == 0
            new_level = direction * 1; % Transition to +1 or -1
            direction = -direction;     % Toggle direction
        else
            new_level = 0; % Transition back to 0
        end
    else
        new_level = current_level; % No change for '0'
    end
    
    start_idx = (i-1)*samples_per_bit + 1;
    end_idx = i * samples_per_bit;
    signal(start_idx:end_idx) = new_level;
    
    current_level = new_level; % Update level
end

% Plot the signal
figure;
plot(time, signal, 'LineWidth', 1.5);
ylim([-1.5 1.5]);
title('MLT-3 Encoded Signal');
xlabel('Time (s)');
ylabel('Voltage Level');
grid on;