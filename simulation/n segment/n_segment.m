clc; clear all;

% Set the initail configuration of the structure
global P n a b l alpha0 phi0 Kb Kw
a = [1,1,1];
b = [1,1,1];
l = [4,3,2,1];
alpha0 = [pi/3,pi/3,pi/3];
phi0 = [2*pi/3,2*pi/3,2*pi/3];
Kb = 180/pi;
Kw = 180/pi;
n = 3;
ii = 1;


% Simulate the results with different force input
for P = 0.2:0.2:5

    % solve the Force equilibrium equation
    Solution = fsolve(@n_segment_FR,alpha0);

% calculate the phi and theta angle from results of alpha angle
for i=1:n
    alpha(i) = real(Solution(i));
    A(i) = -2*b(i)*l(i) + 2*a(i)*b(i)*cos(alpha(i));
    B(i) = 2*a(i)*b(i)*sin(alpha(i));
    C(i) = a(i)^2 + b(i)^2 + l(i)^2 - l(i+1)^2 - 2*a(i)*l(i)*cos(alpha(i));
    delta(i) = atan(B(i)/A(i));
    phi(i) = delta(i) - acos(C(i)/sqrt(A(i)^2+B(i)^2)) + pi;
    theta(i) = acos((l(i)+b(i)*cos(phi(i))-a(i)*cos(alpha(i)))/l(i+1));
end

% Plotting. x and y are the initial configuration, xx and yy are the final
% configuration.
x(1,1) = 0;                         y(1,1) = 0;
x(1,2) = a(1)*cos(alpha0(1));       y(1,2) = a(1)*sin(alpha0(1));
x(1,3) = x(1,2)+l(2);               y(1,3) = y(1,2);
x(1,4) = l(1);                      y(1,4) = 0;
xx(1,1) = 0;                        yy(1,1) = 0;
xx(1,2) = a(1)*cos(alpha(1));       yy(1,2) = a(1)*sin(alpha(1)); 
xx(1,3) = xx(1,2)+l(2)*cos(theta(1));   yy(1,3) = yy(1,2)+l(2)*sin(theta(1));
xx(1,4) = l(1);                        yy(1,4) = 0;
plot(x(1,:),y(1,:),'--r',xx(1,:),yy(1,:),'b');
hold on
for i = 2:n    
    x(i,1) = x(i-1,2);                         y(i,1) = y(i-1,2);
    x(i,2) = x(i,1)+a(i)*cos(alpha0(i));       y(i,2) = y(i,1)+a(i)*sin(alpha0(i));
    x(i,3) = x(i,2)+l(i+1);                      y(i,3) = y(i,2);
    x(i,4) = x(i-1,3);                         y(i,4) = y(i-1,3);
    xx(i,1) = xx(i-1,2);                       yy(i,1) = yy(i-1,2);
    xx(i,2) = xx(i,1)+a(i)*cos(alpha(i)+sum(theta(1):theta(i-1)));      yy(i,2) = y(i,1)+a(i)*sin(alpha(i)+sum(theta(1):theta(i-1))); 
    xx(i,3) = xx(i,2)+l(i+1)*cos(theta(i));    yy(i,3) = yy(i,2)+l(i+1)*sin(theta(i));
    xx(i,4) = xx(i-1,3);                        yy(i,4) = yy(i-1,3);
    plot(x(i,:),y(i,:),'--r',xx(i,:),yy(i,:),'b');
end
axis([0,l(1),0,l(1)]);
hold off

% generate the GIF pic of simulation 
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
if P==0.2
     imwrite(I,map,'n_segment_simulation.gif','gif','Loopcount',1,'DelayTime',0.1);
else
     imwrite(I,map,'n_segment_simulation.gif','gif','WriteMode','append','DelayTime',0.1);  
end

    theta1(ii) = theta(1);
    theta2(ii) = theta(2);
    theta3(ii) = theta(3);
%     theta4(ii) = theta(4);
%     theta5(ii) = theta(5);
    ii = ii+1;
end

% plot theta vs F
plot(0.2:0.2:5, theta1*180/pi, 0.2:0.2:5, theta2*180/pi, 0.2:0.2:5, theta3*180/pi)
legend('theta1','theta2','theta3')
xlabel('F (N)')
ylabel('theta (degree)')