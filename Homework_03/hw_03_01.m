if exist('OCTAVE_VERSION', 'builtin')
    pkg load control;
end

Kp = 1;
Ki = 1;
Kd = 1;

s = tf('s');
C = Kp + Ki/s + Kd*s;

C = pid(Kp, Ki, Kd);

%=========================================%

m = 1000;
b = 50;
r = 10;

s = tf('s');
P_cruise = 1/(m*s + b);
t = 0:0.1:20;

%=========================================%

Kp = 1000;
C = pid(Kp);
T = feedback(C*P_cruise, 1);

figure
step(r*T,t)
axis([0 20  0 10])

%=========================================%

Kp = 1000;
Ki = 100;
C = pid(Kp,Ki);

T = feedback(C*P_cruise, 1);

figure
step(r*T, t)
axis([0 20 0 10])

%=========================================%

Kp = 1000;
Ki = 100;
Kd = 100;
C = pid(Kp, Ki, Kd);

T = feedback(C*P_cruise, 1);

figure
step(r*T, t)
axis([0 20 0 10])
