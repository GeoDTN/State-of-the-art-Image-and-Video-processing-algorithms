%MULTIMEDIA COMMUNICATION SERVICES
%Multimedia information coding and description
%LAB 2

clear all;
close all;
clc;

%1)

dt=0.01;
x1=-5:dt:5;
x2=-5:dt:5;

f1=-1/2:0.001:1/2;
f2=-1/2:0.001:1/2;

s=zeros(size(x1));
  for i=1:length(x2)
     s(i,:)=sin(2*pi*20*x1);
  end

S=MCS_FT2(s,x1,x2,f1,f2);
figure; surf(f1,f2,abs(S)); shading('interp'); title('Test of the 2D Fourier Transform');


% 2)

%Axes
[x y]=ndgrid(-6:0.01:6);
[fx fy]=ndgrid(-4:0.01:4);
x1=x(:,1)';
x2=y(1,:);
f1=fx(:,1)';
f2=fy(1,:);

%Signals
s1=rect(x)*rect(y);
s2=rect(x/2)*rect(y);
s3=rect(x/2)*rect(y-x/4);
s4=sin(pi*x);
s5=sin(pi*y);
s6=sin(pi*x-2*pi*y);

S1=MCS_FT2(s1,x1,x2,f1,f2);
S2=MCS_FT2(s2,x1,x2,f1,f2);
S3=MCS_FT2(s3,x1,x2,f1,f2);
S4=MCS_FT2(s4,x1,x2,f1,f2);
S5=MCS_FT2(s5,x1,x2,f1,f2);
S6=MCS_FT2(s6,x1,x2,f1,f2);

figure;
subplot(1,2,1); surf(x1,x2,s1); shading('interp'); xlabel('x1'); ylabel('x2'); title('s1(x1,x2)');
subplot(1,2,2); surf(f1,f2,abs(S1)); shading('interp'); xlabel('f1'); ylabel('f2'); title('|S1(f1,f2)|');

figure;
subplot(1,2,1); surf(x1,x2,s2); shading('interp'); xlabel('x1'); ylabel('x2'); title('s2(x1,x2)');
subplot(1,2,2); surf(f1,f2,abs(S2)); shading('interp'); xlabel('f1'); ylabel('f2'); title('|S2(f1,f2)|');

figure;
subplot(1,2,1); surf(x1,x2,s3); shading('interp'); xlabel('x1'); ylabel('x2'); title('s3(x1,x2)');
subplot(1,2,2); surf(f1,f2,abs(S3)); shading('interp'); xlabel('f1'); ylabel('f2'); title('|S3(f1,f2)|');

figure;
subplot(1,2,1); surf(x1,x2,s4); shading('interp'); xlabel('x1'); ylabel('x2'); title('s4(x1,x2)');
subplot(1,2,2); surf(f1,f2,abs(S4)); shading('interp'); xlabel('f1'); ylabel('f2'); title('|S4(f1,f2)|');

figure;
subplot(1,2,1); surf(x1,x2,s5); shading('interp'); xlabel('x1'); ylabel('x2'); title('s5(x1,x2)');
subplot(1,2,2); surf(f1,f2,abs(S5)); shading('interp'); xlabel('f1'); ylabel('f2'); title('|S5(f1,f2)|');

figure;
subplot(1,2,1); surf(x1,x2,s6); shading('interp'); xlabel('x1'); ylabel('x2'); title('s6(x1,x2)');
subplot(1,2,2); surf(f1,f2,abs(S6)); shading('interp'); xlabel('f1'); ylabel('f2'); title('|S6(f1,f2)|');


% 3)

im1=imread('goldhill2.jpg');
im1=rgb2ycbcr(im1);
Y1=double(im1(:,:,1));

k=size(im1);
x1=0:k(2)-1;
x2=0:k(1)-1;
f1=-1/2:0.001:1/2;
f2=-1/2:0.001:1/2;

IM1=MCS_FT2(Y1,x1,x2,f1,f2);

figure; 
subplot(1,2,1); imshow(log(abs(IM1)),[]); shading('interp'); title('Module of a natural image');
subplot(1,2,2); imshow(angle(IM1),[]); shading('interp'); title('Phase of a natural image');

im2=imread('Rete.jpg');
im2=rgb2ycbcr(im2);
Y2=double(im2(:,:,1));

k=size(im2);
x1=0:k(2)-1;
x2=0:k(1)-1;
dt=0.01;
f1=-1/2:0.001:1/2;
f2=-1/2:0.001:1/2;

IM2=MCS_FT2(Y2,x1,x2,f1,f2);
figure;
subplot(1,2,1); imshow(log(abs(IM2)),[]); shading('interp'); title('Module of a periodic pattern image');
subplot(1,2,2); imshow(angle(IM2),[]); shading('interp'); title('Phase of a periodic pattern image');

