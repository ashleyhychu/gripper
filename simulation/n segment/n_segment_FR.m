function F = n_segment_FR(alpha)


% suppose n is the number of segments
% a,b should be nx1 vector, l should be (n+1)x1 vector

global P n a b l alpha0 phi0 Kb Kw
F = [];

    for i = 1:n
    A(i) = -2*b(i)*l(i) + 2*a(i)*b(i)*cos(alpha(i));
    B(i) = 2*a(i)*b(i)*sin(alpha(i));
    C(i) = a(i)^2 + b(i)^2 + l(i)^2 - l(i+1)^2 - 2*a(i)*l(i)*cos(alpha(i));
    delta(i) = atan(B(i)/A(i));
    phi(i) = delta(i) - acos(C(i)/sqrt(A(i)^2+B(i)^2)) + pi;
    theta(i) = acos((l(i)+b(i)*cos(phi(i))-a(i)*cos(alpha(i)))/l(i+1));
    
    Mbl(i) = Kb*(alpha0(i)-alpha(i));
    Mbr(i) = Kb*(phi0(i)-phi(i));
    end
    
    for i = 1:(n-1)
    Mwl(i) = Kw*(alpha(i+1)-alpha(i)+theta(i));
    Mwr(i) = Kw*(phi(i+1)-phi(i)+theta(i));
    end
    
    F = [];
    for i = 2:(n-1) 
%     F(i) = (Mbl(i)-Mwl(i-1)+Mwl(i))*a(i) - ...,
%         (Mbr(i)-Mwr(i-1)+Mwr(i))*b(i)/sin(phi(i)-theta(i))*sin(alpha(i)-theta(i));
    F(i) = (Mbl(i)-Mwl(i-1))*a(i) - ...,
        (Mbr(i)-Mwr(i-1))*b(i)/sin(phi(i)-theta(i))*sin(alpha(i)-theta(i));

    end
    F(1) = P*sin(alpha(1)) - (Mbl(1)-Mwl(1))*a(1) - ...,
        (-Mbr(1)+Mwr(1))*b(1)/sin(phi(1)-theta(1))*sin(alpha(1)-theta(1));
    F(n) = (Mbl(n)-Mwl(n-1))*a(n) - ...,
        (Mbr(n)-Mwr(n-1))*b(n)/sin(phi(n)-theta(n))*sin(alpha(n)-theta(n));

end