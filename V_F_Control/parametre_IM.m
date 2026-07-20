
clc;
clear;
ClarkConcordia=sqrt(3/2)*[1 -1/2 -1/2; 0 sqrt(3)/2 -sqrt(3)/2; 1/sqrt(2) 1/sqrt(2) 1/sqrt(2)];

Vs=220;

Rr=1.8;
J=0.07;
f=0;
p=2;
Rs=1.8;
M=0.15;
Ls=0.1554;
Lr=0.1568;

sigma=1-(M^2)/(Ls*Lr);
Tr=Lr/Rr;
Ts=Ls/Rs;

a1=-(1/(Ts*sigma)+(1-sigma)/(Tr*sigma));
a2=(1-sigma)/(M*Tr*sigma);
a3=M/(sigma*Ls*Lr);
a4=M/Tr;
a5=-1/Tr;

B=[1/(Ls*sigma) 0; 0 1/(Ls*sigma); 0 0; 0 0];
A1=[a1 0 a2 0; 0 a1 0 a2; a4 0 a5 0 ; 0 a4 0 a5];
A2=[0 0 0 a3; 0 0 -a3 0 ; 0 0 0 -1 ; 0 0 1 0];
T=[2/3 -1/3 -1/3; -1/3 2/3 -1/3; -1/3 -1/3 2/3];
fpr=1000;
ctevf=240/(2*pi*50);

