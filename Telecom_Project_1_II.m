%recObj=audiorecorder(20*10^3,8,1);%20kHz>16kHz
%recordblocking(recObj,50);
Y=getaudiodata(recObj);
Y=transpose(Y);
plot(Y);
normalizedY=Y/norm(Y);
%Y=normalizedY;
hist(normalizedY);
N=64;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for n=1:(10^6)
    Ysquare(n)=(Y(n).^2);
end
squaresum=sum(Ysquare);
SourcePower=squaresum/10^6;
%m=mean(Y.^2);

L=linspace(-1,1,N-1);
delta=L(2)-L(1);
for i=1:N
    for i=1:(N-1)
        Q(i)=L(i)-(delta/2);
    end
    Q(64)=1+(delta/2);
end

for n=1:(10^6)
    for i=2:(N-1)
        if Y(n)>=L(i-1)&&Y(n)<L(i)
            quantizedY(n)=Q(i);
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for n=1:(10^6)
    QuantizationErrors(n)=Y(n)-quantizedY(n);
end

hist(QuantizationErrors/norm(QuantizationErrors));

ExpectationYsquare=SourcePower;
MSE=mean(QuantizationErrors.^2);
SQNR=ExpectationYsquare/MSE
SQNR_dB=10*log10(SQNR)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
comp_mu=compand(Y,255,max(Y),'mu/compressor');
for n=1:(10^6)
    for i=2:(N-1)
        if comp_mu(n)>=L(i-1)&&comp_mu(n)<=L(i)
            nuquantizedY_mu(n)=Q(i);
        end
    end
end
pand_mu=compand(nuquantizedY_mu,255,max(nuquantizedY_mu),'mu/expander');

for n=1:(10^6)
    nuQuantizationErrors_mu(n)=Y(n)-pand_mu(n);
end

%hold on
hist(nuQuantizationErrors_mu/norm(nuQuantizationErrors_mu));

%ExpectationYsquare=sum(Ysquare.*normpdf(Y));
nuMSE_mu=mean(nuQuantizationErrors_mu.^2);
nuSQNR_mu=ExpectationYsquare/nuMSE_mu
nuSQNR_mu_dB=10*log10(nuSQNR_mu)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
comp_mu1=compand(Y,1,max(Y),'mu/compressor');
for n=1:(10^6)
    for i=2:(N-1)
        if comp_mu1(n)>=L(i-1)&&comp_mu1(n)<=L(i)
            nuquantizedY_mu1(n)=Q(i);
        end
    end
end
pand_mu1=compand(nuquantizedY_mu1,1,max(nuquantizedY_mu1),'mu/expander');

for n=1:(10^6)
    nuQuantizationErrors_mu1(n)=Y(n)-pand_mu1(n);
end

%hold on
hist(nuQuantizationErrors_mu1/norm(nuQuantizationErrors_mu1));

%ExpectationYsquare=sum(Ysquare.*normpdf(Y));
nuMSE_mu1=mean(nuQuantizationErrors_mu1.^2);
nuSQNR_mu1=ExpectationYsquare/nuMSE_mu1
nuSQNR_mu1_dB=10*log10(nuSQNR_mu1)