a = [1 2 3; 3 2 3; 0 1 0];
b = [ 0 0 1; 0 1 1; 1 1 0];
c = [1 2 3];

disp("B.1")
a + b

disp("B.2")
d = inv(b)

disp("B.3")
b * d

disp("B.4")
sin(a)

disp("B.5")
a * b

disp("B.6")
a .* b

disp("B.7")
a'

disp("B.8")
a + a'
