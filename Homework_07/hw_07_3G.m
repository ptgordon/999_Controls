if exist('OCTAVE_VERSION', 'builtin')
    pkg load control;
end

num_G = [9 2.16];
den_G = [15 11 2.16];

sys_G = tf(num_G, den_G);

pole_G = pole(sys_G)
zero_G = zero(sys_G)

num_C = [2.7 0.72];
den_C = [15 4.7 0.72];

sys_C = tf(num_C, den_C);

pole_C = pole(sys_C)
zero_C = zero(sys_C)

pzmap(sys_G, sys_C)
legend('Part G poles', 'Part G zeros', 'Part C poles', 'Part C zeros', 'location', 'south')
grid on
