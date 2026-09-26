if exist('OCTAVE_VERSION', 'builtin')
    pkg load control;
end

% Note these values were chosen to accentuate the differences
Kp = 1000;
Ki = 1000;
Kd = 1000;

%=========================================%

m = 1000;
b = 50;
r = 1;

s = tf('s');
P_cruise = 1/(m*s + b);
t = 0:0.1:20;

%=========================================%

C = pid(Kp);
T_P = feedback(C*P_cruise, 1);

%=========================================%

C = pid(Kp,Ki);

T_PI = feedback(C*P_cruise, 1);

%=========================================%

C = pid(Kp, Ki, Kd);

T_PID = feedback(C*P_cruise, 1);

%=========================================%

figure
step(r*T_P, 'b', r*T_PI, 'r', r*T_PID, 'g', t)
axis([0 20 0 1.5*r])
legend('P', 'PI', 'PID', 'Location', 'southeast')
