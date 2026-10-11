if exist('OCTAVE_VERSION', 'builtin')
    pkg load control;
end

num_1 = [1 2];
den_1 = [1 10 8];
G_1 = tf(num_1, den_1);
G_1_poles = pole(G_1)
G_1_zeros = zero(G_1)

num_2 = [5 15];
den_2 = [1 2 10];
G_2 = tf(num_2, den_2);
G_2_poles = pole(G_2)
G_2_zeros = zero(G_2)

num_3 = [1 3];
den_3 = [1 -4 8];
G_3 = tf(num_3, den_3);
G_3_poles = pole(G_3)
G_3_zeros = zero(G_3)

num_4 = [5 15];
den_4 = [1 2 6 10];
G_4 = tf(num_4, den_4);
G_4_poles = pole(G_4)
G_4_zeros = zero(G_4)

num_5 = [2 9];
den_5 = [1 2 6 30];
G_5 = tf(num_5, den_5);
G_5_poles = pole(G_5)
G_5_zeros = zero(G_5)
