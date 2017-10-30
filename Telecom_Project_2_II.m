%%
M=2;
x=randi([0 M-1],10^5,1);
for i=1:10^5
    if x(i)==0
        y(i)=-1;
    elseif x(i)==1
        y(i)=1;
    end
end
power=1/M*sum((-1)^2+(1)^2);
SNR_dB=2;
SNR=10^(SNR_dB/10);
SNR_bit=SNR/log2(M);
N0=power/SNR_bit;

% T=-1:2/10:1;
% w=2;
% pul=tripuls(T,w);
% %plot(T,pul);
pul=0:0.1:0.9;
pul_norm=pul/norm(pul);
matched=pul(end:-1:1);
r=filter(pul_norm,1,upsample(y,10));

for i=1:10^6
    r_noisy(i)=r(i)+randn(1)*sqrt(N0/2);
end

r_n=filter(matched,1,r_noisy);

% for i=1:10^5
%     r_new(i)=r_n(10*i);
% end

number_of_error=0;
for i=1:10^5
    if r_n(10*i)<0
        m_hat(i)=0;
    elseif r_n(10*i)>=0
        m_hat(i)=1;
    end
    if x(i)~=m_hat(i)
        number_of_error=number_of_error+1;
    end
end

P_error=number_of_error/10^5;

P_error_theo=1/2*erfc(sqrt(2*SNR_bit)/sqrt(2));
%%
M=2;
x=randi([0 M-1],10^5,1);
for i=1:10^5
    if x(i)==0
        y(i)=-1;
    elseif x(i)==1
        y(i)=1;
    end
end
power=1/M*sum((-1)^2+(1)^2);
SNR_dB=2;
SNR=10^(SNR_dB/10);
SNR_bit=SNR/log2(M);
N0=power/SNR_bit;

% T=0:2/10:2;
% w=2;
% pul=rectpuls(T,w);
% %stem(T,pul);
pul=ones(1,10);
pul_norm=pul/norm(pul);
matched=pul(end:-1:1);
r=filter(pul_norm,1,upsample(y,10));

for i=1:10^6
    r_noisy(i)=r(i)+randn(1)*sqrt(N0/2);
end

r_n=filter(matched,1,r_noisy);

number_of_error=0;
for i=1:10^5
    if r_n(10*i)<0
        m_hat(i)=0;
    elseif r_n(10*i)>=0
        m_hat(i)=1;
    end
    if x(i)~=m_hat(i)
        number_of_error=number_of_error+1;
    end
end

P_error=number_of_error/10^5;

P_error_theo=1/2*erfc(sqrt(2*SNR_bit)/sqrt(2));
%%
M=2;
x=randi([0 M-1],10^5+5,1);
for i=1:10^5+5
    if x(i)==0
        y(i)=-1;
    elseif x(i)==1
        y(i)=1;
    end
end
power=1/M*sum((-1)^2+(1)^2);
SNR_dB=2;
SNR=10^(SNR_dB/10);
SNR_bit=SNR/log2(M);
N0=power/SNR_bit;

delT=4;%10/10%10/5%2*10/5
% T=-1:delT:1;
% w=2;
% pul=tripuls(T,w);
% %plot(T,pul);
pul=0:0.1:0.9;
pul_norm=pul/norm(pul);
matched=pul(end:-1:1);
r=filter(pul_norm,1,upsample(y,10));

for i=1:10^6+50
    r_noisy(i)=r(i)+randn(1)*sqrt(N0/2);
end

r_n=filter(matched,1,r_noisy);

number_of_error=0;
for i=1:10^5
    if r_n(10*i+delT)<0
        m_hat(i)=0;
    elseif r_n(10*i+delT)>=0
        m_hat(i)=1;
    end
    if x(i)~=m_hat(i)
        number_of_error=number_of_error+1;
    end
end

P_error=number_of_error/(10^5+5);

P_error_theo=1/2*erfc(sqrt(2*SNR_bit)/sqrt(2));