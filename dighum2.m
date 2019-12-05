
citra_masukan = imread('m20.jpg');
keping = size(citra_masukan,3);
if (keping==3)
	citra_gray= rgb2gray(citra_masukan);
else
	citra_gray= citra_masukan;
end
citra_biner= imbinarize(citra_gray);


subplot(2,2,1);
imshow(citra_masukan);
title("Citra Asli");
subplot(2,2,2);
imshow(citra_biner);
title("Citra Grayscale");


lebar= size(citra_biner,2);
panjang = size(citra_biner,1);

iTotal = 0;
jTotal= 0;
N=0;

for i=1:panjang
	for j=1:lebar
		if(citra_biner(i,j) ==0)
			iTotal = iTotal + i;
			jTotal = jTotal + j;
			N=N+1;
		end
	end
end

cenX = iTotal/N;
cenY = jTotal/N;



totalXi = 0;
totalYi = 0;
totalXY = 0;

for i=1:panjang
	for j=1:lebar
		if(citra_biner(i,j)==0)
			Xi = i - cenX;
			Yi = j - cenY;

			totalXi = totalXi + (Xi*Xi);
			totalYi = totalYi + (Yi*Yi);
			totalXY = totalXY + (Xi*Yi);
		end
	end
end

miuXX = totalXi / N;
miuYY = totalYi / N;
miuXY = totalXY / N;

if(miuXX > miuYY)
	miuYYXX = miuYY - miuXX;
	miuYYXX2 = miuYYXX * miuYYXX;
	miuXY2 = miuXY * miuXY;
	y= 2*miuXY2;
	akar = miuXXYY2+y;
	hasilAkar = sqrt(akar);
	bagi=miuXY;

	x= miuXXYY + hasilAkar;
	skew = bagi/x;
end

function [sudut, waktu, centro, ctrHsl] = koreksi_citra(citra_masukan)
tic;

a= 180/3.14;
b= atan (double(skew));
orientation = a*b;

if(cenY >= cenX)
	if(orientation>=0)
		angle = 90-orientation;
	else
		angle = -90 - orientation;
	end
else
	angle = orientation;
end

citra_hasil_rotasi = imrotate(citra_biner, double(-angle));
rapi_tepi; 

(citra_hasil_rotasi);

sudut= angle;
centro= strcat(num2str(cenX),', ',num2str(cenY));
ctrHsl = citra_hasil_rotasi;
waktu=toc; 


subplot(2,2,3);
imshow(ctrHsl);
title("Citra Hasil Rotasi");
end

