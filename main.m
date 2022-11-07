
% teste: sinal aleatório + sen(2*pi*10*t) + sen(2*pi*25*t)
% com fs=512 e N=2,4,8,16,32,64,128,256,512,1024 e 2048)
clc
clear all
close all

 N=2048; %AQUI VARIA-SE O N DESEJADO
 fs =512; 
 T = 0: 1 /fs :((N/fs)-(1/fs ));
 ws = 0:fs/N:fs-(fs/N);
 x = randn (1,N);
 x1 = sin(2*pi*10*T);
 x2 = sin(2*pi*25*T);
 X = x + x1 +x2;

%1) plot sinal X no tempo

figure()
plot(T,X)
title('Sinal de entrada no tempo')
xlabel('Tempo')
ylabel('Amplitude')


%2) Implementacao com FFT nativa matlab:

 tic % contagem de tempo para execucao da FFT nativa
 Y1 = fft(X,N);
 mag1= abs(Y1);
 timeFFT = toc;
 angle1= unwrap(angle(Y1));
 
 %3)Implementacao usando MyDFT:
 
 tic
 [dft_x,t]= MyDFT(X);
 mag2= abs(dft_x);
 timeMyDFT= toc;
 angle2= unwrap(angle(dft_x));
 
 %4)Implementacao usando MyFFT_DecTempo:
 
 tic
 [FFT_X]=MyFFT_DecTempo(X);
 mag3= abs(FFT_X);
 timeMyFFT=toc;
 angle3= unwrap(angle(FFT_X));
 
 %5)Plotagem das magnitudes para comparacao:
 
 figure()
 subplot(3,1,1)
 plot(ws,mag1,'b')
 title('Magnitude da FFT nativa do MatLab')
 xlabel('Frequência(Hz)')
 ylabel('Amplitude')
 
subplot(3,1,2)
plot(ws,mag2,'r')
title('Magnitude MyDFY')
xlabel('Frequência(Hz)')
ylabel('Amplitude')

subplot(3,1,3)
plot(ws,mag3,'g')
title('Magnitude MyFFTDecTempo')
xlabel('Frequência(Hz)')
ylabel('Amplitude')


%6)Comparacao das magnitudes das funcoes juntas:
    
 figure()
 plot(ws,mag1,'b')
 hold on
 plot(ws,mag2,'r')
 hold on
 plot(ws,mag3,'g')
 title('Comparacao das magnitudes de cada funcao')
 xlabel('Frequência(Hz)')
 ylabel('Amplitude')
 legend('FFT MatLab', 'MyDFT', 'MyFFTDecTempo')
 
 
 %7)Plot das fases separadas:
 
figure()
subplot(3,1,1)
plot(ws,angle1,'b')
title('Fase da FFT nativa do MatLab')
xlabel('Frequência(Hz)')
ylabel('Fase')
 
subplot(3,1,2)
plot(ws,angle2,'r')
title('Fase MyDFY')
xlabel('Frequência(Hz)')
ylabel('Fase')

subplot(3,1,3)
plot(ws,angle3,'g')
title('Fase MyFFTDecTempo')
xlabel('Frequência(Hz)')
ylabel('Fase')

%8)Comparacao das fases juntas:

figure()
plot(ws,angle1,'b')
hold on
plot(ws,angle2,'r')
hold on
plot(ws,angle3,'g')
title('Comparacao das fases de cada funcao')
xlabel('Frequência(Hz)')
ylabel('Fase')
legend('FFT MatLab', 'MyDFT', 'MyFFTDecTempo')

%9)Comparacao via erro:
% magnitude
erro1M=immse(mag1,mag2);
erro2M=immse(mag1,mag3);
erro3M=immse(mag2,mag3);
disp(erro1M)
disp(erro2M)
disp(erro3M)


%fase
erro1F=immse(angle1,angle2);
erro2F=immse(angle1,angle3);
erro3F=immse(angle2,angle3);
disp(erro1F)
disp(erro2F)
disp(erro3F)
