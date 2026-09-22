if exist('OCTAVE_VERSION', 'builtin')
    pkg load control;
end

m = 1000;

b1 = 5;
A1 = -b1/m;

B = 1/m;
C = 1;
D = 0;

cruise_1 = ss(A1,B,C,D);

b2 = 50;
A2 = -b2/m;
cruise_2 = ss(A2,B,C,D);

b3 = 500;
A3 = -b3/m;
cruise_3 = ss(A3,B,C,D);

figure;
hold on;
step(cruise_1, cruise_2, cruise_3)
xlabel('time [s]');
ylabel('v(t) [m/s]');
title('Unit steps for various values of K');
legend('b=5', 'b=50', 'b=500', 'location', 'southeast');
hold off;
