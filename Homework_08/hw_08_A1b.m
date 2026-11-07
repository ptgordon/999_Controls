if exist('OCTAVE_VERSION', 'builtin')
    pkg load control;
end

num = [10 200];
den = [3 24 82 200];
sys = tf(num, den);

pzmap(sys);

sys_poles = pole(sys)
sys_zeros = zero(sys)
