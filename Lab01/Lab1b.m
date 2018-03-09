%MULTIMEDIA COMMUNICATION SERVICES
%Multimedia information coding and description
%LAB 1b

clear all;
close all;
clc;
if 1==0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1)

dimx=0:0.01:10;
dimy=0:0.01:10;
[x,y]=ndgrid(dimx,dimy);

picture=sin(2*pi*0.3*1.35.^y.*y).*2.^x;
figure; imshow(picture,[]); title('Contrast Sensitivity Function');

%RGB
red=zeros(length(x),length(y));
red(:,:,1)=picture;
red(:,:,2)=0;
red(:,:,3)=0;

green=zeros(length(x),length(y));
green(:,:,1)=0;
green(:,:,2)=picture;
green(:,:,3)=0;

blue=zeros(length(x),length(y));
blue(:,:,1)=0;
blue(:,:,2)=0;
blue(:,:,3)=picture;

figure;
subplot(1,3,1); imshow(red,[]); title('R');
subplot(1,3,2); imshow(green,[]); title('G');
subplot(1,3,3); imshow(blue,[]); title('B');

%YCbCr
imageconvb=rgb2ycbcr(blue);
Cb=zeros(length(x),length(y));
Cb(:,:,1)=mean(mean(imageconvb(:,:,1)));
Cb(:,:,2)=imageconvb(:,:,2);
Cb(:,:,3)=mean(mean(imageconvb(:,:,3)));
Cb_rgb=ycbcr2rgb(Cb);

imageconvr=rgb2ycbcr(red);
Cr=zeros(length(x),length(y));
Cr(:,:,1)=mean(mean(imageconvr(:,:,1)));
Cr(:,:,2)=mean(mean(imageconvr(:,:,2)));
Cr(:,:,3)=imageconvr(:,:,3);
Cr_rgb=ycbcr2rgb(Cr);

figure;
subplot(1,2,1); imshow(Cb_rgb,[]); title('Cb');
subplot(1,2,2); imshow(Cr_rgb,[]); title('Cr');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2)
if 1==0
f=1:100;
dimx=0:0.01:5;
dimy=0:0.01:5;
[x,y]=ndgrid(dimx,dimy);

for i=1:length(f)
    A=sin(2*pi*i*1.35.^y.*y).*2.^x;
    A=A/max(max(A))*255;
    imshow(A,[]);
    M(i)=im2frame(uint8(A),gray(256));
end
movie(M);
end