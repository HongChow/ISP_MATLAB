close all;clear;
test_rgb = imread('./kodim19.png');
quard_bayer =  Quard_Mosaic(test_rgb);
% Mosaic(test_rgb);
Recovery_Bayer = Remosaic_Hong(quard_bayer);
Recovery_RGB_Hong = Demosaic_Hong(Recovery_Bayer,1);
figure,imshow(uint8(Recovery_RGB_Hong));title('Recovery RGB H')
imwrite(uint8(Recovery_RGB_Hong),'Recovery_RGB_H_3x3_wi.png');

