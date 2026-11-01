if exist('OCTAVE_VERSION', 'builtin')
    pkg load control;
end

num_1 = [9 2.16];
den_1 = [15 11 2.16];

sys_1 = tf(num_1, den_1);

pole_1 = pole(sys_1)
zero_1 = zero(sys_1)

num_2 = [2.7 0.72];
den_2 = [15 4.7 0.72];

sys_2 = tf(num_2, den_2);

pole_2 = pole(sys_2)
zero_2 = zero(sys_2)

pzmap(sys_1, sys_2)
legend('Part G poles', 'Part G zeros', 'Part C poles', 'Part C zeros', 'location', 'south')
grid on
