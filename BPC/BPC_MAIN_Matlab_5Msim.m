% Bad Pixel Correction 
clear all
close all
%% parameters:
 
hot_th=128;
cold_th=128;

%%
%% load the raw image from HardWare Simulation
img=load('cc24_clean.txt'); %00
%img=load('cc24.txt'); %00
img=reshape(img,[],400);%row, column
figure;imshow(img/1023);  %test

% img_confirm=load('bpc_out_matlab.txt'); %00
% img_confirm=reshape(img_confirm,[],400);%row, column
% figure;imshow(img_confirm/1023);  %test



%-----------------------------------------------




% check the pixel order
pix_order=0;% assuming the order is 00: BGGR; 01:GBRG; 10:GRBG; 11:RGGB;  
RGB(:,:,3)=img(1:2:end,1:2:end);
RGB(:,:,2)=img(1:2:end,2:2:end);
RGB(:,:,1)=img(2:2:end,2:2:end);
figure;imshow(RGB/1023);

%% ADD the Defective pixels to DEBUG

img(7,14)=1023; img(8,18)=1023; % type #1: Singles (one defect pixel)
img(8,7)=1023; img(9,8)=1023; % type #4: Couplets (cross color channels: Green/Green)
img(13,7)=1023; img(14,8)=1023; % type #5: Couplets (cross color channels: Red/Blue)
img(18,6)=1023; img(18,8)=1023;%type#6: Couplets(Same color Channel)
img(23,6)=1023; img(23,8)=1023;%type#6: Couplets(Same color Channel)

img(14,14)=5; img(14,19)=5; % type #1: Singles (one defect pixel)
img(16,17)=5; img(17,18)=5; % type #4: Couplets (cross color channels: Green/Green)
img(18,16)=5; img(19,17)=5; % type #5: Couplets (cross color channels: Red/Blue)
img(10,14)=5; img(20,16)=5;%type#6: Couplets(Same color Channel)
img(22,13)=5; img(22,15)=5;%type#6: Couplets(Same color Channel)





% img(572,345)=1023;img(573,346)=1023;
% img(572,356)=1023;img(573,357)=1023;
% img(572,369)=1023;img(573,368)=1023;

height=size(img,1);
width=size(img,2);
img_cfa=zeros(height,width,3);
img_cfa(2:2:end,2:2:end,1)=img(2:2:end,2:2:end);
img_cfa(1:2:end,2:2:end,2)=img(1:2:end,2:2:end);
img_cfa(2:2:end,1:2:end,2)=img(2:2:end,1:2:end);
img_cfa(1:2:end,1:2:end,3)=img(1:2:end,1:2:end);
figure;imagesc(img_cfa/1023);axis equal



%% BPC 1 lines

outimg=BPC_1line_V2(img,hot_th,cold_th);




%% Output Image
out_img_cfa=zeros(height,width,3);
out_img_cfa(2:2:end,2:2:end,1)=outimg(2:2:end,2:2:end);
out_img_cfa(1:2:end,2:2:end,2)=outimg(1:2:end,2:2:end);
out_img_cfa(2:2:end,1:2:end,2)=outimg(2:2:end,1:2:end);
out_img_cfa(1:2:end,1:2:end,3)=outimg(1:2:end,1:2:end);
figure;imagesc(out_img_cfa/1023);axis equal
%% for verification
dlmwrite('test_in.txt',img,'Delimiter',' ');
dlmwrite('test_out_V2.txt',outimg,'Delimiter',' ');


img_in=load('test_in.txt'); %00
img_in=reshape(img_in,[],400);%row, column
 
RGB_in(:,:,3)=img_in(1:2:end,1:2:end);
RGB_in(:,:,2)=img_in(1:2:end,2:2:end);
RGB_in(:,:,1)=img_in(2:2:end,2:2:end);
figure;imshow(RGB_in/1023);

img_out=load('test_out_V2.txt'); %00
img_out=reshape(img_out,[],400);%row, column
RGB_out(:,:,3)=img_out(1:2:end,1:2:end);
RGB_out(:,:,2)=img_out(1:2:end,2:2:end);
RGB_out(:,:,1)=img_out(2:2:end,2:2:end);
figure;imshow(RGB_out/1023);
