 fid = fopen('QIC_REMOSAIC_Edwin.raw');
input = fread(fid,'uint16','ieee-le');
remosaic_edwin = reshape(input,[4656,3504]);
remosaic_edwin = remosaic_edwin';

% remosaic_edwin = fliplr(remosaic_edwin);
% demosaic_edwin = demosaic(uint16(65535*remosaic_edwin/1023),'bggr');
%demosaic_edwin = Demosaic_Hong(remosaic_edwin,0);
 demosaic_edwin = demosaic(uint16(65535*remosaic_edwin/1023),'bggr');
demosaic_edwin = fliplr(demosaic_edwin);
demosaic_edwin = double(demosaic_edwin)./65535; 
figure,imshow(demosaic_edwin*4);title('edwin remosaic and QIC')
imwrite(uint8(demosaic_edwin*255*4),'Edwin QIC and Edwin remosaic.png');

%%
fid = fopen('Debug_Bdir.raw');
%fid = fopen('qic_remosaic.txt');
input = fread(fid,'int16','ieee-le');
remosaic_hong = reshape(input,[4656/2,3504/2]);
B_dir = remosaic_hong';

fid = fopen('Debug_Gdir.raw');
%fid = fopen('qic_remosaic.txt');
input = fread(fid,'int16','ieee-le');
remosaic_hong = reshape(input,[4656/2,3504/2]);
G_dir = remosaic_hong';

fid = fopen('Debug_Rdir.raw');
%fid = fopen('qic_remosaic.txt');
input = fread(fid,'int16','ieee-le');
remosaic_hong = reshape(input,[4656/2,3504/2]);
R_dir = remosaic_hong';
RGB_dir = cat(3,R_dir,G_dir,B_dir);
figure,imshow(uint8(RGB_dir));title('RGB dir')

%%
fid = fopen('Debug_Bavg.raw');
%fid = fopen('qic_remosaic.txt');
input = fread(fid,'int16','ieee-le');
remosaic_hong = reshape(input,[4656/2,3504/2]);
B_dir = remosaic_hong';

fid = fopen('Debug_Gavg.raw');
%fid = fopen('qic_remosaic.txt');
input = fread(fid,'int16','ieee-le');
remosaic_hong = reshape(input,[4656/2,3504/2]);
G_dir = remosaic_hong';

fid = fopen('Debug_Ravg.raw');
%fid = fopen('qic_remosaic.txt');
input = fread(fid,'int16','ieee-le');
remosaic_hong = reshape(input,[4656/2,3504/2]);
R_dir = remosaic_hong';
RGB_dir = cat(3,R_dir,G_dir,B_dir);
figure,imshow(uint8(RGB_dir));title('RGB AVG')

%%
 fid = fopen('QIC_Remosaic_Done2.1_blc.raw');
%fid = fopen('qic_remosaic.txt');
input = fread(fid,'uint16','ieee-le');
remosaic_hong = reshape(input,[4656,3504]);
remosaic_hong = remosaic_hong';


% remosaic_edwin = fliplr(remosaic_edwin);
% demosaic_edwin = demosaic(uint16(65535*remosaic_edwin/1023),'bggr');
%demosaic_edwin = Demosaic_Hong(remosaic_edwin,0);
demosaic_hong = demosaic(uint16(65535*remosaic_hong/1023),'bggr');
demosaic_hong = fliplr(demosaic_hong);
demosaic_hong = double(demosaic_hong)./65535; 
figure,imshow(demosaic_hong*4);title('Mode2.1 blc  remosaic and QIC')
imwrite(uint8(demosaic_hong*255*4),'Mode2.1 blc remosaic and QIC.png');

%%
 fid = fopen('QIC_Remosaic_Done_Mode2.1.fix.raw');
%fid = fopen('qic_remosaic.txt');
input = fread(fid,'uint16','ieee-le');
remosaic_hong = reshape(input,[4656,3504]);
remosaic_hong = remosaic_hong';


% remosaic_edwin = fliplr(remosaic_edwin);
% demosaic_edwin = demosaic(uint16(65535*remosaic_edwin/1023),'bggr');
%demosaic_edwin = Demosaic_Hong(remosaic_edwin,0);
demosaic_hong = demosaic(uint16(65535*remosaic_hong/1023),'bggr');
demosaic_hong = fliplr(demosaic_hong);
demosaic_hong = double(demosaic_hong)./65535; 
figure,imshow(demosaic_hong*4);title('Mode2.1 blc  remosaic and QIC fix')
imwrite(uint8(demosaic_hong*255*4),'Mode2.1 blc remosaic and QIC fix .png');
%%
 fid = fopen('QIC_Remosaic_Done_Mode2.1.fix.raw');
