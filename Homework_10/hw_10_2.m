% System parameters (Fig. 4.42) and amplifier gain from 4.29(a)
K = 9.9;
J = 0.10;
b = 1.00;
tauc = 0.05;

Gp1 = tf(10, [.5 1]);
Gp2 = tf(1, [J b]);

Tdy = feedback(Gp2, K*Gp1)
Tde = -feedback(Gp2, K*Gp1)
Tre = feedback(1, K*Gp1*Gp2)
Try = feedback(K*Gp1*Gp2, 1)

figure(1); pzmap(Try); title("Pole-Zero Map for Speed-control System");
figure(2); step(Try); title("Step Response for Speed-control System");

Gc = 
