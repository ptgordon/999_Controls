% Poles and zeros of T_ry(s) = (2.7s + 0.72) / (15s^2 + 4.7s + 0.72)
num = [2.7 0.72];
den = [15 4.7 0.72];

zeros_Try = roots(num)
poles_Try = roots(den)
