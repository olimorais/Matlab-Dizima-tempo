% Implementacao da MyDFT:


function [dft_x,ws]=MyDFT(X)
fs=512;
N = length(X);
v=ceil(log2(N));
if (2^v ~= N)
    X = [X zeros(1,(2^v)-N)];
end

N=length(X);
wn =exp(-1*1j*(2*pi/N));
ws = 0:fs/N:fs-(fs/N);

for k=1:1:N
    soma=0;
    for n=1:1:N
        soma=X(n)*wn^((k-1)*(n-1)) +soma;
    end
    dft_x(k)=soma;
end
 
end