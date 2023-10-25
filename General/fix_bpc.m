%%
fid = fopen('dark_blcon_raw10_wo_fix.raw');
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
figure,imshow(demosaic_hong*4);title('dark_blcon_raw10')
imwrite(uint8(demosaic_hong*255*4),'dark_blcon_raw10_wo_fix .png');
%%
fid = fopen('dark_blcoff_raw10.raw');
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
figure,imshow(demosaic_hong*4);title('dark_blcoff_raw10')

imwrite(uint8(demosaic_hong*255*4),' dark_blcoff_raw10.png');
%%
fid = fopen('dark_blcon_raw10.raw');
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
figure,imshow(demosaic_hong*4);title('dark_blcoff_raw10')

imwrite(uint8(demosaic_hong*255*4),' dark_blcon_raw10.png');


%%
fid = fopen('QIC_Remosaic_Done_neon.raw');
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
figure,imshow(demosaic_hong*4);title('QIC_Remosaic_Done_neon')
imwrite(uint8(demosaic_hong*255*4),'QIC_Remosaic_Done_neon .png');