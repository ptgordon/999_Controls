if exist('OCTAVE_VERSION', 'builtin')
    pkg load control;
end

m = 1000;

b1 = 5;
b2 = 50;
b3 = 500;

s = tf('s');
cruise_1 = 1/(m*s+b1);
cruise_2 = 1/(m*s+b2);
cruise_3 = 1/(m*s+b3);

figure;
hold on;
step(cruise_1, cruise_2, cruise_3)
xlabel('time [s]');
ylabel('v(t) [m/s]');
title('Unit steps for various values of K');
legend('b=5', 'b=50', 'b=500', 'location', 'southeast');
hold off;