%fid = fopen('qic_remosaic.txt');
input = fread(fid,'uint16','ieee-le');
remosaic_hong = reshape(input,[4656,3504]);
remosaic_hong = remosaic_hong';


% remosaic_edwin = fliplr(remosaic_edwin);
% demosaic_edwin = demosaic(uint16(65535*remosaic_edwin/1023),'bggr');
%demosaic_edwin = Demosaic_Hong(remosaic_edwin,0);
demosaic_hong = demosaic(uint16(65535*remosaic_hong/1023),'bggr');
demosaic_hong = fliplr(demosaic_hong);
demosaic_hong = double(demosaic_hong)./65535; 
figure,imshow(demosaic_hong*4);title('Mode2.1 blc  remosaic and QIC fix')
imwrite(uint8(demosaic_hong*255*4),'Mode2.1 blc remosaic and QIC fix .png');

%%
fid = fopen('QIC_Remosaic_Done_Mode4_0929.raw');
%fid = fopen('qic_remosaic.txt');
input = fread(fid,'uint16','ieee-le');
remosaic_hong = reshape(input,[4656,3504]);
remosaic_hong = remosaic_hong';


% remosaic_edwin = fliplr(remosaic_edwin);
% demosaic_edwin = demosaic(uint16(65535*remosaic_edwin/1023),'bggr');
%demosaic_edwin = Demosaic_Hong(remosaic_edwin,0);
demosaic_hong = demosaic(uint16(65535*remosaic_hong/1023),'bggr');
demosaic_hong = fliplr(demosaic_hong);
demosaic_hong = double(demosaic_hong)./65535; 
figure,imshow(uint8(demosaic_hong*255*4));title('QIC_Remosaic_Done_Mode3 0929')
imwrite(uint8(demosaic_hong*255*4),'QIC_Remosaic_Done_Mode3_0929.png');

%%
fid = fopen('directions.raw');
%fid = fopen('qic_remosaic.txt');
input = fread(fid,'uint16','ieee-le');
%temp = reshape(input,[4656,3504]);
temp = reshape(input,[4656/2,3504/2]);
temp = temp';
temp(temp==2)=0;
%temp = double(temp)./1023; 
figure,imshow(uint8(temp*255));title('directions M3 Andriod 0929')

% remosaic_edwin = fliplr(remosaic_edwin);
% demosaic_edwin = demosaic(uint16(65535*remosaic_edwin/1023),'bggr');
%demosaic_edwin = Demosaic_Hong(remosaic_edwin,0);
% demosaic_hong = demosaic(uint16(65535*remosaic_hong/1023),'bggr');
% demosaic_hong = fliplr(demosaic_hong);
% demosaic_hong = double(demosaic_hong)./65535; 
% figure,imshow(uint8(demosaic_hong*255*4));title('QIC_Remosaic_Done_Mode3 0927')
% imwrite(uint8(demosaic_hong*255*4),'QIC_Remosaic_Done_Mode3_0927.png');

%%
% 
% 
% demosaic_edwin = fliplr(demosaic_edwin);
% demosaic_edwin = double(demosaic_edwin)./65536; 

J = reshape(demosaic_edwin, size(demosaic_edwin,1)*size(demosaic_edwin,2),3);
J=J';% 3x 
% ob=[-119	-111	-115]/1024; %0-1 for RGB
% ob=[0	0	0]/1024; %0-1 for RGB
ob=[-64	-64	-64]/1024; %0-1 for RGB
%wb_gain=[4.346369	3.312420	3.699826]/3.312420;
wb_gain=[4.346369	3.312420	3.699826]/1; %RGB
ccm=[2.615221	-1.654988	0.039768
-0.291468	1.550016	-0.258548
0.055554	-0.990407	1.934853];

WB_image=diag(wb_gain)*(J+repmat(ob',1,size(J,2)));
WB_image=min(max(WB_image,0),1);

CCM_image = ccm*WB_image;
CCM_image=min(max(CCM_image,0),1);


% gamma correction
GAM_image= lin2rgb(CCM_image);
GAM_image_dis=reshape(GAM_image',size(demosaic_edwin,1),size(demosaic_edwin,2),3);
figure;imshow(GAM_image_dis);title('edwin remosaic')
imwrite(uint8(GAM_image_dis*255),'Remosaic_Cista_Edwin.png');
% figure,imshow(demosaic_edwin)