% System parameters (Table 1)
kt = 2;
J  = 3;
b  = 5;
kp = 10;
kd = 1;
ki = 100;

num_A = [kd*kt kp*kt];
den_A = [J b];
sys_A = tf(num_A, den_A)

num_B = [kp*kt ki*kt];
den_B = [J b 0];
sys_B = tf(num_B, den_B)

num_C = [kd*kt kp*kt];
den_C = [J b 0];
sys_C = tf(num_C, den_C)

num_D = [kp*kt ki*kt];
den_D = [J b 0 0];
sys_D = tf(num_D, den_D)
