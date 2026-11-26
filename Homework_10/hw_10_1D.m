% System parameters (Table 1)
kt = 2;
J  = 3;
b  = 5;
kp = 10;
kd = 1;
ki = 100;

num_A = [kd*kt kp*kt];
den_A = [J+kd*kt b+kp*kt];
sys_A = tf(num_A, den_A)

num_B = [kp*kt ki*kt];
den_B = [J b+kp*kt ki*kt];
sys_B = tf(num_B, den_B)

num_C = [kd*kt kp*kt];
den_C = [J b+kd*kt kp*kt];
sys_C = tf(num_C, den_C)

num_D = [kp*kt ki*kt];
den_D = [J b kp*kt ki*kt];
sys_D = tf(num_D, den_D)


figure(1); pzmap(sys_A); title('Pole-Zero Map: Case A')
figure(2); pzmap(sys_B); title('Pole-Zero Map: Case B')
figure(3); pzmap(sys_C); title('Pole-Zero Map: Case C')
figure(4); pzmap(sys_D); title('Pole-Zero Map: Case D')

figure(5); step(sys_A); title('Step Response: Case A')
figure(6); step(sys_B); title('Step Response: Case B')
figure(7); step(sys_C); title('Step Response: Case C')
figure(8); step(sys_D); title('Step Response: Case D')
