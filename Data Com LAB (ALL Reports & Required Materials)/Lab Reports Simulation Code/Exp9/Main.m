clc;
clear all;
close all;

%% Part (a): Transmit message as analog signal using QPSK
Transmitted_Message = 'We Enjoy Data Comm';

% Convert Information Message to bits
x = asc2bn(Transmitted_Message); % Binary Information
bp = 1e-6; % bit period
disp('Binary information at Transmitter:');
disp(x);

% Representation of transmitting binary information as digital signal
bit = [];
for n = 1:length(x)
    if x(n) == 1
        se = ones(1,100);
    else
        se = zeros(1,100);
    end
    bit = [bit se];
end
t1 = bp/100:bp/100:100*length(x)*(bp/100);

figure;
subplot(4,1,1);
plot(t1,bit,'lineWidth',2.5); grid on;
axis([0 bp*length(x) -0.5 1.5]);
ylabel('Amplitude (volt)');
xlabel('Time (sec)');
title('Original Binary Data');

% QPSK Modulation
br = 1/bp; % bit rate
f = br*2; % carrier frequency (lower for QPSK)
t2 = bp/99:bp/99:bp;

% Split into I and Q channels
even_bits = x(1:2:end);
odd_bits = x(2:2:end);

% Ensure equal length by padding if necessary
if length(odd_bits) < length(even_bits)
    odd_bits = [odd_bits 0];
end

% Modulate I channel (even bits)
m_i = [];
for i = 1:length(even_bits)
    if even_bits(i) == 1
        y = cos(2*pi*f*t2);
    else
        y = -cos(2*pi*f*t2);
    end
    m_i = [m_i y];
end

% Modulate Q channel (odd bits)
m_q = [];
for i = 1:length(odd_bits)
    if odd_bits(i) == 1
        y = sin(2*pi*f*t2);
    else
        y = -sin(2*pi*f*t2);
    end
    m_q = [m_q y];
end

% Combine I and Q channels
m = m_i + m_q;
t3 = bp/99:bp/99:bp*length(even_bits);

subplot(4,1,2);
plot(t3,m);
axis([0 bp*length(even_bits) -2 2]);
xlabel('Time (sec)');
ylabel('Amplitude (volt)');
title('QPSK Modulated Signal at Transmitter');

%% Part (b): Show received signal with 50 dB SNR
disp('********************');
disp('Message transmitted through a Transmission medium');
disp('********************');

% Channel Noise with 50 dB SNR
t4 = bp/99:bp/99:bp*length(even_bits);
Rec = awgn(m,50,'measured');

subplot(4,1,3);
plot(t4,Rec);
axis([0 bp*length(even_bits) -2 2]);
xlabel('Time (sec)');
ylabel('Amplitude (volt)');
title('Received signal at Receiver (50 dB SNR)');

%% Part (c): Recover the text from the received signal
% QPSK Demodulation
ss = length(t2);
mn_i = []; % I channel bits
mn_q = []; % Q channel bits

for n = ss:ss:length(Rec)
    % I channel demodulation (cosine)
    t = bp/99:bp/99:bp;
    y_i = cos(2*pi*f*t);
    mm_i = y_i .* Rec((n-(ss-1)):n);
    z_i = trapz(t,mm_i);
    zz_i = round((2*z_i/bp));
    
    if zz_i > 0
        a_i = 1;
    else
        a_i = 0;
    end
    mn_i = [mn_i a_i];
    
    % Q channel demodulation (sine)
    y_q = sin(2*pi*f*t);
    mm_q = y_q .* Rec((n-(ss-1)):n);
    z_q = trapz(t,mm_q);
    zz_q = round((2*z_q/bp));
    
    if zz_q > 0
        a_q = 1;
    else
        a_q = 0;
    end
    mn_q = [mn_q a_q];
end

% Interleave I and Q bits
mn = zeros(1, 2*length(mn_i));
mn(1:2:end) = mn_i;
mn(2:2:end) = mn_q;

% Truncate to original length if needed
if length(mn) > length(x)
    mn = mn(1:length(x));
end

disp('Binary information at Receiver:');
disp(mn);

% Representation of binary information as digital signal after demodulation
bit_rx = [];
for n = 1:length(mn)
    if mn(n) == 1
        se = ones(1,100);
    else
        se = zeros(1,100);
    end
    bit_rx = [bit_rx se];
end
t5 = bp/100:bp/100:100*length(mn)*(bp/100);

subplot(4,1,4)
plot(t5,bit_rx,'LineWidth',2.5); grid on;
axis([0 bp*length(mn) -0.5 1.5]);
ylabel('Amplitude (volt)');
xlabel('Time (sec)');
title('Demodulated Binary Data');

% Convert bits to message
Received_Message = bin2asc(mn);
disp(['Original Message: ', Transmitted_Message]);
disp(['Received Message: ', Received_Message]);





