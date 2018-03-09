%MULTIMEDIA COMMUNICATION SERVICES
%Multimedia information coding and description
%LAB 5

clear all;
close all;
clc;

%Optimal prediction filter

%Read the image and extract the luminance component
image=imread('4.2.03.tiff');
imageconv=rgb2ycbcr(image);
Y=double(imageconv(:,:,1));
Y=Y/max(max(Y));

%Compute the autocorrelation of the luminance component
R=xcorr2(Y);
[mx,my]=find(R==max(max(R)));

%Compute the coefficients of the optimal predictor
b=1/(length(Y)-2)^2;
c=1/(length(Y)-1)^2;
d=1/length(Y)^2;
C=[d*R(mx,my) b*R(mx+1,mx-1) c*R(mx,my-1); b*R(mx-1,my+1) d*R(mx,my) c*R(mx-1,my); c*R(mx,my+1) c*R(mx+1,my) d*R(mx,my)];
g=[c*R(mx+1,my); c*R(mx,my+1); b*R(mx+1,my+1)];
a=C\g;

%Compute the predicted image
I=zeros(size(Y));
for j=2:length(Y)
   for k=2:length(Y)
       I(j,k)=a(1)*Y(j-1,k)+a(2)*Y(j,k-1)+a(3)*Y(j-1,k-1);
   end
end

figure;
subplot(1,2,1); imshow(Y,[]); title('Y component');
subplot(1,2,2); imshow(R,[]); title('Autocorrelation of the Y component');

figure;
subplot(1,2,1); imshow(Y,[]); title('Original image');
subplot(1,2,2); imshow(I,[]); title('Predicted image');

%Compute and display the prediction error
perr=Y-I;
figure; imshow(perr,[]); title('Prediction error');

%Compute and display the autocorrelation of the prediction error
Rperr=xcorr2(perr);
power=Rperr(mx,my);
figure; imshow(Rperr,[]); title('Autocorrelation of the prediction error');

%Compute the prediction error, power and autocorrelation using sub-optimal coefficients
a1=[1/3; 1/3; 1/3];

I1=zeros(size(Y));
for j=2:length(Y)
   for k=2:length(Y)
       I1(j,k)=a1(1)*Y(j-1,k)+a1(2)*Y(j,k-1)+a1(3)*Y(j-1,k-1);
   end
end
perr1=Y-I1;
Rperr1=xcorr2(perr1);
power1=Rperr1(mx,my);

figure; imshow(perr1,[]); title('Prediction error with sub-optimal coefficients');
figure; imshow(Rperr1,[]); title('Autocorrelation of the prediction error with sub-optimal coefficients');


%Now repeat the same steps as before using a synthetic image

%I start using optimal coefficients
[x y]=ndgrid(-3:0.01:3);
s=sin(2*pi*x)*cos(2*pi*y);

Rs=xcorr2(s);
[mx,my]=find(Rs==max(max(Rs)));
b=1/(length(Y)-2)^2;
c=1/(length(Y)-1)^2;
d=1/length(Y)^2;
Cs=[d*R(mx,my) b*R(mx+1,mx-1) c*R(mx,my-1); b*R(mx-1,my+1) d*R(mx,my) c*R(mx-1,my); c*R(mx,my+1) c*R(mx+1,my) d*R(mx,my)];
gs=[c*R(mx+1,my); c*R(mx,my+1); b*R(mx+1,my+1)];
as=Cs\gs;

Is=zeros(size(s));
for j=2:length(s)
   for k=2:length(s)
       Is(j,k)=as(1)*s(j-1,k)+as(2)*s(j,k-1)+as(3)*s(j-1,k-1);
   end
end
perrs=s-Is;
Rperrs=xcorr2(perrs);
powers=Rperrs(mx,my);

figure;
subplot(1,2,1); imshow(s,[]); title('Original image');
subplot(1,2,2); imshow(Is,[]); title('Predicted image');

figure; imshow(perrs,[]); title('Prediction error');
figure; imshow(Rperrs,[]); title('Autocorrelation of the prediction error');

%Then I use sub-optimal coefficients
Is1=zeros(size(s));
for j=2:length(s)
   for k=2:length(s)
       Is1(j,k)=a1(1)*s(j-1,k)+a1(2)*s(j,k-1)+a1(3)*s(j-1,k-1);
   end
end
perrs1=s-Is1;
Rperrs1=xcorr2(perrs1);
powers1=Rperrs1(mx,my);

figure; imshow(perrs1,[]); title('Prediction error with sub-optimal coefficients');
figure; imshow(Rperrs1,[]); title('Autocorrelation of the prediction error with sub-optimal coefficients');

%N.B.: where the displayed prediction error is black means that the error
%is very low (or zero)