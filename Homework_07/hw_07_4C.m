if exist('OCTAVE_VERSION', 'builtin')
    pkg load control;
end

K_2 = 2;
Overshoot_target = 17;

% K_1 values are checked from low to high, so stop at the first one over target
for K_1_try = 1000:2000
    num = [.5*K_1_try 1.5*K_1_try];
    den = [1 22 120+0.5*K_1_try 1.5*K_1_try];

    sys_try = tf(num, den);
    sysinf_try = stepinfo(sys_try);

    if sysinf_try.Overshoot > Overshoot_target
        break;
    end

    K_1 = K_1_try;
    sysinf = sysinf_try;
end

K_1
sysinf

ess = 5 * 10*(10 + K_2) / (1.5 * K_1)
