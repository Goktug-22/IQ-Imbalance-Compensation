
% 16 QAM Modulation Signal Error Rate 

close all 
clear 
clc

I0=1;
Q0=1;
e=1;
d=0;

t=0:0.1:360;
x_int1=1.414*(cosd(t)+1i*sind(t));
x_int2=3.162*(cosd(t)+1i*sind(t));
x_int3=4.242*(cosd(t)+1i*sind(t));

error1 = 0;
error2 = 0;

% noise and iteration counter
noise = 20;
iteration = 400;

for k=1:iteration
    e=0.3;
    d=5;
    
    noisy_sine1 = awgn((1.414+e).*sind(t+d), noise);
    noisy_cosine1 = awgn(1.414*cosd(t), noise);
    
    noisy_sine2 = awgn((3.162+e).*sind(t+d), noise);
    noisy_cosine2 = awgn(3.162*cosd(t), noise);
    
    noisy_sine3 = awgn((4.242+e).*sind(t+d), noise);
    noisy_cosine3 = awgn(4.242*cosd(t), noise);
    
    x1 = noisy_cosine1 + 1i*(noisy_sine1);
    x2 = noisy_cosine2 + 1i*(noisy_sine2);
    x3 = noisy_cosine3 + 1i*(noisy_sine3);
    
    subplot(1,2,1);
    hold on;
    plot(real(x1(450)),imag(x1(450)),"b.","MarkerSize",7);
    hold off;
    
    % circle 1
    t1=-1.*mean(sign(real(x1)).*imag(x1));
    t2=mean(abs(real(x1)));
    t3=mean(abs(imag(x1)));
    c1=t1/t2;
    c2=sqrt((t3^2-t1^2)/(t2^2));
    g=t3/t2;
    f=asind(t1/t3);
    y1=(real(x1).*c2+1i*(c1.*real(x1)+imag(x1)))/c2;
    
    % circle 2
    t1=-1.*mean(sign(real(x2)).*imag(x2));
    t2=mean(abs(real(x2)));
    t3=mean(abs(imag(x2)));
    c1=t1/t2;
    c2=sqrt((t3^2-t1^2)/(t2^2));
    g=t3/t2;
    f=asind(t1/t3);
    y2=(real(x2).*c2+1i*(c1.*real(x2)+imag(x2)))/c2;
    
    % circle 3
    t1=-1.*mean(sign(real(x3)).*imag(x3));
    t2=mean(abs(real(x3)));
    t3=mean(abs(imag(x3)));
    c1=t1/t2;
    c2=sqrt((t3^2-t1^2)/(t2^2));
    g=t3/t2;
    f=asind(t1/t3);
    y3=(real(x3).*c2+1i*(c1.*real(x3)+imag(x3)))/c2;

    radius = abs(x1(450) - (1 + 1i));
    if radius > 1
       error1 = error1 + 1; 
    end 
    
    radius = abs(y1(450) - (1 + 1i)); 
    if radius > 1
       error2 = error2 + 1; 
    end 
    
    subplot(1,2,2);
    hold on;   
    plot(real(y1(450)),imag(y1(450)),"b.","MarkerSize",7);
    hold off;
    
end

circle=1*(cosd(t)+1+1i*(sind(t)+1));

for k = 1:2
    
    subplot(1,2,k);
    hold on;
    grid on
    xlabel("I Channel");
    ylabel("Q Channel");
    title("IQ Imbalance");
    axis([-2 2 -2 2]);
    for j = 1:4  
        plot(real(x_int1(900*(j-1)+450)),imag(x_int1(900*(j-1)+450)),"k+","MarkerSize",15,"LineWidth",1);

        plot(real(x_int2(900*(j-1)+184)),imag(x_int2(900*(j-1)+184)),"k+","MarkerSize",15,"LineWidth",1);
        plot(real(x_int2(900*(j-1)+716)),imag(x_int2(900*(j-1)+716)),"k+","MarkerSize",15,"LineWidth",1);

        plot(real(x_int3(900*(j-1)+450)),imag(x_int3(900*(j-1)+450)),"k+","MarkerSize",15,"LineWidth",1);
        plot(real(circle), imag(circle), 'g', 'LineWidth', 1);
    end
    plot([-4 4], [0 0], 'k', 'LineWidth', 1)  %xx
    plot([0 0], [-4 4], 'k', 'LineWidth', 1) %yy
    hold off;
end

subplot(1,2,2);
title("IQ Imbalance Compansated");


BER1 = error1 / iteration;
disp(['Error Imbalance: ', num2str(error1), ' times, BER: %', num2str(BER1*100)]);
BER2 = error2 / iteration;
disp(['Error Compansated: ', num2str(error2), ' times, BER: %', num2str(BER2*100)]);


