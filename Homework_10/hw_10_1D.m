% System parameters (Table 1)
kt = 2;
J  = 3;
b  = 5;
kp = 10;
kd = 1;
ki = 100;

num_A = [kd*kt kp*kt];
den_A = [J+kd*kt b+kp*kt];
Try_A = tf(num_A, den_A)

num_B = [kp*kt ki*kt];
den_B = [J b+kp*kt ki*kt];
Try_B = tf(num_B, den_B)

num_C = [kd*kt kp*kt];
den_C = [J b+kd*kt kp*kt];
Try_C = tf(num_C, den_C)

num_D = [kp*kt ki*kt];
den_D = [J b kp*kt ki*kt];
Try_D = tf(num_D, den_D)


figure(1); pzmap(Try_A); title('Pole-Zero Map: Case A')
figure(2); pzmap(Try_B); title('Pole-Zero Map: Case B')
figure(3); pzmap(Try_C); title('Pole-Zero Map: Case C')
figure(4); pzmap(Try_D); title('Pole-Zero Map: Case D')

figure(5); step(Try_A); title('Step Response: Case A')
figure(6); step(Try_B); title('Step Response: Case B')
figure(7); step(Try_C); title('Step Response: Case C')
figure(8); step(Try_D); title('Step Response: Case D')

Gc_A = tf([kd kp], 1);
Gp_A = tf(kt, [J b]);

Gc_B = tf([kd kp], [1 0]);
Gp_B = tf(kt, [J b]);
