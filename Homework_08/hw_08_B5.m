if exist('OCTAVE_VERSION', 'builtin')
    pkg load control;
end

% T_ry(s) = (2.7s + 300) / (3s^2 + 26.7s + 372)
num = [2.7 300];
den = [3 26.7 372];
sys = tf(num, den);

info = stepinfo(sys)

damp(sys)

step(sys);
grid on;
title('Step response of T_{ry}(s)');
