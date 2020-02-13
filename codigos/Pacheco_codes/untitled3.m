%function ant_mab2
clc
close all
clear all

%[t,Y]=FDE_PI12_PC([0.99 0.99 0.99],@ussyshid,0,1000,[0.1,0.1,5.19]',0.01);
[t,Y]=FDE_PI12_PC([0.8],@ussyshid,0,2.5,[0.1]',0.00001);
%%[t,Y]=FDE_PI12_PC(fractional-order,function,t1,t2,initial
%%conditions,integration step)


l=length(Y(1,:));
ti(1)=0;
for ii=1:l-1
    ti(ii+1)=ti(ii)+0.00001;
end
 in=ceil((l-1)*0.9);

figure(1)
%plot3(((Y(1,in:l))),((Y(2,in:l))),((Y(3,in:l))),'blue')
%plot(((Y(1,in:l))), ((Y(3,in:l))),'red')
plot(t,Y)
%xlabel('x');
%ylabel('z');

for i=1:l-1
%a=-0.2;
%b=0.01;
Omega=1250;
A=0.6;
U(i)=A*sin(Omega*ti(i));
res(i)=-1*(1-Y(i))*U(i);
end

figure(2)
plot(res)

figure(3)
plot(U(in:l-1),res(in:l-1))


%%
function f=ussyshid(t,x)
%  a=0.35;
f=zeros(1,1);

Omega=1250;
%f=0.1;
A=0.6;

U=A*sin(Omega*t);
%U=A*sin(2*3.1416*f*t);
%x(1);
f(1) = 60*U;




end

