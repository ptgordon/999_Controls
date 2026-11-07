if exist('OCTAVE_VERSION', 'builtin')
    pkg load control;
end

% T_ry(s) = (10s + 200) / (3s^3 + 24s^2 + 82s + 200)
num = [10 200];
den = [3 24 82 200];
sys = tf(num, den);

info = stepinfo(sys)

step(sys);
grid on;
title('Step response of T_{ry}(s)');
