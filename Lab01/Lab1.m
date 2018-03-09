%MULTIMEDIA COMMUNICATION SERVICES
%Multimedia Information Coding And Description
%LAB 1

clear all;
close all;
clc;

if 1==0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1)

image=imread('4.2.03.tiff');

%Separate the RGB components
outR=image;
outR(:,:,1)=image(:,:,1);
outR(:,:,2)=0;
outR(:,:,3)=0;

outG=image;
outG(:,:,1)=0;
outG(:,:,2)=image(:,:,2);
outG(:,:,3)=0;

outB=image;
outB(:,:,1)=0;
outB(:,:,2)=0;
outB(:,:,3)=image(:,:,3);

figure;
subplot(1,3,1); imshow(outR,[]); title('RED');
subplot(1,3,2); imshow(outG,[]); title('GREEN');
subplot(1,3,3); imshow(outB,[]); title('BLUE');

%Convert in to YCbCr format
imageconv=rgb2ycbcr(image);

Y=image;
Y(:,:,1)=imageconv(:,:,1);
Y(:,:,2)=mean(mean(imageconv(:,:,2)));
Y(:,:,3)=mean(mean(imageconv(:,:,3)));
Y_rgb=ycbcr2rgb(Y);

Cb=image;
Cb(:,:,1)=mean(mean(imageconv(:,:,1)));
Cb(:,:,2)=imageconv(:,:,2);
Cb(:,:,3)=mean(mean(imageconv(:,:,3)));
Cb_rgb=ycbcr2rgb(Cb);

Cr=image;
Cr(:,:,1)=mean(mean(imageconv(:,:,1)));
Cr(:,:,2)=mean(mean(imageconv(:,:,2)));
Cr(:,:,3)=imageconv(:,:,3);
Cr_rgb=ycbcr2rgb(Cr);

figure;
subplot(1,3,1); imshow(Y_rgb,[]); title('Y');
subplot(1,3,2); imshow(Cb_rgb,[]); title('Cb');
subplot(1,3,3); imshow(Cr_rgb,[]); title('Cr');
end

if 1==0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2)

image=imread('4.2.03.tiff');

%Converting to 4:2:2 YCrCb format (it's automatically filtered) and resize
%the chrominance components

imageconv=rgb2ycbcr(image);
Cb=imresize(imageconv(:,:,2),0.5);
Cr=imresize(imageconv(:,:,3),0.5);

%For the 4:2:0 format i use
%Cb=zeros(size(Cb));
%Cr=zeros(size(Cr));
Cb1=zeros(2*size(Cb));
Cr1=zeros(2*size(Cr));

%Expand to the original dimension the chrominance components
for i=1:length(Cr)
   for k=1:length(Cr)
       Cb1(2*i-1,2*k-1)=Cb(i,k);
       Cr1(2*i-1,2*k-1)=Cr(i,k);
   end
end

%Interpolation filter
filter=[1/4 1/2 1/4; 1/2 1 1/2; 1/4 1/2 1/4];
Cb1=uint8(conv2(Cb1,filter,'same'));
Cr1=uint8(conv2(Cr1,filter,'same'));

%Convert the interpolated Cb and Cr components in to RGB format
y=zeros(length(image),length(image));
y(:,:,1)=imageconv(:,:,1);
y(:,:,2)=mean(mean(imageconv(:,:,2)));
y(:,:,3)=mean(mean(imageconv(:,:,3)));
y=uint8(y);
Y_rgb=ycbcr2rgb(y);

cb=zeros(length(image),length(image));
cb(:,:,1)=mean(mean(imageconv(:,:,1)));
cb(:,:,2)=Cb1;
cb(:,:,3)=mean(mean(imageconv(:,:,3)));
cb=uint8(cb);
Cb_rgb=ycbcr2rgb(cb);

cr=zeros(length(image),length(image));
cr(:,:,1)=mean(mean(imageconv(:,:,1)));
cr(:,:,2)=mean(mean(imageconv(:,:,2)));
cr(:,:,3)=Cr1;
cr=uint8(cr);
Cr_rgb=ycbcr2rgb(cr);

figure;
subplot(1,3,1); imshow(Y_rgb,[]); title('Y:4');
subplot(1,3,2); imshow(Cb_rgb,[]); title('Cb:2');
subplot(1,3,3); imshow(Cr_rgb,[]); title('Cr:2');

%Write in a .yuv file the obtained result
export=fopen('export_y.yuv','wb');
fwrite(export,y,'uint8');
fclose(export);

%Compute (between same resolution components)
%<Y,Cr>, <Y,Cb> and <Cb,Cr> and compare to <R,G>, <R,B> and <G,B>
ycr=dot(double(imageconv(:,:,1)),double(Cr1));
ycb=dot(double(imageconv(:,:,1)),double(Cb1));
cbcr=dot(double(Cb1),double(Cr1));

rg=dot(double(image(:,:,1)),double(image(:,:,2)));
rb=dot(double(image(:,:,1)),double(image(:,:,3)));
gb=dot(double(image(:,:,2)),double(image(:,:,3)));

figure;
ax=0:511;
subplot(1,2,1); plot(ax,ycr,ax,ycb,ax,cbcr); title('<Y,Cr>, <Y,Cb>, <Cb,Cr>'); axis([0 512 0 2*10^7]);
subplot(1,2,2); plot(ax,rg,ax,rb,ax,gb); title('<R,G>, <R,B>, <G,B>'); axis([0 512 0 2*10^7]);
end
