 fid = fopen('QIC_Remosaic_Done.raw');
input = fread(fid,'uint16','ieee-le');
remosaic_edwin = reshape(input,[4656,3504]);
remosaic_edwin = remosaic_edwin';

% remosaic_edwin = fliplr(remosaic_edwin);
% demosaic_edwin = demosaic(uint16(65535*remosaic_edwin/1023),'bggr');
%demosaic_edwin = Demosaic_Hong(remosaic_edwin,0);
 demosaic_edwin = demosaic(uint16(65535*remosaic_edwin/1023),'bggr');
demosaic_edwin = fliplr(demosaic_edwin);
demosaic_edwin = double(demosaic_edwin)./65535; 
figure,imshow(demosaic_edwin*4);title('Hong remosaic and QIC')