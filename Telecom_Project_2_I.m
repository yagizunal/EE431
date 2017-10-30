%%
M=2;
x_binary=randi([0 M-1],10^5,1);
for i=1:10^5
    if x_binary(i)==0
        y_binary(i)=-1;
    else
        y_binary(i)=1;
    end
end
%y_binary=-1*pskmod(x_binary,M);
power_binary=1/M*sum((-1)^2+(1)^2);
SNR_binary_dB=9;%2%9
SNR_binary=10^(SNR_binary_dB/10);
SNR_binary_bit=SNR_binary/log2(M);
N0=power_binary/SNR_binary_bit;
%y_binary_noisy=awgn(y_binary,SNR_binary_dB);
for i=1:10^5
    y_binary_noisy(i)=y_binary(i)+randn(1)*sqrt(N0/2);
end

number_of_error_binary=0;
for i=1:10^5
    if real(y_binary_noisy(i))<0
        m_hat_binary(i)=0;
    else
        m_hat_binary(i)=1;
    end
    if x_binary(i)~=m_hat_binary(i)
        number_of_error_binary=number_of_error_binary+1;
    end
end

P_error_binary=number_of_error_binary/10^5;

P_error_binary_theo=1/2*erfc(sqrt(2*SNR_binary_bit)/sqrt(2));
%%
M=2;
x_onoff=randi([0 M-1],10^5,1);
y_onoff=x_onoff;
power_onoff=1/M*sum((0)^2+(1)^2);
SNR_onoff_dB=12;%5%12
SNR_onoff=10^(SNR_onoff_dB/10);
SNR_onoff_bit=SNR_onoff/log2(M);
N0=power_onoff/SNR_onoff_bit;
%y_onoff_noisy=awgn(y_onoff,SNR_onoff_dB);
for i=1:10^5
    y_onoff_noisy(i)=y_onoff(i)+randn(1)*sqrt(N0/2);
end

number_of_error_onoff=0;
for i=1:10^5
    if real(y_onoff_noisy(i))<0.5
        m_hat_onoff(i)=0;
    else
        m_hat_onoff(i)=1;
    end
    if x_onoff(i)~=m_hat_onoff(i)
        number_of_error_onoff=number_of_error_onoff+1;
    end
end

P_error_onoff=number_of_error_onoff/10^5;

P_error_onoff_theo=1/2*erfc(sqrt(SNR_onoff_bit)/sqrt(2));
%%
M=16;%4%8%16
x_PAM=randi([0 M-1],10^5,1);
for i=1:10^5
    for m=x_PAM(i)
        y_PAM(i)=2*m-M+1;
    end
end
%y_PAM=pammod(x_PAM,M);
s=0;
for i=1:M
    s=s+(2*(i-1)-M+1)^2;
end
power_PAM=1/M*s;
if M==4
    SNR_PAM_dB=13;%5%13
elseif M==8
    SNR_PAM_dB=17;%8%17
elseif M==16
    SNR_PAM_dB=22;%10%22
end
SNR_PAM=10^(SNR_PAM_dB/10);
SNR_PAM_bit=SNR_PAM/log2(M);
N0=power_PAM/SNR_PAM;
%y_PAM_noisy=awgn(y_PAM,SNR_PAM_dB);
for i=1:10^5
    y_PAM_noisy(i)=y_PAM(i)+randn(1)*sqrt(N0/2);
end

number_of_error_PAM=0;

for i=1:10^5
    for m=1:M-2
        if real(y_PAM_noisy(i))<-(M-2)
            m_hat_PAM(i)=0;
        elseif real(y_PAM_noisy(i))>=(2*m-M) && real(y_PAM_noisy(i))<(2*m-M+2)
            m_hat_PAM(i)=m;
        elseif real(y_PAM_noisy(i))>=(M-2)
            m_hat_PAM(i)=M-1;
%         else
%             number_of_error_PAM=number_of_error_PAM+1;
        end
    end
end
        
for i=1:10^5
    if x_PAM(i)~=m_hat_PAM(i)
        number_of_error_PAM=number_of_error_PAM+1;
    end
end

P_error_PAM=number_of_error_PAM/10^5;

P_error_PAM_theo=(2*(M-1)/M)*1/2*erfc(sqrt(6*log2(M)/(M^2-1)*SNR_PAM_bit)/sqrt(2));
%%
M=8;%4%8
x_PSK=randi([0 M-1],10^5,1);
for i=1:10^5
    for m=x_PSK(i)
        y_PSK1(i)=cos(2*pi/M*m);
        y_PSK2(i)=sin(2*pi/M*m);
    end
end
s=0;
for i=1:M
    s=s+(cos(2*pi/M*(i-1)))^2+(sin(2*pi/M*(i-1)))^2;
end
power_PSK=1/M*s;
SNR_PSK_dB=10;
SNR_PSK=10^(SNR_PSK_dB/10);
SNR_PSK_bit=SNR_PSK/log2(M);
N0=power_PSK/SNR_PSK;
%y_PSK_noisy=awgn(y_PSK,SNR_PSK_dB);
for i=1:10^5
    y_PSK1_noisy(i)=y_PSK1(i)+randn(1)*sqrt(N0/2);
    y_PSK2_noisy(i)=y_PSK2(i)+randn(1)*sqrt(N0/2);
end
% for i=1:10^5
%     y_PSK(i)=x_PSK(i)+randn(1)*sqrt(N0/2);
%     for m=x_PSK(i)
%         y_PSK1_noisy(i)=cos(2*pi/M*y_PSK(i));
%         y_PSK2_noisy(i)=sin(2*pi/M*y_PSK(i));
%     end
% end

for i=1:10^5
    arc(i)=atan2(y_PSK2_noisy(i),y_PSK1_noisy(i));
    if arc(i)<-pi/M
        arcn(i)=arc(i)+2*pi;
    else
        arcn(i)=arc(i);
    end
end

number_of_error_PSK=0;

for i=1:10^5
    for m=1:M
        if real(arcn(i))>pi/M*(2*m-3) && real(arcn(i))<=pi/M*(2*m-1)
        %if real(1+cot(y_PSK2_noisy(i)/y_PSK1_noisy(i)))>pi/M*(2*m-3) && real(1+cot(y_PSK2_noisy(i)/y_PSK1_noisy(i)))<=pi/M*(2*m-1)
            m_hat_PSK(i)=m-1;
%         else
%             number_of_error_PSK=number_of_error_PSK+1;
        end
    end
end

for i=1:10^5
    if x_PSK(i)~=m_hat_PSK(i)
        number_of_error_PSK=number_of_error_PSK+1;
    end
end

P_error_PSK=number_of_error_PSK/10^5;

if M==4
    P_error_PSK_theo=1-(1-1/2*erfc(sqrt(2*SNR_PSK_bit)/sqrt(2)))^2;
    %P_error_PSK_theo=2*1/2*erfc(sqrt(SNR_PSK)/sqrt(2));
    %P_error_PSK_theo=2*1/2*erfc(sqrt(2*SNR_PSK_bit)/sqrt(2));
elseif M==8
    P_error_PSK_theo=2*1/2*erfc(sqrt(2*SNR_PSK)*sin(pi/M)/sqrt(2));
end