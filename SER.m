
% Signal Error Rate Graphics 

close all 
clear 
clc

f1 = figure;
f2 = figure;
f3 = figure;
f4 = figure;
f5 = figure;
f6 = figure;
f7 = figure;

dB_values = [5 7.5 10 12.5 15 20 25 30];

% real, imbalance, compansated
qam4 = [20.32 6.19 0.756	0 0	0	0	0;
    25.2 10.2	2.872 0.4	0.1 0	0	0;
    16.062	3.6 0.376 0.1	0 	0	0	0];

qam16 = [21.03 4.4 0.662 0	 0	0	0	0;
    25.544	10 2.992 0.4	0.008	0	0	0;
    16.332	3.5 0.35 0	0	0	0	0];

psk4 = [18.65	8.3 2.58 0.4	0.01	0	0	0;
    13.254	5.1 1.256 0.1	0.008	0	0	0;
    14.174	5.1 1.372 0.1 0.008	0	0	0];

psk16 = [72.21	66.1 53.7 40.6	27.56	5.24	0.06	0;
    73.1	65.4 58.128	53.6 47.688	43.748	34.5	31.75;
    70.25	59.8 47.35	36.2 20.312	2.368	0	0];

psk64 = [93.02	90.7 87.71 83.4	78.56	62.5	38.39	12.56;
    92.856	91.8 90.1 84.1	83.69	84.258	94.32	99.758;
    91.49	90 88.3 79.7	72.908	53.888	27.664	5.534];

qam4 = qam4/100;
qam16 = qam16/100;
psk4 = psk4/100;
psk16 = psk16/100;
psk64 = psk64/100;

figure (f1);
semilogy(dB_values,qam4(1,:),'r*-');
hold on
semilogy(dB_values,qam4(2,:),'g*-');
semilogy(dB_values,qam4(3,:),'b*-');
title("4 QAM")
legend('4 QAM + AWGN','IQ + AWGN','IQ Comp.')
xlabel('SNR(dB)')
ylabel('SER')
hold off

figure (f2);
semilogy(dB_values,qam16(1,:),'r*-');
hold on
semilogy(dB_values,qam16(2,:),'g*-');
semilogy(dB_values,qam16(3,:),'b*-');
title("16 QAM")
legend('4 QAM + AWGN','IQ + AWGN','IQ Comp.')
xlabel('SNR(dB)')
ylabel('SER')
hold off

figure (f3);
semilogy(dB_values,psk4(1,:),'r*-');
hold on
semilogy(dB_values,psk4(2,:),'g*-');
semilogy(dB_values,psk4(3,:),'b*-');
title("QPSK")
legend('4 QAM + AWGN','IQ + AWGN','IQ Comp.')
xlabel('SNR(dB)')
ylabel('SER')
hold off

figure (f4);
semilogy(dB_values,psk16(1,:),'r*-');
hold on
semilogy(dB_values,psk16(2,:),'g*-');
semilogy(dB_values,psk16(3,:),'b*-');
title("16 PSK")
legend('4 QAM + AWGN','IQ + AWGN','IQ Comp.')
xlabel('SNR(dB)')
ylabel('SER')
hold off

figure (f5);
semilogy(dB_values,psk64(1,:),'r*-');
hold on
semilogy(dB_values,psk64(2,:),'g*-');
semilogy(dB_values,psk64(3,:),'b*-');
title("64 PSK")
legend('4 QAM + AWGN','IQ + AWGN','IQ Comp.')
xlabel('SNR(dB)')
ylabel('SER')
hold off

figure (f6);
semilogy(dB_values,qam4(2,:),'r*-');
hold on
semilogy(dB_values,qam16(2,:),'g*-');
semilogy(dB_values,psk4(2,:),'b*-');
semilogy(dB_values,psk16(2,:),'c*-');
semilogy(dB_values,psk64(2,:),'m*-');
title("IQ IMBALANCE COMPARISON")
legend('4 QAM','16 QAM','QPSK', '16 PSK', '64 PSK');
xlabel('SNR(dB)')
ylabel('SER')
hold off

figure (f7);
semilogy(dB_values,qam4(3,:),'r*-');
hold on
semilogy(dB_values,qam16(3,:),'g*-');
semilogy(dB_values,psk4(3,:),'b*-');
semilogy(dB_values,psk16(3,:),'c*-');
semilogy(dB_values,psk64(3,:),'m*-');
title("IQ COMPANSATED MODULATIONS COMPARISON")
legend('4 QAM','16 QAM','QPSK', '16 PSK', '64 PSK');
xlabel('SNR(dB)')
ylabel('SER')
hold off




