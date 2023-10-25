%%  ---- 对文件夹及其子文件夹里面的文件进行遍历处理 ---- %　
top = dir('/home/h/DataDisk/ISP/BNR/NR2.0.0_FIX_20230905/Bat_Test/outputs_Bat1_cmp/Nbits_all_30LUX_Gain/');
leng_top = length(top);
for fold_id = 1:leng_top
    if strcmp(top(fold_id).name, '.') || strcmp(top(fold_id).name, '..')
        continue;
    end
%     if top(fold_id).isdir == 0
%         continue;
%     end
    
    img_path = strcat(strcat(top(fold_id).folder,'/'),top(fold_id).name);
    imageTXT_name = top(fold_id).name;
    imagePURE_name = imageTXT_name(1:end-4);
    gain_png_name = strcat(imagePURE_name,'_gain8.png');
    fullPNG_name = strcat(strcat(top(fold_id).folder,'/'),gain_png_name);      
    disp(fullPNG_name);
    ori_img = imread(img_path);    
    gain_img = ori_img*8;
    imwrite(gain_img,fullPNG_name);

    

end