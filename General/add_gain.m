original_image = imread('/media/hong/d59dbca9-decb-49d1-b040-7369ea65b8fa/home/hong/BNR/HongChow-Remosaic_Hong_Matlab2.0/NR_ISO_RESULTS_part1/LUX30ISO200/C8490_TL84_30LUX_ISO200_Chart_matlab_demosaiced.png');
gain_image = 8*im2double(original_image);
figure,imshow(gain_image);
imwrite(gain_image,'NR_ISO_RESULTS_part1/LUX30ISO200/C8490_TL84_30LUX_ISO200_Chart_matlab_demosaiced_gain8.png');