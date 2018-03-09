%MULTIMEDIA COMMUNICATION SERVICES
%Multimedia information coding and description
%LAB 6

clear all;
close all;
clc;

rows=144;
cols=176;

%Read the video and extract the frames
seq=fopen('foreman.yuv','rb');
for k=1:3
   Y(:,:,k)=(fread(seq,[cols,rows],'uint8=>uint8'))';
   Cb(:,:,k)=(fread(seq,[cols/2,rows/2],'uint8=>uint8'))';
   Cr(:,:,k)=(fread(seq,[cols/2,rows/2],'uint8=>uint8'))';
end
fclose(seq);

%Compute the blocks search in the next frame
blk=vision.BlockMatcher(... 
    'ReferenceFrameSource','Input port','BlockSize',[17 17]);

blk.OutputValue=(...
    'Horizontal and vertical components in complex form');

blend=vision.AlphaBlender;

%Compute the blocks motion on all the parts of  the frame
mot1=step(blk,Y(:,:,1),Y(:,:,2));
mot2=step(blk,Y(:,:,3),Y(:,:,2));

%Merge the two frames and visualize the frame variation
im12=step(blend,Y(:,:,2),Y(:,:,1));
im32=step(blend,Y(:,:,2),Y(:,:,3));

[x1 x2]=meshgrid(1:17:size(Y(:,:,1),2),1:17:size(Y(:,:,1),1));

figure;
subplot(2,3,1); imshow(Y(:,:,1));
subplot(2,3,2); imshow(Y(:,:,2));
subplot(2,3,3); imshow(im12);
hold on;
quiver(x1(:),x2(:),real(mot1(:)),imag(mot1(:)),0);
subplot(2,3,4); imshow(Y(:,:,3));
subplot(2,3,5); imshow(Y(:,:,2));
subplot(2,3,6); imshow(im32);
hold on;
quiver(x1(:),x2(:),real(mot2(:)),imag(mot2(:)),0);

%To extract frames
% raw=fread(seq);
% raw=raw/max(raw)';
% raw1=raw(1:rows*cols*3/2);
% raw2=raw(rows*cols*3/2+1:rows*cols*3+1);
% raw3=raw(rows*cols*3+2:rows*cols*9/2+2);
% 
% F1=vec2mat(raw1,cols);
% F2=vec2mat(raw2,cols);
% F3=vec2mat(raw3,cols);
% 
% figure; imshow(F1);
% figure; imshow(F2);
% figure; imshow(F3);