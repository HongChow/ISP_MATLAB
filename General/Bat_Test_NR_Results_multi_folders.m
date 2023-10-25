%%  ---- 对文件夹及其子文件夹里面的文件进行遍历处理 ---- %　
top = dir('/home/h/DataDisk/ISP/BNR/NR2.0.0_FIX_20230905/Bat_Test/outputs_15/');
leng_top = length(top);
for fold_id = 1:leng_top
    if strcmp(top(fold_id).name, '.') || strcmp(top(fold_id).name, '..')
        continue;
    end
%     if top(fold_id).isdir == 0
%         continue;
%     end
    file_path = strcat(strcat(strcat(top(fold_id).folder,'/'),top(fold_id).name),'/');
%     file_path = strcat(strcat(top(fold_id).folder,'/'),top(fold_id).name);
    imgtxt_path_list = dir(strcat(file_path,'*.txt'));
    for i=1:length(imgtxt_path_list)
        imageTXT_name = imgtxt_path_list(i).name;
        fullTXT_name = strcat(file_path,imageTXT_name);
        imagePURE_name = imageTXT_name(1:end-4);
%         disp(imagePURE_name);
%         disp(imageTXT_name);
%         disp(fullTXT_name);
        denoised_png_name = strcat(imagePURE_name,'.png');
        fullPNG_name = strcat(file_path,denoised_png_name);
        disp(fullPNG_name);
% 
        denoised = readmatrix(fullTXT_name);
        % --- right method --- %
%       denoised = double(denoised)/1023;
%       NR_Raw_demosaiced = demosaic(uint16(65535*denoised/1023),'bggr');
        % --- to show method --- %
        basic_estimation_demosaic = demosaic(uint16(denoised),'bggr');
        temp = im2double(basic_estimation_demosaic);
        NR_Raw_demosaiced = uint8(temp*65535);

        % gray bayer to color bayer %
%         color_bayer_denoised = zeros(size(NR_Raw_demosaiced));
%         color_bayer_denoised_r = color_bayer_denoised(:,:,1);
%         color_bayer_denoised_g = color_bayer_denoised(:,:,2);
%         color_bayer_denoised_b = color_bayer_denoised(:,:,3);
%         
%         color_bayer_denoised_r(2:2:end,2:2:end) = denoised(2:2:end,2:2:end);
%         color_bayer_denoised_g(1:2:end,2:2:end) = denoised(1:2:end,2:2:end);
%         color_bayer_denoised_g(2:2:end,1:2:end) = denoised(2:2:end,1:2:end);
%         color_bayer_denoised_b(1:2:end,1:2:end) = denoised(1:2:end,1:2:end);
%         color_bayer_denoised = cat(3,color_bayer_denoised_r,color_bayer_denoised_g,color_bayer_denoised_b);
        % figure(3),imshow(uint8(color_bayer_denoised)),title('denoised bayer fSigma 16 win 1 sv4 sh7 before 3D');
        % figure(43),imshow(uint8(255*double(NR_Raw_demosaiced)./65535)),title('denoise demosaiced NR_in_C8490_TL84_30LUX_ISO6400_Chart fSigma 16 win 1 sv4 sh7 before');
          
        
%         imwrite(uint8(255*double(NR_Raw_demosaiced)./65535),fullPNG_name);
          imwrite(NR_Raw_demosaiced,fullPNG_name);

    end

end