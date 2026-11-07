if exist('OCTAVE_VERSION', 'builtin')
    pkg load control;
end

k_p = 300;
rho_err = .1;

% k_d values are checked from low to high, so stop at the first one in range
for k_d = 2:0.1:3
    num = [k_d k_p];
    den = [3 24+k_d 72+k_p];

    sys = tf(num, den);
    [w_n, rho, p] = damp(sys);

    rho_test = abs(0.4-rho(1));

    if rho_test < rho_err
        rho_err = rho_test;
        k_d_best = k_d;
        rho_best = rho(1);
        p_best = p;
    end
end

k_d_best
rho_best
p_best
