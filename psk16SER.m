
% 16 PSK Modulation Signal Error Rate 

close all 
clear 
clc

I0=1;
Q0=1;
e=1;
d=0;

t=0:0.1:360;
x_int=1*(cosd(t)+1i*sind(t));

error1 = 0;
error2 = 0;

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
    plot(real(x(225)),imag(x(225)),"b.","MarkerSize",7);
    hold off;
    
    t1=-1.*mean(sign(real(x)).*imag(x));
    t2=mean(abs(real(x)));
    t3=mean(abs(imag(x)));
    c1=t1/t2;
    c2=sqrt((t3^2-t1^2)/(t2^2));
    g=t3/t2;
    f=asind(t1/t3);
    y=(real(x).*c2+1i*(c1.*real(x)+imag(x)))/c2;

    compansated_angle = atand(imag(x(225))/real(x(225)));
    if (compansated_angle < 11.3) || (compansated_angle > 33.7)
        error1 = error1 + 1;
    end
    
    compansated_angle = atand(imag(y(225))/real(y(225)));
    if (compansated_angle < 11.3) || (compansated_angle > 33.7)
        error2 = error2 + 1;
    end
    
    subplot(1,2,2);
    hold on;
    plot(real(y(225)),imag(y(225)),"b.","MarkerSize",7);
    hold off;
    
end

l1 = t*cosd(11.3) + 1i.*t.*sind(11.3);
l2 = t*cosd(33.7) + 1i.*t.*sind(33.7);

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
    plot(real(l1), imag(l1), 'b');
    plot(real(l2), imag(l2), 'b');
    
    hold off;
end

subplot(1,2,2);
title("IQ Imbalance Compansated");

BER1 = error1 / iteration;
disp(['Error Imbalance: ', num2str(error1), ' times, BER: %', num2str(BER1*100)]);
BER2 = error2 / iteration;
disp(['Error Compansated: ', num2str(error2), ' times, BER: %', num2str(BER2*100)]);









