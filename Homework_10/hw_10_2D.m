% System parameters (Fig. 4.42)
Kc = 587;
J = 0.10;
b = 1.00;
tauc = 0.005;

Gc = tf([tauc 1], 1);
Gp1 = tf(10, [.5 1]);
Gp2 = tf(1, [J b]);

GL = Gc*Gp1*Gp2;
figure(1); rlocus(GL); title(sprintf('Root Locus, \\tau_c = %.3g', tauc))

Try = feedback(Kc*Gc*Gp1*Gp2, 1);
figure(2); pzmap(Try); title("Pole-Zero Map for Speed-control System");

Try_step = stepinfo(Try, 'SettlingTimeThreshold', 0.01)
figure(3); step(Try); title("Pole-Zero Map for Speed-control System");


