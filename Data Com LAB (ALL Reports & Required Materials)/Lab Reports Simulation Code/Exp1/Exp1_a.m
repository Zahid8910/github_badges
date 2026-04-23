
    clc;
    clear;
    
    a1 = 10; 
    a2 = 6;  
    f1 = 2;  
    f2 = 6;  
    t = 0:0.01:1; 
    
    s1 = a1 * cos(2 * pi * f1 * t); 
    s2 = a2 * sin(2 * pi * f2 * t); 
    
    figure;
    
    plot(t, s1, 'c--o', 'LineWidth', 2, 'MarkerSize', 3); 
    hold on;
    plot(t, s2, 'm-.*', 'LineWidth', 2, 'MarkerSize', 3); 
    
    title('Comparison of Signals s1 and s2');
    xlabel('Time (seconds)');
    ylabel('Amplitude');
    
    axis([0 1 -15 15]); 
    grid on;


