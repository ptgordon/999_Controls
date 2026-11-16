ess_best = Inf;

for kp = 0.01:0.01:100
    num = [0.25*kp 8*kp];
    den = [2 14+0.25*kp 24+8*kp];

    sys = tf(num, den);
    step_info = stepinfo(sys);

    % Throw out any kp outside the rise time, settling time and overshoot bounds
    if step_info.RiseTime >= 0.5 || step_info.SettlingTime >= 2 || step_info.Overshoot >= 10
        continue
    end

    yss = dcgain(sys);
    ess = 1 - yss;

    % Keep the kp with the minimum steady-state error
    if ess < ess_best
        ess_best = ess;
        kp_best = kp;
    end
end

kp_best
ess_best

% Step response at the best kp
num = [0.25*kp_best 8*kp_best];
den = [2 14+0.25*kp_best 24+8*kp_best];

sys = tf(num, den);

step(sys)
step_info = stepinfo(sys)
