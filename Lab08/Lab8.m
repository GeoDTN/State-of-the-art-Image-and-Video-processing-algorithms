%MULTIMEDIA COMMUNICATION SERVICES
%Multimedia information coding and description
%LAB 8

clear all;
close all;
clc;

%Read the image and separate the luminance component
im=rgb2ycbcr(imread('lena.jpg'));
Y=double(im(:,:,1));

%Filters
hl=[sqrt(2)/2 sqrt(2)/2];
hh=[sqrt(2)/2 -sqrt(2)/2];
gl=[sqrt(2)/2 sqrt(2)/2];
gh=[-sqrt(2)/2 sqrt(2)/2];

%First filtering by columns

for i=1:length(Y)
    Xl(:,i)=conv(Y(:,i),hl,'same');
    Xh(:,i)=conv(Y(:,i),hh,'same');
end

Xl=downsample(Xl,2);
Xh=downsample(Xh,2);
Xl=Xl';
Xh=Xh';

%Second filtering by rows (the image is transposed)
for i=1:length(Xl(1,:)')
   Xll(:,i)=conv(Xl(:,i),hl,'same');
   Xlh(:,i)=conv(Xl(:,i),hh,'same');
   Xhl(:,i)=conv(Xh(:,i),hl,'same');
   Xhh(:,i)=conv(Xh(:,i),hh,'same');
end

Xll=downsample(Xll,2);
Xlh=downsample(Xlh,2);
Xhl=downsample(Xhl,2);
Xhh=downsample(Xhh,2);
Xll=Xll';
Xlh=Xlh';
Xhl=Xhl';
Xhh=Xhh';

figure;
subplot(2,2,1); imshow(Xll,[]); title('X_{LL}');
subplot(2,2,2); imshow(Xlh,[]); title('X_{LH}');
subplot(2,2,3); imshow(Xhl,[]); title('X_{HL}');
subplot(2,2,4); imshow(Xhh,[]); title('X_{HH}');

%Synthesis bank
Yll=upsample(Xll',2);
Ylh=upsample(Xlh',2);
Yhl=upsample(Xhl',2);
Yhh=upsample(Xhh',2);

for i=1:length(Yll(1,:))
    cYll(:,i)=conv(Yll(:,i),gl);
    cYlh(:,i)=conv(Ylh(:,i),gh);
    cYhl(:,i)=conv(Yhl(:,i),gl);
    cYhh(:,i)=conv(Yhh(:,i),gh);
end

Yl=cYll+cYlh;
Yh=cYhl+cYhh;
Yl=Yl';
Yh=Yh';
Yl=upsample(Yl,2);
Yh=upsample(Yh,2);
Yl(:,length(Yl))=[];
Yh(:,length(Yh))=[];

for i=1:length(Yl)
    Yol(:,i)=conv(Yl(:,i),gl);
    Yoh(:,i)=conv(Yh(:,i),gh);
end

Yol(length(Yol),:)=[];
Yoh(length(Yol),:)=[];
Yr=Yol+Yoh;

figure; 
subplot(1,2,1); imshow(Y,[]); title('Original image');
subplot(1,2,2); imshow(Yr,[]); title('Reconstructed image');


%Using only the LL sub-band
Yll=upsample(cYll',2);
for i=1:length(Yll)
    bYll(:,i)=conv(Yll(:,i),gl);
end
Yll=bYll;
Yll(257,:)=[];
Yll(:,257)=[];
figure; imshow(Yll,[]); title('LL sub-band synthesized image');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Iteration of the sub-band analysis
for i=1:length(Xll)
    xl(:,i)=conv(Xll(:,i),hl,'same');
    xh(:,i)=conv(Xll(:,i),hh,'same');
end

xl=downsample(xl,2);
xh=downsample(xh,2);
xl=xl';
xh=xh';

%Second filtering by rows (the image is transposed)
for i=1:length(xl(1,:)')
   xll(:,i)=conv(xl(:,i),hl,'same');
   xlh(:,i)=conv(xl(:,i),hh,'same');
   xhl(:,i)=conv(xh(:,i),hl,'same');
   xhh(:,i)=conv(xh(:,i),hh,'same');
end

xll=downsample(xll,2);
xlh=downsample(xlh,2);
xhl=downsample(xhl,2);
xhh=downsample(xhh,2);
xll=xll';
xlh=xlh';
xhl=xhl';
xhh=xhh';

figure;
subplot(2,2,1); imshow(xll,[]); title('x_{LL}');
subplot(2,2,2); imshow(xlh,[]); title('x_{LH}');
subplot(2,2,3); imshow(xhl,[]); title('x_{HL}');
subplot(2,2,4); imshow(xhh,[]); title('x_{HH}');

%Synthesis bank
yll=upsample(xll',2);
ylh=upsample(xlh',2);
yhl=upsample(xhl',2);
yhh=upsample(xhh',2);

for i=1:length(yll(1,:))
    dyll(:,i)=conv(yll(:,i),gl);
    dylh(:,i)=conv(ylh(:,i),gh);
    dyhl(:,i)=conv(yhl(:,i),gl);
    dyhh(:,i)=conv(yhh(:,i),gh);
end

yl=dyll+dylh;
yh=dyhl+dyhh;
yl=yl';
yh=yh';
yl=upsample(yl,2);
yh=upsample(yh,2);
yl(:,length(yl))=[];
yh(:,length(yh))=[];

for i=1:length(yl)
    yol(:,i)=conv(yl(:,i),gl);
    yoh(:,i)=conv(yh(:,i),gh);
end

yol(length(yol),:)=[];
yoh(length(yol),:)=[];
yr=yol+yoh;

figure; 
subplot(1,2,1); imshow(Xll,[]); title('Original LL image');
subplot(1,2,2); imshow(yr,[]); title('Reconstructed LL image');