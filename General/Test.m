 fid = fopen('QIC_Remosaic_Done.raw');
input = fread(fid,'uint16','ieee-le');
remosaic_hong = reshape(input,[4656,3504]);
remosaic_hong = remosaic_hong';

% remosaic_edwin = fliplr(remosaic_edwin);
% demosaic_edwin = demosaic(uint16(65535*remosaic_edwin/1023),'bggr');
%demosaic_edwin = Demosaic_Hong(remosaic_edwin,0);
 demosaic_hong = demosaic(uint16(65535*remosaic_hong/1023),'bggr');
demosaic_hong = fliplr(demosaic_hong);
demosaic_hong = double(demosaic_hong)./65535; 
figure,imshow(demosaic_hong*4);title('Hong remosaic and QIC')