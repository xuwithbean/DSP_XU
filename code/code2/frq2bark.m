function [b,c] = frq2bark(f,m)
persistent A B C D P Q R S T U
if isempty(P)
    A=26.81;
    B=1960;
    C=-0.53;
    D=A*B;
    P=(0.53/(3.53)^2);
    Q=0.25;
    R=20.4;
    xy=2;
    S=0.5*Q/xy;
    T=R+0.5*xy;
    U=T-xy;
end
if nargin<2
    m=' ';
end
if any(m=='u')
    g=f;
else
    g=abs(f);
end
if any(m=='z')
    b=13*atan(0.00076*g)+3.5*atan((f/7500).^2);
    c=25+75*(1+1.4e-6*f.^2).^0.69;
elseif any(m=='s')
    b=7*log(g/650+sqrt(1+(g/650).^2));
    c=cosh(b/7)*650/7;
else
    b=A*g./(B+g)+C;
    d=D*(B+g).^(-2);
    if any(m=='l')
        m1=(b<2);
        d(m1)=d(m1)*0.85;
        b(m1)=0.3+0.85*b(m1);
    elseif ~any(m=='L')
        m1=(b<3);
        b(m1)=b(m1)+P*(3-b(m1)).^2;
        d(m1)=d(m1).*(1-2*P*(3-b(m1)));
    end
    if any(m=='h')
        m1=(b>20.1);
        d(m1)=d(m1)*1.22;
        b(m1)=1.22*b(m1)-4.422;
    elseif ~any(m=='H')
        m2=(b>T);
        m1=(b>U) & ~m2;
        b(m1)=b(m1)+S*(b(m1)-U).^2;
        b(m2)=(1+Q)*b(m2)-Q*R;
        d(m2)=d(m2).*(1+Q);
        d(m1)=d(m1).*(1+2*S*(b(m1)-U));
    end
    c=d.^(-1);
end
if ~any(m=='u')
    b=b.*sign(f);          % force to be odd
end

if ~nargout || any(m=='g')
    subplot(212)
    semilogy(f,c,'-r');
    ha=gca;
    ylabel(['Critical BW (' yticksi 'Hz)']);
    xlabel(['Frequency (' xticksi 'Hz)']);
    subplot(211)
    plot(f,b,'x-b');
    hb=gca;
    ylabel('Bark');
    xlabel(['Frequency (' xticksi 'Hz)']);
    linkaxes([ha hb],'x');
end
