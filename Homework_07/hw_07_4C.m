if exist('OCTAVE_VERSION', 'builtin')
    pkg load control;
end

K_2 = 2;
Overshoot_target = 17;

K_1 = 1;

num = [.5*K_1 1.5*K_1];
den = [1 22 120+0.5*K_1 1.5*K_1];

sys = tf(num, den);
sysinf = stepinfo(sys)
