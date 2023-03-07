close all;clear;
Test_image = zeros(800,800,3);
Test_image(1:400,1:400,1) = 100;
Test_image(400:end,400:end,1) = 200;
Test_image(400:end,400:end,2) = 100;
quard_bayer = Quard_Mosaic(uint8(Test_image));
% Mosaic(test_rgb);
Recovery_Bayer = Remosaic_Hong(quard_bayer);
Recovery_RGB_Hong = Demosaic_Hong3x3(Recovery_Bayer);
figure,imshow(uint8(Recovery_RGB_Hong));title('Recovery Simple RGB H')
imwrite(uint8(Recovery_RGB_Hong),'Recovery_RGB_Simple.png');

