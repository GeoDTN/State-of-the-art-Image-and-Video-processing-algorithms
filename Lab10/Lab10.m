%MULTIMEDIA COMMUNICATION SERVICES
%Multimedia information coding and description
%LAB 10

clear all;
close all;
clc;

% %Read the image and separate the luminance component
% im=rgb2ycbcr(imread('lena.jpg'));
% Y=double(im(:,:,1));
% 
% %Separate the picture in submatrices of dimension 8x8
% bsize=8;
% k=size(im);
% x1=0:k(2)-1;
% v=ones(1,length(x1)/bsize)*bsize;
% C=mat2cell(Y,v,v);
% 
% tot=length(v)*length(v);
% U=zeros(bsize*bsize,tot);
% for i=1:tot
%    U(:,i)=reshape(C{i},[],1);
% end
% 
% L=10; %Initial codewords
% w=U(:,randi(length(U),1,L));
% d=zeros(1,L);
% r=zeros(size(U));
% 
% a=zeros(1,length(U));
% 
% for i=1:length(U)
%     for j=1:L
%         d(j)=sum(abs(U(:,i)-w(:,j))); 
%     end
%     a=min(find(d==min(d)));
%     r(:,i)=w(:,a);
% end