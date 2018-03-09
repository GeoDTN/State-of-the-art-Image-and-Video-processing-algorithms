function [S] = MCS_FT2(s,x1,x2,f1,f2)
dx1=x1(2)-x1(1);
dx2=x2(2)-x2(1);
w1=exp(-1i*2*pi*x1'*f1)*dx1;
w2=exp(-1i*2*pi*x2'*f2)*dx2;
S=w2.'*s*w1;
end