%%
% ------------ different new test data for ISO ---------------- %
 denoised_file_name = '/home/h/DataDisk/ISP/BNR/BPC_NR2.0.0_for_RTL_0427/NR2.0.0_FIX_for_debug/NR2.0.0_FIX/deploy/outputs/BPC_NR2.0.01_0220_fix_Level_25_Depth_24_win1_sv2_sh19_C8490_TL84_500LUX_ISO800_Chart.txt';
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
figure(42),imshow(uint8(255*double(NR_Raw_demosaiced)./65535)),title('BPC_NR2.0.01_0220_fix_Level_25_Depth_24_win1_sv2_sh19_C8490_TL84_500LUX_ISO800_Chart 0630');
imwrite(uint8(255*double(NR_Raw_demosaiced)./65535),'BPC_NR2.0.01_0220_fix_Level_25_Depth_24_win1_sv2_sh19_C8490_TL84_500LUX_ISO800_Chart_0630.png');


%%
%%
% ------------ different new test data for ISO ---------------- %
 denoised_file_name = '/home/h/DataDisk/ISP/BNR/NR2.0.0_FIX_20230728/deploy/outputs/BPC_NR2.0.01_0220_fix_bpcEnable_1_nrEnable_1_Level_25_Depth_84_win1_sv2_sh19_C8490_TL84_500LUX_ISO800_Chart_tablecut.txt';
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
figure(43),imshow(uint8(255*double(NR_Raw_demosaiced)./65535)),title('BPC_NR2.0.01_0220_fix_Level_25_Depth_24_win1_sv2_sh19_C8490_TL84_500LUX_ISO800_Chart 0731 table cut and modified');
imwrite(uint8(255*double(NR_Raw_demosaiced)./65535),'Level_25_Depth_84_win1_sv2_sh19_C8490_TL84_500LUX_ISO800_Chart_tablecut.png');

%%

 denoised_file_name = '/home/h/DataDisk/ISP/BNR/NR2.0.0_FIX_tmp/deploy/outputs/BPC_NR2.0.01_0220_fix_Level_25_Depth_84_win1_sv2_sh19_C8490_TL84_500LUX_ISO800_Chart.txt';
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
figure(43),imshow(uint8(255*double(NR_Raw_demosaiced)./65535)),title('BPC_NR2.0.01_0220_fix_Level_25_Depth_24_win1_sv2_sh19_C8490_TL84_500LUX_ISO800_Chart 0620');
imwrite(uint8(255*double(NR_Raw_demosaiced)./65535),'Level_25_Depth_84_win1_sv2_sh19_C8490_TL84_500LUX_ISO800_Chart_0620.png');


%% original 
%
% ------------ different new test data for ISO ---------------- %
 denoised_file_name = '/home/h/DataDisk/ISP/BNR/NR2.0.0_FIX_20230728/deploy/eroded_NRBPC_3264_2448_2.txt';
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
figure(41),imshow(uint8(255*double(NR_Raw_demosaiced)./65535)),title('original');
% imwrite(uint8(255*double(NR_Raw_demosaiced)./65535),'original.png');



