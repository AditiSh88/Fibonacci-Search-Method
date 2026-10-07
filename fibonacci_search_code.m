% Subject: Optimization Techniques
% Assignment: Fibonacci Search Method Optimization
% Objective Function: f(x) = 2*x^2 + 2*cos(x) over interval [-2, 2]
% Total Iterations: n = 10


clc;
clear;
close all;

% Objective function
f = @(x) 2*x.^2 + 2*cos(x);

% Initial parameters
a0 = -2;
b0 = 2;
a = a0;
b = b0;
n = 10;
L = b - a;

% Generating Fibonacci numbers
F = zeros(1, n+1);
F(1) = 1;
F(2) = 1;

for i = 3:n+1
    F(i) = F(i-1) + F(i-2);
end

% Array to store iteration history for analytical table output
history = zeros(n-2, 8);

% Initial interior points
x1 = a + (F(n-1)/F(n+1))*L;
x2 = a + (F(n)/F(n+1))*L;

f1 = f(x1);
f2 = f(x2);

% Fibonacci search loop
for k = 1:n-2

    if f1 > f2
        % Minimum lies in [x1, b]
        a = x1;

        history(k, :) = [k+1, F(n-k+1)/F(n+1), x1, x2, f1, f2, a, b];

        x1 = x2;
        f1 = f2;

        x2 = a + (F(n-k)/F(n-k+1))*(b-a);
        f2 = f(x2);

    else
        % Minimum lies in [a, x2]
        b = x2;

        history(k, :) = [k+1, F(n-k+1)/F(n+1), x1, x2, f1, f2, a, b];

        x2 = x1;
        f2 = f1;

        x1 = a + (F(n-k-1)/F(n-k+1))*(b-a);
        f1 = f(x1);

    end

end

% Fibonacci final estimation
x_fib = (a + b) / 2;
f_fib = f(x_fib);
fa = f(a);
fb = f(b);

% MATLAB actual minimum for verification
[x_actual, f_actual] = fminbnd(f, a0, b0);

% Printing Console Results
fprintf('=======================================================\n');
fprintf('          FIBONACCI SEARCH METHOD RESULTS             \n');
fprintf('=======================================================\n');
fprintf('1) Actual minimum x (fminbnd) : %.8f\n', x_actual);
fprintf('2) Actual minimum f(x)        : %.8f\n', f_actual);
fprintf('-------------------------------------------------------\n');
fprintf('3) Final lower bound (a)      : %.8f\n', a);
fprintf('4) Final upper bound (b)      : %.8f\n', b);
fprintf('5) Final interval [a, b]      : [%.8f, %.8f]\n', a, b);
fprintf('6) Estimated x* ((a+b)/2)     : %.8f\n', x_fib);
fprintf('7) Function value at f(a)     : %.8f\n', fa);
fprintf('8) Function value at f(b)     : %.8f\n', fb);
fprintf('9) Final Interval Length      : %.8f\n', (b - a));
fprintf('=======================================================\n');

% Plotting Function and Search Results
x_grid = linspace(a0, b0, 1000);
y_grid = f(x_grid);

figure('Name', 'Fibonacci Search Optimization', 'Color', 'w');
plot(x_grid, y_grid, 'LineWidth', 2.5, 'Color', [0 0.31 0.53]);
grid on; hold on;

xlabel('x', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('f(x)', 'FontSize', 12, 'FontWeight', 'bold');
title('Fibonacci Search Optimization: f(x) = 2x^2 + 2cos(x)', 'FontSize', 14);

% Plotting Points & Lines
plot(x_actual, f_actual, 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g', 'DisplayName', 'Actual Minimum');
plot(x_fib, f_fib, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r', 'DisplayName', 'Fibonacci Estimate');

xline(a, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Bound a');
xline(b, 'b--', 'LineWidth', 1.5, 'DisplayName', 'Bound b');

legend('Location', 'northeast');
hold off;
