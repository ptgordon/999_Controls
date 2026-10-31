den = [15 4.7 0.72];
p = roots(den);

alpha = -real(p(1))
omega = abs(imag(p(1)))

omega_n = sqrt(alpha^2 + omega^2)
rho = alpha/omega_n

t_r = 1.8/omega_n

M_p = 100*exp(-pi*alpha/omega)

t_s = 4.6/alpha
