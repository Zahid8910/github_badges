clc;
clear all;
close all;

%% Parameters from ID
F = 8;
G = 3;

am1 = F + 2;  fm1 = G + 1;  % am1 = 10, fm1 = 4
am2 = F + 5;  fm2 = G + 2;  % am2 = 13, fm2 = 5
am3 = F + 8;  fm3 = G + 3;  % am3 = 16, fm3 = 6
am4 = F + 11; fm4 = G + 4;  % am4 = 19, fm4 = 7

%% Sampling
fs = 4001;
t = 0:1/fs:1-1/fs;

%% Message Signal Generation
mt1 = am1 * cos(2*pi*fm1*t);
mt2 = am2 * cos(2*pi*fm2*t);
mt3 = am3 * cos(2*pi*fm3*t);
mt4 = am4 * cos(2*pi*fm4*t);

%% Carrier Signal Generation
fc1 = 50;   c1 = cos(2*pi*fc1*t);
fc2 = 100;  c2 = cos(2*pi*fc2*t);
fc3 = 150;  c3 = cos(2*pi*fc3*t);
fc4 = 200;  c4 = cos(2*pi*fc4*t);

%% Modulation (DSB-SC)
s1 = mt1 .* c1;
s2 = mt2 .* c2;
s3 = mt3 .* c3;
s4 = mt4 .* c4;

%% Composite Signal
x = s1 + s2 + s3 + s4;

%% Time Domain Plots of Message Signals
figure;
subplot(4,1,1); plot(t, mt1); title('Message Signal 1'); ylim([-am1 am1]);
subplot(4,1,2); plot(t, mt2); title('Message Signal 2'); ylim([-am2 am2]);
subplot(4,1,3); plot(t, mt3); title('Message Signal 3'); ylim([-am3 am3]);
subplot(4,1,4); plot(t, mt4); title('Message Signal 4'); ylim([-am4 am4]);

%% Frequency Domain of Message Signals
f = fs/2 * linspace(-1,1,fs);
M1 = abs(fftshift(fft(mt1)))/(fs/2);
M2 = abs(fftshift(fft(mt2)))/(fs/2);
M3 = abs(fftshift(fft(mt3)))/(fs/2);
M4 = abs(fftshift(fft(mt4)))/(fs/2);

figure;
subplot(4,1,1); stem(f, M1); title('Message Signal 1 Spectrum'); xlim([-10 10]);
subplot(4,1,2); stem(f, M2); title('Message Signal 2 Spectrum'); xlim([-10 10]);
subplot(4,1,3); stem(f, M3); title('Message Signal 3 Spectrum'); xlim([-10 10]);
subplot(4,1,4); stem(f, M4); title('Message Signal 4 Spectrum'); xlim([-10 10]);

%% Composite Signal Time & Frequency
X = abs(fftshift(fft(x)))/(fs/2);
figure;
subplot(2,1,1); plot(t, x); title('Composite Signal in Time Domain');
subplot(2,1,2); stem(f, X); title('Composite Signal Spectrum'); xlim([-250 250]);

%% Bandpass Filtering
[b1, a1] = butter(5, [(fc1-fm1-6)/(fs/2), (fc1+fm1+6)/(fs/2)]);
[b2, a2] = butter(5, [(fc2-fm2-6)/(fs/2), (fc2+fm2+6)/(fs/2)]);
[b3, a3] = butter(5, [(fc3-fm3-6)/(fs/2), (fc3+fm3+6)/(fs/2)]);
[b4, a4] = butter(5, [(fc4-fm4-6)/(fs/2), (fc4+fm4+6)/(fs/2)]);

bpf1 = filter(b1, a1, x);
bpf2 = filter(b2, a2, x);
bpf3 = filter(b3, a3, x);
bpf4 = filter(b4, a4, x);

%% Mixing with Carrier
z1 = 2 * bpf1 .* c1;
z2 = 2 * bpf2 .* c2;
z3 = 2 * bpf3 .* c3;
z4 = 2 * bpf4 .* c4;

%% Lowpass Filters
[lp1_b, lp1_a] = butter(5, (fm1+3)/(fs/2));
[lp2_b, lp2_a] = butter(5, (fm2+3)/(fs/2));
[lp3_b, lp3_a] = butter(5, (fm3+3)/(fs/2));
[lp4_b, lp4_a] = butter(5, (fm4+3)/(fs/2));

rec1 = filter(lp1_b, lp1_a, z1);
rec2 = filter(lp2_b, lp2_a, z2);
rec3 = filter(lp3_b, lp3_a, z3);
rec4 = filter(lp4_b, lp4_a, z4);

%% Time Domain Plots of Recovered Signals
figure;
subplot(4,1,1); plot(t, rec1); title('Recovered Signal 1'); ylim([-am1 am1]);
subplot(4,1,2); plot(t, rec2); title('Recovered Signal 2'); ylim([-am2 am2]);
subplot(4,1,3); plot(t, rec3); title('Recovered Signal 3'); ylim([-am3 am3]);
subplot(4,1,4); plot(t, rec4); title('Recovered Signal 4'); ylim([-am4 am4]);

%% Frequency Domain of Recovered Signals
R1 = abs(fftshift(fft(rec1)))/(fs/2);
R2 = abs(fftshift(fft(rec2)))/(fs/2);
R3 = abs(fftshift(fft(rec3)))/(fs/2);
R4 = abs(fftshift(fft(rec4)))/(fs/2);

figure;
subplot(4,1,1); stem(f, R1); title('Recovered Signal 1 Spectrum'); xlim([-10 10]);
subplot(4,1,2); stem(f, R2); title('Recovered Signal 2 Spectrum'); xlim([-10 10]);
subplot(4,1,3); stem(f, R3); title('Recovered Signal 3 Spectrum'); xlim([-10 10]);
subplot(4,1,4); stem(f, R4); title('Recovered Signal 4 Spectrum'); xlim([-10 10]);