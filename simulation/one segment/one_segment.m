%% simulation

clear; clc;

syms alpha1
% known parameters of 1-segment Fin-ray
a1 = 1;    
b1 = 1;     
l0 = 3;     l1 = 2;     
alpha10 = pi/3;        
phi10 = 2*pi/3;
Kb = 180/pi;
P = input('force in N?\n');

A1 = (-2*b1*l0 + 2*a1*b1*cos(alpha1));
B1 = (2*a1*b1*sin(alpha1));
C1 = (a1^2 + b1^2 + l0^2 - l1^2 - 2*a1*l0*cos(alpha1));
delta1 = atan(B1/A1);

phi1 = delta1 - acos(C1/sqrt(A1^2+B1^2)) + pi;
theta1 = acos((l0+b1*cos(phi1)-a1*cos(alpha1))/l1);

S = solve(P*sin(alpha1) - (alpha10 - alpha1)*Kb*a1 - (phi1-phi10)*Kb*b1/sin(phi1-theta1)*sin(alpha1 - theta1), alpha1);
alpha_1 = double(vpa(S))
phi_1 = double(vpa(subs(phi1,alpha1,S)))
theta_1 = double(vpa(subs(theta1,alpha1,S)))


hold on
plot([0,a1*cos(alpha10)],[0,a1*sin(alpha10)],'--r');
plot([a1*cos(alpha10),a1*cos(alpha10)+l1],[a1*sin(alpha10),a1*sin(alpha10)],'--r');
plot([l0,l0+b1*cos(phi10)],[0,sin(phi10)],'--r');

plot([0,a1*cos(alpha_1)],[0,a1*sin(alpha_1)],'b');
plot(a1*cos(alpha_1),a1*sin(alpha_1),'ok')
plot([a1*cos(alpha_1),a1*cos(alpha_1)+l1*cos(theta_1)],[a1*sin(alpha_1),a1*sin(alpha_1)+l1*sin(theta_1)],'b');
plot(a1*cos(alpha_1)+l1*cos(theta_1),a1*sin(alpha_1)+l1*sin(theta_1),'ok')
plot([l0,l0+b1*cos(phi_1)],[0,sin(phi_1)]),'b';
text(0.1,a1*sin(alpha10),'F \rightarrow')
axis equal

%% theta vs. F

clear; clc;

syms alpha1
% known parameters of 1-segment Fin-ray
a1 = 1;    
b1 = 1;     
l0 = 3;     l1 = 2;     
alpha10 = pi/3;        
phi10 = 2*pi/3;
Kb = 180/pi;

for i = 1:20
A1 = (-2*b1*l0 + 2*a1*b1*cos(alpha1));
B1 = (2*a1*b1*sin(alpha1));
C1 = (a1^2 + b1^2 + l0^2 - l1^2 - 2*a1*l0*cos(alpha1));
delta1 = atan(B1/A1);

P(i) = 10*i;
phi1 = delta1 - acos(C1/sqrt(A1^2+B1^2)) + pi;
theta1 = acos((l0+b1*cos(phi1)-a1*cos(alpha1))/l1);

S = solve(P(i)*sin(alpha1) - (alpha10 - alpha1)*Kb*a1 - (phi1-phi10)*Kb*b1/sin(phi1-theta1)*sin(alpha1 - theta1), alpha1);
theta_1(i) = double(vpa(subs(theta1,alpha1,S)))*180/pi;
end

plot(P,theta_1);
xlabel('F (N)');
ylabel('theta (degree)')

