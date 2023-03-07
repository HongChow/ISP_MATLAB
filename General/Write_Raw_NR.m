%%
clc;
close all;
%fid = fopen('pRaw10_QIC.raw');
file = 'nr_float_fSigma_32_win_1_sv4_sh19.txtNR_in_C_3264_2448_1.txt';
denoised = readmatrix(file);
NR_Raw_demosaiced = demosaic(uint16(65535*denoised/1023),'bggr');
NR_Raw_demosaiced_float = double(NR_Raw_demosaiced)./65535;

figure,imshow(NR_Raw_demosaiced_float*4);
imwrite(NR_Raw_demosaiced_float*4,'nr_float_fSigma_32_win_1_sv4_sh19.txtNR_in_C_3264_2448_1.bmp')
%%
% ------------ different new test data for ISO ---------------- %
 denoised_file_name = '/home/hong/BNR/BPC_NR2.0.0_for_RTL0504/BPC_NR2.0.0_for_RTL/deploy/BPC_NR2.0.01_0220_fix_Level_25_Depth_12_win1_sv4_sh15_C8490_TL84_500LUX_ISO800_Chart.txt';
denoised = readmatrix(denoised_file_name);
std(denoised(:))
NR_Raw_demosaiced = demosaic(uint16(65535*denoised/1023),'bggr');
% gray bayer to color bayer %
% color_bayer_denoised = zeros(size(NR_Raw_demosaiced));
% 
% color_bayer_denoised_r = color_bayer_denoised(:,:,1);
% color_bayer_denoised_g = color_bayer_denoised(:,:,2);
% color_bayer_denoised_b = color_bayer_denoised(:,:,3);
% 
% color_bayer_denoised_r(2:2:end,2:2:end) = denoised(2:2:end,2:2:end);
% color_bayer_denoised_g(1:2:end,2:2:end) = denoised(1:2:end,2:2:end);
% color_bayer_denoised_g(2:2:end,1:2:end) = denoised(2:2:end,1:2:end);
% color_bayer_denoised_b(1:2:end,1:2:end) = denoised(1:2:end,1:2:end);
% color_bayer_denoised = cat(3,color_bayer_denoised_r,color_bayer_denoised_g,color_bayer_denoised_b);
% figure(3),imshow(uint8(color_bayer_denoised)),title('denoised bayer fSigma 16 win 1 sv4 sh7 before 3D');
figure(42),imshow(uint8(255*double(NR_Raw_demosaiced)./65535)),title('denoise demosaiced C8490 TL84 500LUX ISO800 Chart fSigma24 win 1 sv1 sh1 after');
imwrite(uint8(255*double(NR_Raw_demosaiced)./65535),'BPC_NR2.0.01_0220_fix_Level_25_Depth_12_win1_sv4_sh15_C8490_TL84_30LUX_ISO200_Chart.png');
%%
% ------------ different new test data for ISO ---------------- %
noisy_file_name = '/home/hong/BNR/BPC_NR2.0.0_for_RTL0504/BPC_NR2.0.0_for_RTL/deploy/C8490_TL84_500LUX_ISO800_Chart.txt';
noisy_data = readmatrix(noisy_file_name);
std(noisy_data(:))
noisy_Raw_demosaiced = demosaic(uint16(65535*noisy_data/1023),'bggr');
% gray bayer to color bayer %
% color_bayer_denoised = zeros(size(NR_Raw_demosaiced));
% 
% color_bayer_denoised_r = color_bayer_denoised(:,:,1);
% color_bayer_denoised_g = color_bayer_denoised(:,:,2);
% color_bayer_denoised_b = color_bayer_denoised(:,:,3);
% 
% color_bayer_denoised_r(2:2:end,2:2:end) = denoised(2:2:end,2:2:end);
% color_bayer_denoised_g(1:2:end,2:2:end) = denoised(1:2:end,2:2:end);
% color_bayer_denoised_g(2:2:end,1:2:end) = denoised(2:2:end,1:2:end);
% color_bayer_denoised_b(1:2:end,1:2:end) = denoised(1:2:end,1:2:end);
% color_bayer_denoised = cat(3,color_bayer_denoised_r,color_bayer_denoised_g,color_bayer_denoised_b);
% figure(3),imshow(uint8(color_bayer_denoised)),title('denoised bayer fSigma 16 win 1 sv4 sh7 before 3D');
 figure(42),imshow(uint8(255*double(noisy_Raw_demosaiced)./65535)),title('noisy_Raw_demosaiced C8490 TL84 500LUX ISO800 Chart');
