if exist('OCTAVE_VERSION', 'builtin')
    pkg load control;
end

num = [2.7 0.72];
den = [15 4.7 0.72];
sys = tf(num, den)

step(sys)
info = stepinfo(sys, 'SettlingTimeThreshold', 0.01)
pole(sys)
zero(sys)
