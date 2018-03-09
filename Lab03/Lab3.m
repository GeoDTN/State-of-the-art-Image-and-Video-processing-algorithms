%MULTIMEDIA COMMUNICATION SERVICES
%Multimedia information coding and description
%LAB 3

clear all;
close all;
clc;

if 1==0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1)

%Axes
[x y]=ndgrid(-6:0.01:6);
[fx fy]=ndgrid(-4:0.01:4);
x1=x(:,1)';
x2=y(1,:);
f1=fx(:,1)';
f2=fy(1,:);

%s1
D=1;
s1=rect(x/D)/D;
S1=MCS_FT2(s1,x1,x2,f1,f2);

figure;
subplot(1,2,1); surf(x1,x2,s1); shading('interp'); xlabel('x1'); ylabel('x2'); title('s1(x1,x2)');
subplot(1,2,2); surf(f1,f2,abs(S1)); shading('interp'); xlabel('f2'); ylabel('f1'); title('|S1(f1,f2)|');

%s2
a=3/2;
s2=rect(cos(a*x)+sin(a*y));
S2=MCS_FT2(s2,x1,x2,f1,f2);

figure;
subplot(1,2,1); surf(x1,x2,s2); shading('interp'); xlabel('x1'); ylabel('x2'); title('s2(x1,x2)');
subplot(1,2,2); surf(f1,f2,abs(S2)); shading('interp'); xlabel('f2'); ylabel('f1'); title('|S2(f1,f2)|');

%s3
u=0;
v=0;
s3=exp(-1i*2*pi*(u*x+v*y));
S3=MCS_FT2(s3,x1,x2,f1,f2);

figure;
surf(f1,f2,abs(S3)); shading('interp'); xlabel('f2'); ylabel('f1'); title('|S3(f1,f2)|');

%s4
u=1;
v=1;
s4=cos(2*pi*(u*x+v*y));
S4=MCS_FT2(s4,x1,x2,f1,f2);

figure;
subplot(1,2,1); surf(x1,x2,s4); shading('interp'); xlabel('x1'); ylabel('x2'); title('s4(x1,x2)');
subplot(1,2,2); surf(f1,f2,abs(S4)); shading('interp'); xlabel('f2'); ylabel('f1'); title('|S4(f1,f2)|');

%s5
u1=1;
v1=1;
u2=1;
v2=2;
s5=cos(2*pi*(u1*x+v1*y))*cos(2*pi*(u2*x+v2*y));
S5=MCS_FT2(s5,x1,x2,f1,f2);

figure;
subplot(1,2,1); surf(x1,x2,s5); shading('interp'); xlabel('x1'); ylabel('x2'); title('s5(x1,x2)');
subplot(1,2,2); surf(f1,f2,abs(S5)); shading('interp'); xlabel('f2'); ylabel('f1'); title('|S5(f1,f2)|');

%s6
u=1;
v=1;
s6=exp(-pi*x^2)*cos(2*pi*(u*x+v*y));
S6=MCS_FT2(s6,x1,x2,f1,f2);

figure;
subplot(1,2,1); surf(x1,x2,s6); shading('interp'); xlabel('x1'); ylabel('x2'); title('s6(x1,x2)');
subplot(1,2,2); surf(f1,f2,abs(S6)); shading('interp'); xlabel('f2'); ylabel('f1'); title('|S6(f1,f2)|');
end

if 1==0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2)

%Rect function 2D
Dt=0.1;
[x y]=ndgrid(-15:0.1:15);

%Static video
r=rect(x)*rect(y);
seq=zeros(size(r));
time=10;
for j = 1:time
    seq(:,:,j)=r;
end
R=fftshift(fftn(seq));

% for j=1:time
%     subplot(1,2,1); surf(abs(R(:,:,j))); shading('interp'); xlabel('x1'); ylabel('x2'); title('Module');
%     subplot(1,2,2); surf(angle(R(:,:,j))); shading('interp'); xlabel('f2'); ylabel('f1'); title('Phase');
%     F(j)=getframe;
% end
%movie(F);

%Dynamic video
vx=3;
vy=3;
seq1=zeros(size(r));
for j = 1:time
    r=rect(x-vx*j*Dt)*rect(y-vy*j*Dt);
    seq1(:,:,j)=r;
end
R1=fftshift(fftn(seq1));

for j=1:time
    subplot(1,2,1); surf(abs(R1(:,:,j))); shading('interp'); xlabel('x1'); ylabel('x2'); title('Module');
    subplot(1,2,2); surf(angle(R1(:,:,j))); shading('interp'); xlabel('f2'); ylabel('f1'); title('Phase');
    F1(j)=getframe;
end
movie(F1);
end