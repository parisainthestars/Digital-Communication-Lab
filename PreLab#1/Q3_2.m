
% First plot for t from 0 to 2*pi
figure;
t1 = 0:pi/100:2*pi;
r1 = exp(cos(t1)) - 2*cos(4*t1) + (sin(t1/12)).^5;
x1 = sin(t1) .* r1;
y1 = cos(t1) .* r1;
plot(x1, y1);
title('Butterfly Curve (0 \leq t \leq 2\pi)');
xlabel('x(t)');
ylabel('y(t)');
axis equal;
grid on;

% Second plot for t from 0 to 10*pi
figure;
t2 = 0:pi/100:10*pi;
r2 = exp(cos(t2)) - 2*cos(4*t2) + (sin(t2/12)).^5;
x2 = sin(t2) .* r2;
y2 = cos(t2) .* r2;
plot(x2, y2);
title('Butterfly Curve (0 \leq t \leq 10\pi)');
xlabel('x(t)');
ylabel('y(t)');
axis equal;
grid on;