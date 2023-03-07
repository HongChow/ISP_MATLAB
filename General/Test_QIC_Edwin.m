clc;
clear;
fid = fopen('pRaw10_QIC.raw');
%fid = fopen('4cell-OriginalRawBuf_4656x3504.raw');
input = fread(fid,'uint16','ieee-le');
four_cell_Raw = reshape(input,[4656,3504]);
four_cell_Raw = four_cell_Raw -64;
four_cell_Raw = clip(four_cell_Raw,0,1023);
four_cell_Raw = four_cell_Raw';% after Edwin's QIC 
Recovery_Bayer = Remosaic_Hong(four_cell_Raw);
Recovery_RGB_Hong =  Demosaic_Hong(Recovery_Bayer,0);
demosaic_hong = Recovery_RGB_Hong;
demosaic_hong = double(demosaic_hong)./1023;
figure,imshow(uint8(demosaic_hong*255*4)),title('test Edwin QIC')
%imwrite(uint8(demosaic_hong*255*4),'test QIC Reorder and Remosaic2 and Demosaic flip.png')
imwrite(uint8(demosaic_hong*255*4),'test Edwin QIC BLC.png')