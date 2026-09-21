if exist('OCTAVE_VERSION', 'builtin')
    pkg load control;
end

m  = 1500;          % mass of the car
b  = 70;            % friction coefficient

K = 1000;
sys1000 = tf(K, [m, K+b]);

K = 5000;
sys5000 = tf(K, [m, K+b]);

K = 10000;
sys10000 = tf(K, [m, K+b]);

figure;
hold on;
step(sys1000, sys5000, sys10000)
xlabel('time [s]');
ylabel('v(t) [m/s]');
title('Unit steps for various values of K');
legend('K=1000', 'K=5000', 'K=10000', 'location', 'southeast');
ylim([0 1.1]);
hold off;
