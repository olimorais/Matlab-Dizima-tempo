function [FFT_X]=MyFFT_DecTempo(x)

%Verifica se o sinal de entrada é um vetor linha:
tam1=size(x);
if tam1(1,1)>tam1(1,2) %Se for maior é um vetor coluna
    x=x'; %Transposição
end

%Garantir que o comprimento do vetor de entrada seja potência de 2
N=length(x); %N recebe o tamanho do sinal de entrada
vet=log2(N); % v recebe o log(N) na base 2
vet=ceil(vet); %Funcao ceil arrendonda o número para o inteiro mais próximo
aux=2^vet; %Variável auxiliar para computar 2^v

if N~=aux %Se o tamanho do vetor não é potência de 2, deve portanto ser completado com zeros
    aux=aux-N;
    x=[x zeros(1,aux)]; 
end

n=length(x); %Armazena o tamanho do vetor x após verificar se o tamanho é potência de 2
Wn=exp((2*pi*1i)/n); %Armazena a exponecial complexa
w=1; %A variável que armazenará os valores multiplicados de Wn

if n==1 %Condição de parada para a recursão, n=1 significa que o vetor x só tem um elemento e o cálculo terminou
    FFT_X=x;
else %Realizará o cálculo novamente até o vetor x tiver 1 elemento
    %% Separa em dois vetores par ou ímpar
    x1_par=zeros(1,length(x)/2);  %Armazena as posicoes pares de x
    x1_impar=zeros(1,length(x)/2); %Armazena as posicoes ímpares de x
    
    cont1=1; %Contador para incrementar a posicao  do vetor par
    cont2=1; %Contador para incrementar a posicao do vetor impar
    
    for a=1:1:length(x) %Separacao de posicoes pares e ímpares
        if mod(a,2)==0   %Se o resto da divisao da posição por 2 for zero a posicao é par
            x1_par(1,cont1)=x(1,a); %Os valores pares são armazenados no vetor par
            cont1=cont1+1; %Incrementa o contador
        else  %Caso contrario a posicao e impar
            x1_impar(1,cont2)=x(1,a);  %Os valores impares sao armazenados no vetor impar
            cont2=cont2+1; %Incrementa o contador
        end
    end
    
    y_par=MyFFT_DecTempo(x1_par); %Realiza a recursao do algoritmo para o vetor par subdividindo as operacoes
    y_impar=MyFFT_DecTempo(x1_impar); %Realiza a recursao do algoritmo para o vetor impar subdividindo as operacoes
    
    
    for k=0:1:((n/2)-1) %Usa do conceito de simetria para preencher o vetor frequencia
        FFT_X(1,(k+1))=y_par(1,k+1)+w*y_impar(1,k+1); %Faz o preenchimento da metade inferior da matriz de frequencia
        FFT_X(1,((k+1)+n/2))=y_par(1,k+1)-w*y_impar(1,k+1); %Faz o preenchimento da metade superior da matriz de frequencia
        w=w*Wn; %Faz o armazenamento dos valores de Wn a cada operacao
    end
end
