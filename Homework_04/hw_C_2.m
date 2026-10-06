X = [20, 60];

for x = X
    x_0 = x
    q_0 = 20*(exp(x/15)-1)/(exp(x/15)+1)
    num = 4*2*exp(x/15);
    den = 3*(exp(x/15)+1)^2;
    K_xq = num/den
    disp(newline());
end
