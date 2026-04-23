    close all;
    clc;

    bit_stream = [0 0 1 1 0 0 0 1 0 0 1 1 1 0 0 1 0 0 1 1 0 1 0 0];

    %// Group bits manually into 3-bit groups
    symbols = zeros(1,8);
    k = 1;
    for j = 1:3:24
        b1 = bit_stream(j);
        b2 = bit_stream(j+1);
        b3 = bit_stream(j+2);
        symbols(k) = b1*4 + b2*2 + b3*1;
        k = k + 1;
    end

    %// Parameters
    fs = 1000;
    fc = 5;

    amplitudes = [0 1 2 3 4 5 6 7];
    frequencies = [1 2 3 4 5 6 7 8];
    phases = [0 pi/4 3*pi/4 pi/2 -pi/4 -pi/2 pi -3*pi/4];

    %// Define a colormap (use "jet" for colorful effect like in your figure)
    colors = jet(8);

    nx = 8;
    i = 1;

    while i <= nx
        t = i:0.001:i+1-0.001;
        symbol = symbols(i);
        
        A = amplitudes(symbol+1);
        ask = A*sin(2*pi*fc*t);
        
        f = frequencies(symbol+1);
        fsk = sin(2*pi*f*t);
        
        phi = phases(symbol+1);
        psk = sin(2*pi*fc*t + phi);
        
        %// Plotting with different color for each symbol
        subplot(3,1,1);
        plot(t,ask,'Color',colors(i,:),'LineWidth',1.5);
        hold on;
        grid on;
        axis([1 9 -8 8]);
        title('Amplitude Shift Key');

        subplot(3,1,2);
        plot(t,fsk,'Color',colors(i,:),'LineWidth',1.5);
        hold on;
        grid on;
        axis([1 9 -1.5 1.5]);
        title('Frequency Shift Key');

        subplot(3,1,3);
        plot(t,psk,'Color',colors(i,:),'LineWidth',1.5);
        hold on;
        grid on;
        axis([1 9 -1.5 1.5]);
        title('Phase Shift Key');

        i = i + 1;
    end
