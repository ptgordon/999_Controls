% System parameters (Table 1)
kt = 2;
J  = 3;
b  = 5;
kp = 10;
kd = 1;
ki = 100;

Gc_A = tf([kd kp], 1);
Gp_A = tf(kt, [J b]);
G_A = Gc_A * Gp_A;
Try_A = feedback(G_A, 1)
Tre_A = feedback(1, G_A)

Gc_B = tf([kp ki], [1 0]);
Gp_B = tf(kt, [J b]);
G_B = Gc_B * Gp_B;
Try_B = feedback(G_B, 1)
Tre_B = feedback(1, G_B)

Gc_C = tf([kd kp], 1);
Gp_C = tf(kt, [J b 0]);
G_C = Gc_C * Gp_C;
Try_C = feedback(G_C, 1)
Tre_C = feedback(1, G_C)

Gc_D = tf([kp ki], [1 0]);
Gp_D = tf(kt, [J b 0]);
G_D = Gc_D * Gp_D;
Try_D = feedback(G_D, 1)

figure(1); pzmap(Try_A); title('Pole-Zero Map: Case A')
figure(2); pzmap(Try_B); title('Pole-Zero Map: Case B')
figure(3); pzmap(Try_C); title('Pole-Zero Map: Case C')
figure(4); pzmap(Try_D); title('Pole-Zero Map: Case D')

figure(5); step(Try_A); title('Step Response: Case A')
figure(6); step(Try_B); title('Step Response: Case B')
figure(7); step(Try_C); title('Step Response: Case C')
figure(8); step(Try_D); title('Step Response: Case D')

figure(9); bode(Tre_A); title('Frequency Response: Case A')
figure(10); bode(Tre_B); title('Frequency Response: Case B')
figure(11); bode(Tre_C); title('Frequency Response: Case C')
