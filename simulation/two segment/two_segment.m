clear; clc;

a1 = 1;     a2 = 1;
b1 = 1;     b2 = 1;
l0 = 3;     l1 = 2;     l2 = 1;     
alpha10 = pi/3;        alpha20 = pi/3;
phi10 = 2*pi/3;        phi20 = 2*pi/3;
global P
i = 0;

for P = 0.5:0.5:25
i = i+1;
    
Solution = fsolve(@two_seg_FR,[pi/3,pi/3]);
alpha1 = real(Solution(1));
alpha2 = real(Solution(2));

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
theta_1(i) = theta1;
theta_2(i) = theta2;

plot([0,a1*cos(alpha10),a1*cos(alpha10)+l1,l0],[0,a1*sin(alpha10),a1*sin(alpha10),0],'--r');
hold on
plot([a1*cos(alpha10),a1*cos(alpha10)+a2*cos(alpha20),a1*cos(alpha10)+a2*cos(alpha20)+l2,a1*cos(alpha10)+l1], ...,
     [a1*sin(alpha10),a1*sin(alpha10)+a2*sin(alpha20),a1*sin(alpha10)+a2*sin(alpha20),a1*sin(alpha10)],'--r');

plot([0,a1*cos(alpha1),a1*cos(alpha1)+l1*cos(theta1),l0],[0,a1*sin(alpha1),a1*sin(alpha1)+l1*sin(theta1),0],'b');
plot(a1*cos(alpha1),a1*sin(alpha1),'ok',a1*cos(alpha1)+l1*cos(theta1),a1*sin(alpha1)+l1*sin(theta1),'ok', ...,
    a1*cos(alpha1)+a2*cos(alpha2+theta1),a1*sin(alpha1)+a2*sin(alpha2+theta1),'ok',a1*cos(alpha1)+a2*cos(alpha2+theta1)+l2*cos(theta1+theta2),a1*sin(alpha1)+a2*sin(alpha2+theta1)+l2*sin(theta1+theta2),'ok');
text(0.1,a1*sin(alpha10),'F \rightarrow')

plot([a1*cos(alpha1),a1*cos(alpha1)+a2*cos(alpha2+theta1),a1*cos(alpha1)+a2*cos(alpha2+theta1)+l2*cos(theta1+theta2),a1*cos(alpha1)+l1*cos(theta1)], ...,
     [a1*sin(alpha1),a1*sin(alpha1)+a2*sin(alpha2+theta1),a1*sin(alpha1)+a2*sin(alpha2+theta1)+l2*sin(theta1+theta2),a1*sin(alpha1)+l1*sin(theta1)],'b');
axis ([0,3,0,3]);
hold off

 drawnow
    ax = gca;
    ax = gca;
    ax.Units = 'pixels';
    pos = ax.Position;
    marg = 30;
    rect = [-marg, -marg, pos(3)+2*marg, pos(4)+2*marg];
    F = getframe(gca,rect);
    ax.Units = 'normalized';
    
frame=getframe;
im=frame2im(frame);
[I,map]=rgb2ind(im,256);
if P==0.5
     imwrite(I,map,'2_segment_simulation.gif','gif','Loopcount',1,'DelayTime',0.1);
else
     imwrite(I,map,'2_segment_simulation.gif','gif','WriteMode','append','DelayTime',0.1);  
end

end

plot(0.5:0.5:25, theta_1*180/pi, 0.5:0.5:25, theta_2*180/pi)
legend('theta1','theta2')
xlabel('F (N)')
ylabel('theta (degree)')