%imwrite(uint8(255*double(NR_Raw_demosaiced)./65535),'BPC_NR2.0.01_0220_fix_Level_25_Depth_127_win1_sv4_sh15_C8490_TL84_30LUX_ISO200_Chart.png');
%%
% ------------ different new test data for ISO ---------------- %
denoised_file_name = 'nr_float_fSigma_8_win_1_sv4_sh20_after_C8490_TL84_30LUX_ISO6400_Chart_Part.txt';
denoised = readmatrix(denoised_file_name);
std(denoised(:))
NR_Raw_demosaiced = demosaic(uint16(65535*denoised/1023),'bggr');
% gray bayer to color bayer %
color_bayer_denoised = zeros(size(NR_Raw_demosaiced));

color_bayer_denoised_r = color_bayer_denoised(:,:,1);
color_bayer_denoised_g = color_bayer_denoised(:,:,2);
color_bayer_denoised_b = color_bayer_denoised(:,:,3);

color_bayer_denoised_r(2:2:end,2:2:end) = denoised(2:2:end,2:2:end);
color_bayer_denoised_g(1:2:end,2:2:end) = denoised(1:2:end,2:2:end);
color_bayer_denoised_g(2:2:end,1:2:end) = denoised(2:2:end,1:2:end);
color_bayer_denoised_b(1:2:end,1:2:end) = denoised(1:2:end,1:2:end);
color_bayer_denoised = cat(3,color_bayer_denoised_r,color_bayer_denoised_g,color_bayer_denoised_b);
% figure(3),imshow(uint8(color_bayer_denoised)),title('denoised bayer fSigma 16 win 1 sv4 sh7 before 3D');
 figure(40),imshow(uint8(255*double(NR_Raw_demosaiced)./65535)),title('denoise demosaiced fix1 C8490 TL84 30LUX ISO6400 Chart fSigma 8 win 1 sv4 sh19 after');
imwrite(uint8(255*double(NR_Raw_demosaiced)./65535),'float1 nr_float_fSigma_8_win_1_sv4_sh20_after_C8490_TL84_30LUX_ISO6400_Chart_Part.png');

%%

% ------------ different new test data for ISO ---------------- %
 denoised_file_name = 'BPC_NR_out2_0220_fix_Depth127_Level24_win1_sv4_sh15_C8490_TL84_30LUX_ISO6400_Chart.txt';
denoised = readmatrix(denoised_file_name);
std(denoised(:))
NR_Raw_demosaiced = demosaic(uint16(65535*denoised/1023),'bggr');
% gray bayer to color bayer %
color_bayer_denoised = zeros(size(NR_Raw_demosaiced));

color_bayer_denoised_r = color_bayer_denoised(:,:,1);
color_bayer_denoised_g = color_bayer_denoised(:,:,2);
color_bayer_denoised_b = color_bayer_denoised(:,:,3);

color_bayer_denoised_r(2:2:end,2:2:end) = denoised(2:2:end,2:2:end);
color_bayer_denoised_g(1:2:end,2:2:end) = denoised(1:2:end,2:2:end);
color_bayer_denoised_g(2:2:end,1:2:end) = denoised(2:2:end,1:2:end);
color_bayer_denoised_b(1:2:end,1:2:end) = denoised(1:2:end,1:2:end);
color_bayer_denoised = cat(3,color_bayer_denoised_r,color_bayer_denoised_g,color_bayer_denoised_b);
% figure(3),imshow(uint8(color_bayer_denoised)),title('denoised bayer fSigma 16 win 1 sv4 sh7 before 3D');
 figure(43),imshow(uint8(255*double(NR_Raw_demosaiced)./65535)),title('denoise demosaiced NR_in_C8490_TL84_30LUX_ISO6400_Chart fSigma 16 win 1 sv4 sh7 before');
