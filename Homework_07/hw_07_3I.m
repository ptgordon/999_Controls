if exist('OCTAVE_VERSION', 'builtin')
    pkg load control;
end

num_G = [9 2.16];
den_G = [15 11 2.16];

sys_G = tf(num_G, den_G);

num_C = [2.7 0.72];
den_C = [15 4.7 0.72];

sys_C = tf(num_C, den_C);

step_C = stepinfo(sys_C, 'SettlingTimeThreshold', 0.01)
damp_C = damp(sys_C)

step_G = stepinfo(sys_G, 'SettlingTimeThreshold', 0.01)
damp_G = damp(sys_G)
