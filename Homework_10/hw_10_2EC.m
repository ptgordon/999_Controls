% System parameters (Fig. 4.42)
Kc = .5;
J = 0.10;
b = 1.00;
z1 = -2;
z2 = -10;

Gc = tf([1 -z1-z2 z1*z2], [1 0]);
Gp1 = tf(10, [.5 1]);
Gp2 = tf(1, [J b]);

GL = Gc*Gp1*Gp2;
figure(1); rlocus(GL); title(sprintf('Root Locus, z_1 = %.3g, z_2 = %.3g', z1, z2))

Try = feedback(Kc*Gc*Gp1*Gp2, 1);
figure(2); pzmap(Try); title("Pole-Zero Map of T_{ry} for Speed-control System");

Try_step = stepinfo(Try, 'SettlingTimeThreshold', 0.01)
figure(3); step(Try); title("Step Response of T_{ry} for Speed-control System");


