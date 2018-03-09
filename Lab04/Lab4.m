%MULTIMEDIA COMMUNICATION SERVICES
%Multimedia information coding and description
%LAB 4

clear all;
close all;
clc;

if 1==0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1)IMAGE SAMPLING

%Create and display the square
A=ones(576,576);
ft=round(length(A)/3);
A(ft:end-ft+1,ft:end-ft+1)=0;
R=fftshift(fftn(A));

% figure;
% subplot(1,2,1); imshow(A); title('Square');
% subplot(1,2,2); imshow(abs(R)/256); title('Module');

%Subsample the square by a factor 4 in the vertical direction and display it
A1=ones(576,576);
ft=round(length(A1)/3);
A1(ft:4:end-ft+1,ft:end-ft+1)=0;
R11=fftshift(fftn(A1));

% figure;
% imshow(abs(R11)/256); title('2-D fft of the square subsampled in the vertical direction');

%Subsample the square by a factor 4 in both directions and display it
B=ones(576,576);
ft=round(length(B)/3);
B(ft:4:end-ft+1,ft:4:end-ft+1)=0;
R1=fftshift(fftn(B));

% figure;
% subplot(1,2,1); imshow(abs(R)/256); title('2-D fft of the square');
% subplot(1,2,2); imshow(abs(R1)/256); title('2-D fft of the subsampled square');

%Quincunx sampling
C=ones(576,576);
ft=round(length(A)/3);
% C(ft:2:end-ft+1,ft+1:2:end-ft+1)=0;
% C(ft+1:2:end-ft+1,ft:2:end-ft+1)=0;
C(ft:4:end-ft+1,ft+2:4:end-ft+1)=0;
C(ft+2:4:end-ft+1,ft:4:end-ft+1)=0;
Q=fftshift(fftn(C));

% figure;
% subplot(1,2,1); imshow(C); title('Square');
% subplot(1,2,2); imshow(abs(Q)/256); title('Module');

%Repeat the experiment with different signals
[x y]=ndgrid(-6:0.01:6);
ft=round(length(x)/3);
s=cos(2*pi*(x+y))*cos(2*pi*(x+y));
s(1:ft,1:end)=256;
s(end-ft+1:end,1:end)=256;
s(1:end,1:ft)=256;
s(1:end,end-ft+1:end)=256;
S=fftshift(fftn(s));

% figure; 
% subplot(1,2,1); imshow(s/256); title('Signal in space'); shading('interp');
% subplot(1,2,2); imshow(abs(S)/256); title('2-D Fourier Transform'); shading('interp');
end

if 1==1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2)VIDEO SAMPLING

[x y]=ndgrid(-6:0.05:6);
%x1=x(:,1)';
%x2=y(1,:);
Dt=0.01;

vy=1;
vy1=100;
time=10;
f=zeros(length(x),time,length(y));
f1=zeros(length(x),time,length(y));

for j=1:time
    r=sin(2*pi*(y+vy*j*Dt));
    r1=sin(2*pi*(y+vy1*j*Dt));
    f(:,j,:)=r;
    f1(:,j,:)=r1;
end

% %I compute the transform of the entire video
% F=fftshift(fftn(f));
% F1=fftshift(fftn(f1));
% 
% %First velocity, i display the first frame
% figure;
% subplot(1,2,1); surf(f(:,:,1)); shading('interp');
% subplot(1,2,2); surf(abs(F(:,:,1))); shading('interp');
% 
% %First velocity, i display the last frame
% figure;
% subplot(1,2,1); surf(f(:,:,time)); shading('interp');
% subplot(1,2,2); surf(abs(F(:,:,time))); shading('interp');
% 
% %Second velocity, i display the first frame
% figure;
% subplot(1,2,1); surf(f(:,:,1)); shading('interp');
% subplot(1,2,2); surf(abs(F(:,:,1))); shading('interp');
% 
% %Second velocity, i display the last frame
% figure;
% subplot(1,2,1); surf(f1(:,:,time)); shading('interp');
% subplot(1,2,2); surf(abs(F1(:,:,time))); shading('interp');

%Subsampling the signal by a factor 4 in the time domain
fs=f;
for j=1:time
    fs(1:4:end,1:4:end,j)=0;
end

Fs=fftshift(fftn(fs));

% %First velocity subsampled, i display the first frame
% figure;
% subplot(1,2,1); surf(fs(:,:,1)); shading('interp');
% subplot(1,2,2); surf(abs(Fs(:,:,1))); shading('interp');
% 
% %Second velocity subsampled, i display the last frame
% figure;
% subplot(1,2,1); surf(fs(:,:,time)); shading('interp');
% subplot(1,2,2); surf(abs(Fs(:,:,time))); shading('interp');

%Subsample the signal with an interlaced strategy
fint=f;
for j=1:time
    if mod(j,2)==0
        fint(2:2:end,1:end)=0; %Even frame
    if mod(j,2)~=0
        fint(1:2:end,1:end)=0; %Odd frame
    end
    end
end

Fint=fftshift(fftn(fint));

% %First velocity interlaced, i display the first frame
% figure;
% subplot(1,2,1); surf(fint(:,:,1)); shading('interp');
% subplot(1,2,2); surf(abs(Fint(:,:,1))); shading('interp');
% 
% %Second velocity interlaced, i display the last frame
% figure;
% subplot(1,2,1); surf(fint(:,:,time)); shading('interp');
% subplot(1,2,2); surf(abs(Fint(:,:,time))); shading('interp');
end