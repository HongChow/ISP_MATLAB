fid = fopen('QIC_Remosaic_Done_openCL.raw');
input = fread(fid,'uint16','ieee-le');
fid_out = fopen('QIC_Remosaic_Done_openCL_out.raw','w','ieee-le');
fwrite(fid_out,input,'uint16');


% remosaic_hong = reshape(input,[4656,3504]);
% remosaic_hong = remosaic_hong';
% demosaic_hong = demosaic(uint16(65535*remosaic_hong/1023),'bggr');
% demosaic_hong = fliplr(demosaic_hong);
% demosaic_hong = double(demosaic_hong)./65535; 
% figure,imshow(demosaic_hong*4);title('QIC_Remosaic_Done_openCL')
% input = fread(fid,'uint16','ieee-le');
% fwrite(fid_ouit,'uint16');