clc;
clear all;
r=0.002;
Xe=-1.242345194702115;
C=0;
a=1;
b=3.0;
d=5;
s=4;

A=[-3*a*Xe*Xe+2*b*Xe+2*C 1 -1;
    -2*d*Xe -1 0;
  s*r 0 -r];
[V,D]=eig(A) 