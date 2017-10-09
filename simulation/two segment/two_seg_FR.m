function F=two_seg_FR(x)

alpha1 = x(1);
alpha2 = x(2);
a1 = 1;     a2 = 1;
b1 = 1;     b2 = 1;
l0 = 3;     l1 = 2;     l2 = 1;     
alpha10 = pi/3;        alpha20 = pi/3;
phi10 = 2*pi/3;        phi20 = 2*pi/3;
Kb = 180/pi; Kw = 180/pi;
global P;

A1 = (-2*b1*l0 + 2*a1*b1*cos(alpha1));
B1 = (2*a1*b1*sin(alpha1));
C1 = (a1^2 + b1^2 + l0^2 - l1^2 - 2*a1*l0*cos(alpha1));
delta1 = atan(B1/A1);
A2 = (-2*b2*l1 + 2*a2*b2*cos(alpha2));
B2 = (2*a2*b2*sin(alpha2));
C2 = (a2^2 + b2^2 + l1^2 - l2^2 - 2*a2*l1*cos(alpha2));
delta2 = atan(B2/A2);

phi1 = delta1 - acos(C1/sqrt(A1^2+B1^2)) + pi;
theta1 = acos((l0+b1*cos(phi1)-a1*cos(alpha1))/l1);
phi2 = delta2 - acos(C2/sqrt(A2^2+B2^2)) + pi;
theta2 = acos((l1+b2*cos(phi2)-a2*cos(alpha2))/l2);

Mwl12 = (alpha2-alpha1+theta1)*Kw;
Mwr12 = (phi2 - phi1 + theta1)*Kw;
Mbl2 = (alpha20-alpha2)*Kb;
Mbr2 = (phi20-phi2)*Kb;


F = [P*sin(alpha1) - ((alpha10 - alpha1)*Kb-Mwl12)*a1 - ...,
    ((phi1-phi10)*Kb+Mwr12)*b1/sin(phi1-theta1)*sin(alpha1 - theta1),
           (Mbl2-Mwl12)*a2 - ...,
    (Mbr2-Mwr12)*b2/sin(phi2-theta2)*sin(alpha2 - theta2)];

end