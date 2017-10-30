pd=makedist('Normal');
t=truncate(pd,-7,7);
X=random(t,1,10^6);
%X=linspace(-7,7,10^6);
Y=normpdf(X);
N=128;%64,128,256
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for n=1:(10^6)
    Xsquare(n)=(X(n).^2);
end
squaresum=sum(Xsquare);
SourcePower=squaresum/10^6;
%m=mean(X);

L=linspace(-7,7,N-1);
delta=L(2)-L(1);
for i=1:N
    for i=1:(N-1)
        Q(i)=L(i)-(delta/2);
    end
    Q(64)=7+(delta/2);
end

for n=1:(10^6)
    for i=2:(N-1)
        if X(n)>=L(i-1)&&X(n)<=L(i)
            quantizedX(n)=Q(i);
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for n=1:(10^6)
    QuantizationErrors(n)=X(n)-quantizedX(n);
end

hist(QuantizationErrors/norm(QuantizationErrors));

ExpectationXsquare=SourcePower;
MSE=mean(QuantizationErrors.^2);
SQNR=ExpectationXsquare/MSE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
comp_mu=compand(X,255,max(X),'mu/compressor');
for n=1:(10^6)
    for i=2:(N-1)
        if comp_mu(n)>=L(i-1)&&comp_mu(n)<=L(i)
            nuquantizedX_mu(n)=Q(i);
        end
    end
end
pand_mu=compand(nuquantizedX_mu,255,max(nuquantizedX_mu),'mu/expander');

for n=1:(10^6)
    nuQuantizationErrors_mu(n)=X(n)-pand_mu(n);
end

%hold on
hist(nuQuantizationErrors_mu/norm(nuQuantizationErrors_mu));

%ExpectationXsquare=sum(Xsquare.*Y);
nuMSE_mu=mean(nuQuantizationErrors_mu.^2);
nuSQNR_mu=ExpectationXsquare/nuMSE_mu
nuSQNR_mu_dB=10*log10(nuSQNR_mu)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
comp_A=compand(X,87.6,max(X),'A/compressor');
for n=1:(10^6)
    for i=2:(N-1)
        if comp_A(n)>=L(i-1)&&comp_A(n)<=L(i)
            nuquantizedX_A(n)=Q(i);
        end
    end
end
pand_A=compand(nuquantizedX_A,87.6,max(nuquantizedX_A),'A/expander');

for n=1:(10^6)
    nuQuantizationErrors_A(n)=X(n)-pand_A(n);
end

%hold on
hist(nuQuantizationErrors_A/norm(nuQuantizationErrors_A));

%ExpectationXsquare=sum(Xsquare.*Y);
nuMSE_A=mean(nuQuantizationErrors_A.^2);
nuSQNR_A=ExpectationXsquare/nuMSE_A
nuSQNR_A_dB=10*log10(nuSQNR_A)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
comp_mu1=compand(X,1,max(X),'mu/compressor');
for n=1:(10^6)
    for i=2:(N-1)
        if comp_mu1(n)>=L(i-1)&&comp_mu1(n)<=L(i)
            nuquantizedX_mu1(n)=Q(i);
        end
    end
end
pand_mu1=compand(nuquantizedX_mu1,1,max(nuquantizedX_mu1),'mu/expander');

for n=1:(10^6)
    nuQuantizationErrors_mu1(n)=X(n)-pand_mu1(n);
end

%hold on
hist(nuQuantizationErrors_mu1/norm(nuQuantizationErrors_mu1));

%ExpectationXsquare=sum(Xsquare.*Y);
nuMSE_mu1=mean(nuQuantizationErrors_mu1.^2);
nuSQNR_mu1=ExpectationXsquare/nuMSE_mu1
nuSQNR_mu1_dB=10*log10(nuSQNR_mu1)