imwrite(uint8(255*double(NR_Raw_demosaiced)./65535),'BPC_NR_out2_0220_fix_Depth127_Level24_win1_sv4_sh15_C8490_TL84_30LUX_ISO6400_Chart.png');


%%

% ------------ different new test data for ISO ---------------- %
 denoised_file_name = 'BPC_NR2.0.01_0220_fix_Level_25_Depth_48_win1_sv4_sh15_C8490_TL84_30LUX_ISO800_Chart.txt';
denoised = readmatrix(denoised_file_name);
std(denoised(:))
NR_Raw_demosaiced = demosaic(uint16(65535*denoised/1023),'bggr');
% gray bayer to color bayer %
color_bayer_denoised = zeros(size(NR_Raw_demosaiced));

color_bayer_denoised_r = color_bayer_denoised(:,:,1);
color_bayer_denoised_g = color_bayer_denoised(:,:,2);
color_bayer_denoised_b = color_bayer_denoised(:,:,3);

color_bayer_denoised_r(2:2:end,2:2:end) = denoised(2:2:end,2:2:end);
color_bayer_denoised_g(1:2:end,2:2:end) = denoised(1:2:end,2:2:end);
color_bayer_denoised_g(2:2:end,1:2:end) = denoised(2:2:end,1:2:end);
color_bayer_denoised_b(1:2:end,1:2:end) = denoised(1:2:end,1:2:end);
color_bayer_denoised = cat(3,color_bayer_denoised_r,color_bayer_denoised_g,color_bayer_denoised_b);
% figure(3),imshow(uint8(color_bayer_denoised)),title('denoised bayer fSigma 16 win 1 sv4 sh7 before 3D');
 figure(45),imshow(uint8(255*double(NR_Raw_demosaiced)./65535)),title('denoise demosaiced NR_in_C8490_TL84_30LUX_ISO6400_Chart fSigma 48 win 1 sv4 sh7 before');
imwrite(uint8(255*double(NR_Raw_demosaiced)./65535),'BPC_NR2.0.01_0220_fix_Level_25_Depth_8_win1_sv4_sh15_C8490_TL84_30LUX_ISO6400_Chart_Part.png');
%%
% nr_float_fSigma_16_win_1_sv2_sh3_adjust_noisy_bayer_plane
%nr_float_fSigma_16_win_1_sv2_sh5.txtnoisy_bayer_plane
file = 'BPC_NR2.0.01_0220_fix_Level_25_Depth_10_win1_sv4_sh15_C8490_TL84_30LUX_ISO6400_Chart.txt';
denoised = readmatrix(file);
std(denoised(:))
NR_Raw_demosaiced = demosaic(uint8(denoised),'bggr');
% gray bayer to color bayer %
color_bayer_denoised = zeros(size(NR_Raw_demosaiced));

color_bayer_denoised_r = color_bayer_denoised(:,:,1);
color_bayer_denoised_g = color_bayer_denoised(:,:,2);
color_bayer_denoised_b = color_bayer_denoised(:,:,3);

color_bayer_denoised_r(2:2:end,2:2:end) = denoised(2:2:end,2:2:end);
color_bayer_denoised_g(1:2:end,2:2:end) = denoised(1:2:end,2:2:end);
color_bayer_denoised_g(2:2:end,1:2:end) = denoised(2:2:end,1:2:end);
color_bayer_denoised_b(1:2:end,1:2:end) = denoised(1:2:end,1:2:end);
color_bayer_denoised = cat(3,color_bayer_denoised_r,color_bayer_denoised_g,color_bayer_denoised_b);
% figure(3),imshow(uint8(color_bayer_denoised)),title('denoised bayer fSigma 16 win 1 sv4 sh7 before 3D');
 figure(61),imshow(uint8(NR_Raw_demosaiced)),title('denoise demosaiced out1 fSigma 8 win 1 sv4 sh15 after');
 %%
 %nr_float_fSigma_16_win_1_sv2_sh5.txtnoisy_bayer_plane
file = 'nr_float_fSigma_16_win_1_sv2_sh3.txtnoisy_bayer_plane.txt';
denoised = readmatrix(file);
std(denoised(:))
NR_Raw_demosaiced = demosaic(uint8(denoised),'bggr');
% gray bayer to color bayer %
color_bayer_denoised = zeros(size(NR_Raw_demosaiced));

