% Given parameters
SNR_required = 25;  % Minimum required SNR in dB
BW = 150;           % Channel bandwidth in Hz

% Calculate minimum sampling frequency (Nyquist theorem)
fs_min = 2 * BW; 

% Solve for number of bits using the SNR formula: SNR = 6.02*N + 1.76
N = ceil((SNR_required - 1.76) / 6.02); 

% Calculate the number of quantization levels
L = 2^N; 

% Display results
fprintf('Minimum Sampling Frequency: %.2f Hz\n', fs_min);
fprintf('Number of Bits per Sample: %d bits\n', N);
fprintf('Number of Quantization Levels: %d levels\n', L);
