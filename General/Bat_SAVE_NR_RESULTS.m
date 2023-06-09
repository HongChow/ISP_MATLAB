%%
% ---- 对文件夹及其子文件夹里面的文件进行遍历处理 ---- %　
top = dir('/home/hong/BNR/BPC_NR2.0.0_for_RTL0504/NR2.0.0_FIX/deploy/outputs/');
leng_top = length(top);
for fold_id = 1:leng_top
    if strcmp(top(fold_id).name, '.') || strcmp(top(fold_id).name, '..')
        continue;
    end
    if top(fold_id).isdir == 0
        continue;
    end
    file_path = strcat(strcat(strcat(top(fold_id).folder,'/'),top(fold_id).name),'/');
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
%%

function Bat_Gain8
    clear;
    file_path = '/home/hong/QIC-Remosaic/Matlab/HongChow-Remosaic_Hong_Matlab2.0/NR_ISO_RESULTS/LUX30ISO200/';
    img_path_list = dir(strcat(file_path,'*.png'));
    for i=1:length(img_path_list)
        image_name = img_path_list(i).name;
        image =  imread(strcat(file_path,image_name)); 
        image_gain8 = 8*image;
        file_path_gain = strcat(file_path,'gain_8/');
        imwrite(image_gain8,strcat(file_path_gain,image_name));
    end
end



%%
top = dir('/media/hong/d59dbca9-decb-49d1-b040-7369ea65b8fa/home/hong/BNR/HongChow-Remosaic_Hong_Matlab2.0/NR_ISO_RESULTS_part1/LUX500ISO1500/');
leng_top = length(top);
for fold_id = 1:leng_top
    if strcmp(top(fold_id).name, '.') || strcmp(top(fold_id).name, '..')
        continue;
    end
    if top(fold_id).isdir == 0
        continue;
    end
    file_path = strcat(strcat(strcat(top(fold_id).folder,'/'),top(fold_id).name),'/');
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
        NR_Raw_demosaiced = demosaic(uint16(65535*denoised/1023),'bggr');
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
          imwrite(uint8(255*double(NR_Raw_demosaiced)./65535),fullPNG_name);

    end

end
%% -------------- gain on txt --------------%%
to_gain_path = '/home/hong/BNR/BPC_NR2.0.0_for_RTL0504/BPC_NR2.0.0_for_RTL/deploy/LUX30_ISO6400_LEVEL/';
imgtxt_path_list = dir(strcat(to_gain_path,'*.txt'));
for i=1:length(imgtxt_path_list)
    imageTXT_name = imgtxt_path_list(i).name;
    fullTXT_name = strcat(to_gain_path,imageTXT_name);
    imagePURE_name = imageTXT_name(1:end-4);
%         disp(imagePURE_name);
%         disp(imageTXT_name)
    disp(fullTXT_name);
    denoised_png_name = strcat(imagePURE_name,'_level.png');
    fullPNG_name = strcat(to_gain_path,denoised_png_name);
    disp(fullPNG_name);
% 
    denoised = readmatrix(fullTXT_name);
    NR_Raw_demosaiced = demosaic(uint16(65535*denoised/1023),'bggr');
    imwrite(uint8(255*double(NR_Raw_demosaiced)./65535),fullPNG_name);
end


%%
% function Bat_Save_NR_Results
% clear
% % file_path = '/home/hong/Deflare/Python/Data_Web/useful/';
% file_path = '/home/hong/Deflare/Python/to_wash_0117/Bad/';
% 
% %file_path = './TEST6/';
% close all;
% img_path_list = dir(strcat(file_path,'*.jpg'));
% for i=1:length(img_path_list)
%     disp('i=');
%     disp(i);
%     image_name = img_path_list(i).name;
%     disp('image_name=');
%     disp(image_name);
%     image =  imread(strcat(file_path,image_name));   
%     ori_image = image;
%     [h,w,~]=size(ori_image);   
%     if (h<w)
%         ori_image = rot90(ori_image);
%     end
%     left_corner = ori_image(end-899:end,1:900,:);
%     right_corner = ori_image(end-899:end,end-899:end,:);
%     imwrite(left_corner,strcat('roi_left_',image_name));
%     imwrite(right_corner,strcat('roi_right_',image_name));
%         
% end
% 
% 
% 
% 
% end