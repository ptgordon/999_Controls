if exist('OCTAVE_VERSION', 'builtin')
    pkg load control;
end

num = [3 2];
den = [1 2 10];

Zeros = roots(num)
Poles = roots(den)

F = tf(num, den);

figure;
pzmap(F);
legend off;
axis([-5 5 -5 5]);
axis square;
grid on;
title('Pole-zero map of F(s) = (3s+2)/(s^2+2s+10)');