color_bayer_denoised_r = color_bayer_denoised(:,:,1);
color_bayer_denoised_g = color_bayer_denoised(:,:,2);
color_bayer_denoised_b = color_bayer_denoised(:,:,3);

color_bayer_denoised_r(2:2:end,2:2:end) = denoised(2:2:end,2:2:end);
color_bayer_denoised_g(1:2:end,2:2:end) = denoised(1:2:end,2:2:end);
color_bayer_denoised_g(2:2:end,1:2:end) = denoised(2:2:end,1:2:end);
color_bayer_denoised_b(1:2:end,1:2:end) = denoised(1:2:end,1:2:end);
color_bayer_denoised = cat(3,color_bayer_denoised_r,color_bayer_denoised_g,color_bayer_denoised_b);
% figure(3),imshow(uint8(color_bayer_denoised)),title('denoised bayer fSigma 16 win 1 sv4 sh7 before 3D');
 figure(4),imshow(uint8(NR_Raw_demosaiced)),title('denoise demosaiced fSigma 16 win 1 sv2 sh3 before');

 %%
 
 file = 'nr_float_fSigma_16_win_1_sv4_sh7_before_NR_in_C_3264_2448_1.txt';
denoised = readmatrix(file);
std(denoised(:))
NR_Raw_demosaiced = demosaic(uint8(denoised),'bggr');
% gray bayer to color bayer %
color_bayer_denoised = zeros(size(NR_Raw_demosaiced));

color_bayer_denoised_r = color_bayer_denoised(:,:,1);
color_bayer_denoised_g = color_bayer_denoised(:,:,2);
color_bayer_denoised_b = color_bayer_denoised(:,:,3);

color_bayer_denoised_r(2:2:end,2:2:end) = denoised(2:2:end,2:2:end);
color_bayer_denoised_g(1:2:end,2:2:end) = denoised(1:2:end,2:2:end);
color_bayer_denoised_g(2:2:end,1:2:end) = denoised(2:2:end,1:2:end);
color_bayer_denoised_b(1:2:end,1:2:end) = denoised(1:2:end,1:2:end);
color_bayer_denoised = cat(3,color_bayer_denoised_r,color_bayer_denoised_g,color_bayer_denoised_b);
% figure(3),imshow(uint8(color_bayer_denoised)),title('denoised bayer fSigma 16 win 1 sv4 sh7 before 3D');
 figure(41),imshow(uint8(NR_Raw_demosaiced)),title('denoise demosaiced NR_in_C_3264_2448 fSigma 16 win 1 sv4 sh7 before');
imwrite(uint8(NR_Raw_demosaiced),'8M1 fSigma 16 win 1 sv4 sh7 before.png')
  %%
 
 file = 'BPC_NR_out2_0220_fix_Level_25_Depth_127_win1_sv4_sh15_C8490_TL84_30LUX_ISO6400_Chart.txt';
denoised = readmatrix(file);
std(denoised(:))
NR_Raw_demosaiced = demosaic(uint8(denoised),'bggr');
% gray bayer to color bayer %
color_bayer_denoised = zeros(size(NR_Raw_demosaiced));

color_bayer_denoised_r = color_bayer_denoised(:,:,1);
color_bayer_denoised_g = color_bayer_denoised(:,:,2);
color_bayer_denoised_b = color_bayer_denoised(:,:,3);

color_bayer_denoised_r(2:2:end,2:2:end) = denoised(2:2:end,2:2:end);
color_bayer_denoised_g(1:2:end,2:2:end) = denoised(1:2:end,2:2:end);
color_bayer_denoised_g(2:2:end,1:2:end) = denoised(2:2:end,1:2:end);
color_bayer_denoised_b(1:2:end,1:2:end) = denoised(1:2:end,1:2:end);
color_bayer_denoised = cat(3,color_bayer_denoised_r,color_bayer_denoised_g,color_bayer_denoised_b);
% figure(3),imshow(uint8(color_bayer_denoised)),title('denoised bayer fSigma 16 win 1 sv4 sh7 before 3D');
 figure(42),imshow(uint8(NR_Raw_demosaiced)),title('denoise demosaiced NR_in_C_3264_2448 fSigma 16 win 1 sv4 sh7 after');
 %imwrite(uint8(NR_Raw_demosaiced),'8M1 fSigma 16 win 1 sv4 sh7 after.png')
