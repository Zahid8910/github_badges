    % //Define given values
    E = 1;
    F = 8;
    G = 7;

    % //Compute amplitudes and frequencies
    a1 = F + 1;  % 9
    a2 = G + 2;  % 9
    a3 = E + 3;  % 4
    f1 = E + 1;  % 2 Hz
    f2 = G + 2;  % 9 Hz
    f3 = F + 3;  % 11 Hz

    % //Time vector
    fs = 100;       
    t = 0:1/fs:1;   

    % //Generate signals
    x1 = a1 * cos(2 * pi * f1 * t);
    x2 = a2 * sin(2 * pi * f2 * t);
    x3 = a3 * cos(2 * pi * f3 * t);

    % //Composite signal
    signal_x = x1 + x2 + x3;

    % //Compute FFT
    N = length(signal_x);
    Y = fft(signal_x);
    Y_mag = abs(Y/N);    % Normalize magnitude
    frequencies = (0:N-1) * (fs/N);  % Frequency axis


    half_N = floor(N/2);

    % //Plot time-domain representation
    figure;
    subplot(2,1,1);
    plot(t, signal_x, 'b', 'LineWidth', 1.5);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title('Time-Domain Representation of Composite Signal');
    grid on;
    xlim([0 1]); 

    % Plot frequency-domain representation
    subplot(2,1,2);
    stem(frequencies(1:half_N), Y_mag(1:half_N), 'r', 'LineWidth', 1.5);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    title('Frequency-Domain Representation (FFT)');
    grid on;
    xlim([0 20]); % Show relevant frequency range
