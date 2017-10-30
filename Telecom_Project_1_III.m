pd=makedist('Normal');
t=truncate(pd,-5,5);
X=random(t,1,10);

%fun1=@(v) v.*(normpdf(v)./(0.5/sqrt(2).*erfc(v/sqrt(2))));
fun1=@(v) v.*normpdf(v);
%fun2=@(v) v.*(normpdf(v)./(0.5/sqrt(2).*erf(v/sqrt(2))));
fun2=@(v) v.*normpdf(v);
bound=[-5 5];

for m=1:10
a=linspace(bound(1),bound(2),9);
for i=1:10
    for i=2:5
        x(i)=0.75*(1/((0.5/sqrt(2).*erfc(a(i-1)/sqrt(2)))-(0.5/sqrt(2).*erfc(a(i)/sqrt(2))))).*integral(fun1,a(i-1),a(i));    
    end
    for i=6:9
        x(i)=0.75*(1/((0.5/sqrt(2).*erf(a(i)/sqrt(2)))-(0.5/sqrt(2).*erf(a(i-1)/sqrt(2))))).*integral(fun2,a(i-1),a(i));   
    end
    x(1)=0.75*(1/((0.5/sqrt(2).*erfc(-inf/sqrt(2)))-(0.5/sqrt(2).*erfc(a(1)/sqrt(2))))).*integral(fun1,-inf,a(1));
    x(10)=0.75*(1/((0.5/sqrt(2).*erf(inf/sqrt(2)))-(0.5/sqrt(2).*erf(a(9)/sqrt(2))))).*integral(fun2,a(9),inf);
end
bound(1)=x(2);
bound(2)=x(9);

for n=1:10
for k=2:9
    if X(n)>=a(k-1)&&X(n)<a(k)
        quantizedX(n)=x(k);
    end
end
QuantizationErrors(n)=X(n)-quantizedX(n);
end
D=mean(QuantizationErrors.^2);
if D>0.05
    continue
else
end
end