%%
% nr_float_fSigma_16_win_1_sv2_sh3_adjust_noisy_bayer_plane
%nr_float_fSigma_16_win_1_sv2_sh5.txtnoisy_bayer_plane
file = 'BPC_NR_out2_0220_fix_fSigma68_win1_sv4_sh15_noisy_bayer_plane_for_debug.txt';
denoised = readmatrix(file);
std(denoised(:))
NR_Raw_demosaiced = demosaic(uint8(denoised),'bggr');
% gray bayer to color bayer %
color_bayer_denoised = zeros(size(NR_Raw_demosaiced));

color_bayer_denoised_r = color_bayer_denoised(:,:,1);
color_bayer_denoised_g = color_bayer_denoised(:,:,2);
color_bayer_denoised_b = color_bayer_denoised(:,:,3);

color_bayer_denoised_r(2:2:end,2:2:end) = denoised(2:2:end,2:2:end);
color_bayer_denoised_g(1:2:end,2:2:end) = denoised(1:2:end,2:2:end);
color_bayer_denoised_g(2:2:end,1:2:end) = denoised(2:2:end,1:2:end);
color_bayer_denoised_b(1:2:end,1:2:end) = denoised(1:2:end,1:2:end);
color_bayer_denoised = cat(3,color_bayer_denoised_r,color_bayer_denoised_g,color_bayer_denoised_b);
% figure(1),imshow(uint8(color_bayer_denoised)),title('denoised bayer 3D fSigma_16 win 1 sv4 sh7 adjust');
figure(8),imshow(uint8(NR_Raw_demosaiced)),title('denoise_demosaiced fSigma 16 win 1 sv4 sh7 adjust');

%%
% nr_float_fSigma_16_win_1_sv2_sh3_adjust_noisy_bayer_plane
%nr_float_fSigma_16_win_1_sv2_sh5.txtnoisy_bayer_plane
file = 'noisy_bayer_plane.txt';
denoised = readmatrix(file);
std(denoised(:))
NR_Raw_demosaiced = demosaic(uint8(denoised),'bggr');
% gray bayer to color bayer %
color_bayer_denoised = zeros(size(NR_Raw_demosaiced));

color_bayer_denoised_r = color_bayer_denoised(:,:,1);
color_bayer_denoised_g = color_bayer_denoised(:,:,2);
color_bayer_denoised_b = color_bayer_denoised(:,:,3);

color_bayer_denoised_r(2:2:end,2:2:end) = denoised(2:2:end,2:2:end);
color_bayer_denoised_g(1:2:end,2:2:end) = denoised(1:2:end,2:2:end);
color_bayer_denoised_g(2:2:end,1:2:end) = denoised(2:2:end,1:2:end);
color_bayer_denoised_b(1:2:end,1:2:end) = denoised(1:2:end,1:2:end);
color_bayer_denoised = cat(3,color_bayer_denoised_r,color_bayer_denoised_g,color_bayer_denoised_b);
% figure(1),imshow(uint8(color_bayer_denoised)),title('denoised bayer 3D fSigma_16 win 1 sv2 sh3 adjust');
figure(2),imshow(uint8(NR_Raw_demosaiced)),title('denoise_demosaiced fSigma 16 win 1 sv2 sh3 adjust');
%%

file = 'BPC_NR_out_0220_fix_fSigma68_win1_sv1_sh2_noisy_bayer_plane_for_debug.txt';
denoised = readmatrix(file);
std(denoised(:))
NR_Raw_demosaiced = demosaic(uint8(denoised),'bggr');
% gray bayer to color bayer %
color_bayer_denoised = zeros(size(NR_Raw_demosaiced));

color_bayer_denoised_r = color_bayer_denoised(:,:,1);
color_bayer_denoised_g = color_bayer_denoised(:,:,2);
color_bayer_denoised_b = color_bayer_denoised(:,:,3);

