
% 4 QAM Modulation Signal Error Rate 

close all 
clear 
clc

I0=1;
Q0=1;
e=1;
d=0;

t=0:0.1:360;
x_int=1.414*(cosd(t)+1i*sind(t));

error1 = 0;
error2 = 0;

% noise and iteration counter
noise = 20;
iteration = 400;

for k=1:iteration
    e=0.3;
    d=5;
    
    noisy_sine = awgn((1.414+e).*sind(t+d), noise);
    noisy_cosine = awgn(1.414*cosd(t), noise);
    
    x = noisy_cosine + 1i*(noisy_sine);
    
    subplot(1,2,1);
    hold on;
    plot(real(x(450)),imag(x(450)),"b.","MarkerSize",7);
    hold off;
    
    t1=-1.*mean(sign(real(x)).*imag(x));
    t2=mean(abs(real(x)));
    t3=mean(abs(imag(x)));
    c1=t1/t2;
    c2=sqrt((t3^2-t1^2)/(t2^2));
    g=t3/t2;
    f=asind(t1/t3);
    y=(real(x).*c2+1i*(c1.*real(x)+imag(x)))/c2;
    
    radius = abs(x(450) - (1 + 1i));
    if radius > 1
       error1 = error1 + 1; 
    end 
    
    radius = abs(y(450) - (1 + 1i));
    if radius > 1
       error2 = error2 + 1; 
    end 

    subplot(1,2,2);
    hold on;
    plot(real(y(450)),imag(y(450)),"b.","MarkerSize",7);
    hold off;
    
end

circle=1*(cosd(t)+1+1i*(sind(t)+1));

subplot(1,2,1);
hold on;
grid on
xlabel("I Channel");
ylabel("Q Channel");
title("IQ Imbalance");
axis([-2 2 -2 2]);
plot(real(x_int(450)),imag(x_int(450)),"k+","MarkerSize",15,"LineWidth",1);
plot(real(x_int(1350)),imag(x_int(1350)),"k+","MarkerSize",15,"LineWidth",1);
plot(real(x_int(2250)),imag(x_int(2250)),"k+","MarkerSize",15,"LineWidth",1);
plot(real(x_int(3150)),imag(x_int(3150)),"k+","MarkerSize",15,"LineWidth",1);
plot(real(circle), imag(circle), 'g','LineWidth', 1);
plot([-2 2], [0 0], 'k', 'LineWidth', 1)  %xxx
plot([0 0], [-2 2], 'k', 'LineWidth', 1) %yyy
hold off;

subplot(1,2,2);
hold on;
grid on
xlabel("I Channel");
ylabel("Q Channel");
title("IQ Imbalance Compansated");
axis([-2 2 -2 2]);
plot(real(x_int(450)),imag(x_int(450)),"k+","MarkerSize",15,"LineWidth",1);
plot(real(x_int(1350)),imag(x_int(1350)),"k+","MarkerSize",15,"LineWidth",1);
plot(real(x_int(2250)),imag(x_int(2250)),"k+","MarkerSize",15,"LineWidth",1);
plot(real(x_int(3150)),imag(x_int(3150)),"k+","MarkerSize",15,"LineWidth",1);
plot(real(circle), imag(circle), 'g','LineWidth', 1);
plot([-2 2], [0 0], 'k', 'LineWidth', 1)  %xxx
plot([0 0], [-2 2], 'k', 'LineWidth', 1) %yyy
hold off;

BER1 = error1 / iteration;
disp(['Error Imbalance: ', num2str(error1), ' times, BER: %', num2str(BER1*100)]);
BER2 = error2 / iteration;
disp(['Error Compansated: ', num2str(error2), ' times, BER: %', num2str(BER2*100)]);


