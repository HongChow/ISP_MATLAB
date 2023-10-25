
    imgtxt_path = 'BPC_NR2.0.01_0220_fix_bpcEnable_1_nrEnable_1_Level_127_Depth_32_win1_sv4_sh15_Nbits_Linear_C8490_TL84_500LUX_ISO6400_Chart.txt';
    imagePURE_name = imgtxt_path(1:end-4);
    denoised_png_name = strcat(imagePURE_name,'.png');        
% 
    denoised = readmatrix(imgtxt_path);
    denoised = clip(denoised,0,1023);
        % --- right method --- %
%       denoised = double(denoised)/1023;
       denoised_demosaiced = demosaic(uint16(65535*denoised/1023),'bggr');
        % --- to show method --- %
        NR_Raw_demosaiced = uint8(255*double(denoised_demosaiced)./65535);

        
        % figure(3),imshow(uint8(color_bayer_denoised)),title('denoised bayer fSigma 16 win 1 sv4 sh7 before 3D');
        % figure(43),imshow(uint8(255*double(NR_Raw_demosaiced)./65535)),title('denoise demosaiced NR_in_C8490_TL84_30LUX_ISO6400_Chart fSigma 16 win 1 sv4 sh7 before');
          
        
%         imwrite(uint8(255*double(NR_Raw_demosaiced)./65535),fullPNG_name);
          imwrite(NR_Raw_demosaiced,denoised_png_name);
          figure(1),imshow(NR_Raw_demosaiced);title('linear fitting');