color_bayer_denoised_r(2:2:end,2:2:end) = denoised(2:2:end,2:2:end);
color_bayer_denoised_g(1:2:end,2:2:end) = denoised(1:2:end,2:2:end);
color_bayer_denoised_g(2:2:end,1:2:end) = denoised(2:2:end,1:2:end);
color_bayer_denoised_b(1:2:end,1:2:end) = denoised(1:2:end,1:2:end);
color_bayer_denoised = cat(3,color_bayer_denoised_r,color_bayer_denoised_g,color_bayer_denoised_b);
figure,imshow(uint8(color_bayer_denoised)),title('denoised bayer 3D debug');
figure,imshow(uint8(NR_Raw_demosaiced)),title('denoise_demosaiced 2 debug')

%%
file = 'nr_float_fSigma_40_win_1_sv2_sh3.txtnoisy_bayer_plane_M.txt';
denoised = readmatrix(file);
NR_Raw_demosaiced = demosaic(uint8(denoised),'bggr');
% gray bayer to color bayer %
color_bayer_denoised = zeros(size(NR_Raw_demosaiced));

color_bayer_denoised_r = color_bayer_denoised(:,:,1);
color_bayer_denoised_g = color_bayer_denoised(:,:,2);
color_bayer_denoised_b = color_bayer_denoised(:,:,3);

color_bayer_denoised_r(2:2:end,2:2:end) = denoised(2:2:end,2:2:end);
color_bayer_denoised_g(1:2:end,2:2:end) = denoised(1:2:end,2:2:end);
color_bayer_denoised_g(2:2:end,1:2:end) = denoised(2:2:end,1:2:end);
color_bayer_denoised_b(1:2:end,1:2:end) = denoised(1:2:end,1:2:end);
color_bayer_denoised = cat(3,color_bayer_denoised_r,color_bayer_denoised_g,color_bayer_denoised_b);
figure,imshow(uint8(color_bayer_denoised)),title('denoised bayer M 3D');
figure,imshow(uint8(NR_Raw_demosaiced)),title('denoise_demosaiced M')
%%
file = 'nr_float_fSigma_10_win_1_sv4_sh19.txtnoisy_bayer_plane.txt';
denoised = readmatrix(file);
NR_Raw_demosaiced = demosaic(uint8(denoised),'bggr');
% gray bayer to color bayer %
color_bayer_denoised = zeros(size(NR_Raw_demosaiced));

color_bayer_denoised_r = color_bayer_denoised(:,:,1);
color_bayer_denoised_g = color_bayer_denoised(:,:,2);
color_bayer_denoised_b = color_bayer_denoised(:,:,3);

color_bayer_denoised_r(2:2:end,2:2:end) = denoised(2:2:end,2:2:end);
color_bayer_denoised_g(1:2:end,2:2:end) = denoised(1:2:end,2:2:end);
color_bayer_denoised_g(2:2:end,1:2:end) = denoised(2:2:end,1:2:end);
color_bayer_denoised_b(1:2:end,1:2:end) = denoised(1:2:end,1:2:end);
color_bayer_denoised = cat(3,color_bayer_denoised_r,color_bayer_denoised_g,color_bayer_denoised_b);
figure,imshow(uint8(color_bayer_denoised));
figure,imshow(uint8(NR_Raw_demosaiced))
%%
color_bayer_noisy = zeros(size(color_bayer_denoised));

color_bayer_noisy_r = color_bayer_noisy(:,:,1);
color_bayer_noisy_g = color_bayer_noisy(:,:,2);
color_bayer_noisy_b = color_bayer_noisy(:,:,3);

color_bayer_noisy_r(2:2:end,2:2:end) = to_demosaic(2:2:end,2:2:end);
color_bayer_noisy_g(1:2:end,2:2:end) = to_demosaic(1:2:end,2:2:end);
color_bayer_noisy_g(2:2:end,1:2:end) = to_demosaic(2:2:end,1:2:end);
color_bayer_noisy_b(1:2:end,1:2:end) = to_demosaic(1:2:end,1:2:end);
color_bayer_noisy = cat(3,color_bayer_noisy_r,color_bayer_noisy_g,color_bayer_noisy_b);
figure,imshow(uint8(color_bayer_noisy));title('noisy bayer 3D');