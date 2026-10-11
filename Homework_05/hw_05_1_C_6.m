if exist('OCTAVE_VERSION', 'builtin')
    pkg load control;
end

b_1 = 3;
a_1 = 2;
k_p = 1.6;
k_i = 5;

num = [b_1*k_p, b_1*k_i];
den = [1, (a_1 + b_1*k_p), b_1 * k_i];

T_ry = tf(num, den);

T_ry_poles = pole(T_ry)
T_ry_zeros = zero(T_ry)

figure;
step(T_ry);
grid on;
title("Step response of T_{Ry3}(s)");

[yy, tt] = step(T_ry);

T_ry_overshoot = max(yy) - 1

