if exist('OCTAVE_VERSION', 'builtin')
    pkg load control;
end

k_p = 300;

for k_d = [0.5 2 5 8 10]
    k_d

    num = [k_d k_p];
    den = [3 24+k_d 72+k_p];

    sys = tf(num, den);
    k_d_poles = pole(sys)
end
