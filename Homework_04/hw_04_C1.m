x = linspace(0, 90, 1000);
q = 20*(exp(x/15) - 1) ./ (exp(x/15) + 1);

figure;
plot(x, q);
grid on;
xlabel("Valve angle in degrees");
ylabel("Flow rate in [m^3/s]");
title("Flow rate vs valve angle")
