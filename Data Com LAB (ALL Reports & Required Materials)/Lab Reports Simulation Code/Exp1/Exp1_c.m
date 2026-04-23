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
subplot(3, 1, 1);
plot(t, s1, 'c--o', 'LineWidth', 1, 'MarkerSize', 3); 

title('Comparison of Signals s1');
xlabel('Time (seconds)');
ylabel('Amplitude');

axis([0 1 -15 15]); 
grid on;
text(0.5, 12, 'This is a test plot of Experiment 1 of Mohsin Ibna Hossain, ID: 23-50194-1', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'FontSize', 8, 'FontWeight', 'bold', 'Color', 'black');

subplot(3, 1, 2);
plot(t, s2, 'm-.*', 'LineWidth', 1, 'MarkerSize', 3); 
title('Comparison of Signals s2 ');
xlabel('Time (seconds)');
ylabel('Amplitude');

axis([0 1 -15 15]); 
grid on;
text(0.5, 12, 'This is a test plot of Experiment 1 of Mohsin Ibna Hossain, ID: 23-50194-1', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'FontSize', 8, 'FontWeight', 'bold', 'Color', 'black');
