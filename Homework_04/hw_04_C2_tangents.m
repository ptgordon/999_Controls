q = @(x) 20*(exp(x/15) - 1) ./ (exp(x/15) + 1);   % flow [m^3/s]
dqdx = @(x) (8/3) * exp(x/15) ./ (exp(x/15) + 1).^2;   % slope [m^3/s/deg]

x = linspace(0, 90, 1000);
X0 = [20, 60];
span = 15;   % half-width of each tangent line [deg]

figure;
h = plot(x, q(x), 'k', 'LineWidth', 1.5);
hold on;
for x0 = X0
    q0 = q(x0);
    K  = dqdx(x0);
    xt = linspace(x0 - span, x0 + span, 2);
    h(end+1) = plot(xt, q0 + K*(xt - x0), '--', 'LineWidth', 1.5);
    plot(x0, q0, 'ko', 'MarkerFaceColor', 'k');
    text(x0 + 2, q0 - 1.5, sprintf('(%d, %.2f), K = %.4f', x0, q0, K));
end
hold off;
grid on;
xlim([0 90]);
xlabel('Valve angle x [deg]');
ylabel('Flow q [m^3/s]');
title('Linearization of valve flow at 20 and 60 degrees');
legend(h, 'q(x)', 'Tangent at 20 deg', 'Tangent at 60 deg', 'location', 'southeast');
