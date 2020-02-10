clc; clear;

%%% proses merubah warna RGB (Red, Green dan Blue) menjadi YCbCr

%%% created by: Arif Mudi Priyatno 
%%% https://github.com/arifmudi

%% membaca gambar
gambar = imread('halamandepan.png');

%% pemisahan channel R G B
R = gambar(:,:,1);
G = gambar(:,:,2);
B = gambar(:,:,3);

%% merubah uint8 menjadi double
R = double(R);
G = double(G);
B = double(B);

%% normalisasi nilai 0-255 menjadi 0-1
if max(max(R)) > 1.0 || max(max(G)) > 1.0 || max(max(B)) > 1.0
   R = R / 255;
   G = G /255;
   B = B /255;
end

%% mendapatkan tinggi dan lebar gambar
[tinggi, lebar] = size(R);

%% proses perubahan RGB ke YCbCr
for m=1:tinggi
    for n=1:lebar
       Y(m,n) = 0.299 * R(m,n) + 0.587 * G(m,n) + 0.114 * B(m,n);
       Cb(m,n) = -0.1687 * R(m,n) - 0.33126 * G(m,n) + 0.5 * B(m,n);
       Cr(m,n) = 0.5 * R(m,n) - 0.41869 * G(m,n) - 0.08131 * B(m,n);
    end
end

%% konversi YCbCr dari 0-1 menjadi 0-255
Y = Y * 255;
Cb = Cb * 255;
Cr = Cr * 255;

%% konversi typedata double ke uint8
Y = uint8(Y);
Cb = uint8(Cb);
Cr = uint8(Cr);

YCbCr = cat(3,Y,Cb,Cr);

save dataCbCr.mat Y Cb Cr;
