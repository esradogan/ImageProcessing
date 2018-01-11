I=imread('f.jpg');

A=rgb2gray(I);
figure(1), imshow(A);
title('Gri Seviye Resim');

 
C=imadjust(A,[0 1],[1 0]);
 figure(3), imshow(C);
 title('Negatif Resim');
 
 %iki resimi birbirinden çýkarýyoruz
 D = imabsdiff(A,C);
 figure(2), imshow(D);
 
 %burada bi eþik deðeri belirledik
 %eþik deðerinin üzerindeki kýsýmlarý aldýk yani delikleri
 Dbw = D>230;
figure(4),imshow(Dbw);
title('Gürültülü Delikler');

%gürültüleri kaldýrdýk.
Dbw_open = bwareaopen(Dbw,40);
figure(5),imshow(Dbw_open);
title('Gürültüsüz Delikler');

%Bu kodlar ile yakýnlarda bulunan pixel deðerleri birleþtirilir.strel
%komutu ile yuvarlak nesne tanýmý yapýldý
se1 = strel('square',3);
Dbw_dilate = imdilate(Dbw_open,se1);
imshow(Dbw_dilate);


%bwlabel ile resmimizdeki nesneleri belirliyoruz . L içine nesnelerin pixel deðerleri , NumDiffs içine
%ise kaç tane nesne olduðu atýlýyor . Burada NumDiffs deðeri 3’tür.
%regionprops ile L’de bulunan nesnelerin tüm özellikleri ( all ) alýnýyor .
%Merkezleri , alanlarý , çevrelemek için kullanýlan bounding box deðerleri gibi bir sürü deðer s deðiþkenine atanýyor. Farklý olan yerlerin üzerine 
%yuvarlak çizebilmemiz için merkez deðerlerini de c deðiþkenine atýyoruz.
[L,NumDiffs] = bwlabel(Dbw_dilate);
s = regionprops(L,'all');
c = [s.Centroid];


%yuvarlak çizme
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












