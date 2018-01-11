I=imread('f.jpg');

A=rgb2gray(I);
figure(1), imshow(A);
title('Gri Seviye Resim');

 
C=imadjust(A,[0 1],[1 0]);
 figure(3), imshow(C);
 title('Negatif Resim');
 
 %iki resimi birbirinden ��kar�yoruz
 D = imabsdiff(A,C);
 figure(2), imshow(D);
 
 %burada bi e�ik de�eri belirledik
 %e�ik de�erinin �zerindeki k�s�mlar� ald�k yani delikleri
 Dbw = D>230;
figure(4),imshow(Dbw);
title('G�r�lt�l� Delikler');

%g�r�lt�leri kald�rd�k.
Dbw_open = bwareaopen(Dbw,40);
figure(5),imshow(Dbw_open);
title('G�r�lt�s�z Delikler');

%Bu kodlar ile yak�nlarda bulunan pixel de�erleri birle�tirilir.strel
%komutu ile yuvarlak nesne tan�m� yap�ld�
se1 = strel('square',3);
Dbw_dilate = imdilate(Dbw_open,se1);
imshow(Dbw_dilate);


%bwlabel ile resmimizdeki nesneleri belirliyoruz . L i�ine nesnelerin pixel de�erleri , NumDiffs i�ine
%ise ka� tane nesne oldu�u at�l�yor . Burada NumDiffs de�eri 3�t�r.
%regionprops ile L�de bulunan nesnelerin t�m �zellikleri ( all ) al�n�yor .
%Merkezleri , alanlar� , �evrelemek i�in kullan�lan bounding box de�erleri gibi bir s�r� de�er s de�i�kenine atan�yor. Farkl� olan yerlerin �zerine 
%yuvarlak �izebilmemiz i�in merkez de�erlerini de c de�i�kenine at�yoruz.
[L,NumDiffs] = bwlabel(Dbw_dilate);
s = regionprops(L,'all');
c = [s.Centroid];


%yuvarlak �izme
figure(6);
imshow(A);
hold on;
x = c(1:2:end);
y = c(2:2:end);
plot(x,y,'yo','MarkerSize',20,'LineWidth',4);
figure(7);
imshow(C);
hold on;
x = c(1:2:end);
y = c(2:2:end);
plot(x,y,'yo','MarkerSize',20,'LineWidth',4);



%  B=bwareaopen(I,200);
%  figure(2), imshow(B);
 
% 
%  D=bwperim(C);
%  Icikis=I;
%  Icikis(D)=80;
% figure(4), imshow(D);
% 
% [~,threshold]=edge(A,'sobel');
% fudgeFactor=1.3;
% Isobel=edge(A,'sobel',threshold*fudgeFactor);
% figure(5), imshow(Isobel);












