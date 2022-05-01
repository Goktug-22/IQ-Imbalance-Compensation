
% 16 PSK Modulation constellation diagram

close all 
clear 
clc

I0=1;
Q0=1;
e=1;
d=0;

t=0:0.1:360;
x_int=1*(cosd(t)+1i*sind(t));

% noise and iteration counter
noise = 20;
iteration = 400;

for k=1:iteration
    e=0.3;
    d=5;
    
    noisy_sine = awgn((1+e).*sind(t+d), noise);
    noisy_cosine = awgn(1*cosd(t), noise);
    
    x = noisy_cosine + 1i*(noisy_sine);
    
    subplot(1,2,1);
    hold on;

    for j = 1:4  
        plot(real(x(900*(j-1)+1)),imag(x(900*(j-1)+1)),"b.","MarkerSize",7);
        plot(real(x(900*(j-1)+225)),imag(x(900*(j-1)+225)),"b.","MarkerSize",7);
        plot(real(x(900*(j-1)+450)),imag(x(900*(j-1)+450)),"b.","MarkerSize",7);
        plot(real(x(900*(j-1)+675)),imag(x(900*(j-1)+675)),"b.","MarkerSize",7);
    end
    
    hold off;
    
    t1=-1.*mean(sign(real(x)).*imag(x));
    t2=mean(abs(real(x)));
    t3=mean(abs(imag(x)));
    c1=t1/t2;
    c2=sqrt((t3^2-t1^2)/(t2^2));
    g=t3/t2;
    f=asind(t1/t3);
    y=(real(x).*c2+1i*(c1.*real(x)+imag(x)))/c2;

    subplot(1,2,2);
    hold on;
    
    for j = 1:4  
        plot(real(y(900*(j-1)+1)),imag(y(900*(j-1)+1)),"b.","MarkerSize",7);
        plot(real(y(900*(j-1)+225)),imag(y(900*(j-1)+225)),"b.","MarkerSize",7);
        plot(real(y(900*(j-1)+450)),imag(y(900*(j-1)+450)),"b.","MarkerSize",7);
        plot(real(y(900*(j-1)+675)),imag(y(900*(j-1)+675)),"b.","MarkerSize",7);
    end
    hold off;
    
end

for k = 1:2
    
    subplot(1,2,k);
    hold on;
    grid on
    xlabel("I Channel");
    ylabel("Q Channel");
    title("IQ Imbalance");
    axis([-1.5 1.5 -1.5 1.5]);
    for j = 1:4  
        plot(real(x_int(900*(j-1)+1)),imag(x_int(900*(j-1)+1)),"k+","MarkerSize",15,"LineWidth",1);
        plot(real(x_int(900*(j-1)+225)),imag(x_int(900*(j-1)+225)),"k+","MarkerSize",15,"LineWidth",1);
        plot(real(x_int(900*(j-1)+450)),imag(x_int(900*(j-1)+450)),"k+","MarkerSize",15,"LineWidth",1);
        plot(real(x_int(900*(j-1)+675)),imag(x_int(900*(j-1)+675)),"k+","MarkerSize",15,"LineWidth",1);
    end
    plot([-2 2], [0 0], 'k', 'LineWidth', 1)  %xxx
    plot([0 0], [-2 2], 'k', 'LineWidth', 1) %yyy
    hold off;
end

subplot(1,2,2);
title("IQ Imbalance Compansated");












