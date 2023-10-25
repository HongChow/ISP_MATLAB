% ---- this is a simple ISP pipeline using matlab ---- %
addpath ../General/
input_raw_file_name = '../inputs_this/FrameID001_W2560_H1440Mipi_Raw10.raw';
out_img = ISP_PIPEV1_0_0(input_raw_file_name);
function [out_img] = ISP_PIPEV1_0_0(input_raw_file_name)
    clc;
    close all;
    %fid = fopen('pRaw10_QIC.raw');
    file = input_raw_file_name;
    file_name = file(1:end-4);
    fid = fopen(file);
    disp(file_name);
    % ---- blc on raw ---- %
    ob_r = 64;ob_b = 64;ob_g = 64;
    one_cycle = [ob_b ob_g
                 ob_g ob_r];
    all_ob = repmat(one_cycle,[1440/2 2560/2]);    
    %fid = fopen('pRaw10_remozc.raw');
%     input = fread(fid,'uint16','ieee-le');
    input = fread(fid,'uint8','ieee-le');
    img = raw10img(input,2560,1440);
%     NR_Raw = reshape(input,[3264,2448]);
%     DATA_Raw = reshape(img,[2560,1440]);
%      figure(1),imshow(img/1023),title('input');
     DATA_Raw_10 = img;
     img_ob = DATA_Raw_10 - all_ob;
     DATA_Raw = uint8(img_ob/1023*255);
     
%      figure(2),imshow(img/1023),title('input in 8 bits');
     rgb_img_demosaked = demosaic(DATA_Raw,'bggr');
%      figure(3);imshow(rgb_img_demosaked),title('demosaking in 8 bits');
%     writematrix(DATA_Raw,strcat(file_name,'.txt'),'Delimiter',' '); % SAVE RAw DATA to txt file 
    % ------------ Step1: BPC ------------- %
    % ------------ Step2: RAW NR ------------- %
    % ------------ Step3: Demosaicking ------------- %
     rgb_img_demosaked_float = im2double(rgb_img_demosaked);
%     figure(4);imshow(rgb_img_demosaked_float);title('rgb_img_demosaked_float');
     
    % ------------ Step4: OB ------------- %
%     ob=[-119	-111	-115]/1024;
        
    rgb_img_demosaked_float_withOB = rgb_img_demosaked_float-64/1024;
    ob1=[0 0 0]/1024;
    ob2=[0 0 0]/1024;
    rgb_demo = rgb_img_demosaked_float;
    rgb_demo = reshape(rgb_demo, size(rgb_demo,1)*size(rgb_demo,2),3);
    rgb_demo = rgb_demo';
    rgb_ob = rgb_demo+repmat(ob1',1,size(rgb_demo,2));
    rgb_ob2 = rgb_demo+repmat(ob2',1,size(rgb_demo,2));
    % ------------ Step5: GRAYWORLD AWB ------------- %
     D=grayworld(rgb_img_demosaked_float);% RGB GAIN 
%     D=grayworld(rgrgb_ob2b_img_demosaked_float);% RGB GAIN 
%     D = [1.1301 1 1.1028];
    
%     WB_image=diag(D)*(rgb_ob);
%     WB_image=min(max(WB_image,0),1);
    % ------------ Step5: CCM ------------- %
    ccm1=[2.615221	-1.654988	0.039768
        -0.291468	1.550016	-0.258548
        0.055554	-0.990407	1.934853];

    digital_gain = 4;
    rgb_ob = rgb_ob*digital_gain;
    ccm2=ones(3);
    CCM_image = rgb_ob;
    CCM_image=min(max(CCM_image,0),1);  
    GAM_image= lin2rgb(CCM_image);
    GAM_image_dis=reshape(GAM_image',size(rgb_img_demosaked,1),size(rgb_img_demosaked,2),3);
%     D = [1.2534e+04  1  4.0239];
%     D = [1.2534e+04  1  4.0239];
%     D = [1  1  1];
     
    Rroi = GAM_image_dis(83:601,1057:1767,1);
    Groi = GAM_image_dis(83:601,1057:1767,2);
    Broi = GAM_image_dis(83:601,1057:1767,3);
    Ravg = mean(mean(Rroi));
    Gavg = mean(mean(Groi));
    Bavg = mean(mean(Broi));
    Rgain = Gavg/Ravg;
    Bgain = Gavg/Bavg;
    D = [Rgain 1 Bgain];
    D=grayworld(GAM_image_dis);% RGB GAIN 
    GAM_image_dis(:,:,1) = GAM_image_dis(:,:,1)*D(1);
    GAM_image_dis(:,:,2) = GAM_image_dis(:,:,2)*D(2);
    GAM_image_dis(:,:,3) = GAM_image_dis(:,:,3)*D(3);
    %%
    CCM_image2 = rgb_ob2;
    CCM_image2=min(max(CCM_image2,0),1);
    GAM_image2= lin2rgb(CCM_image2);
    GAM_image_dis2=reshape(GAM_image2',size(rgb_img_demosaked,1),size(rgb_img_demosaked,2),3);
%     D = [1.2534e+04  1  4.0239];
%     D = [1.2534e+04  1  4.0239];
%     D = [1  1  1];

    Rroi = GAM_image_dis2(83:601,1057:1767,1);
    Groi = GAM_image_dis2(83:601,1057:1767,2);
    Broi = GAM_image_dis2(83:601,1057:1767,3);
    Ravg = mean(mean(Rroi));
    Gavg = mean(mean(Groi));
    Bavg = mean(mean(Broi));
    Rgain = Gavg/Ravg;
    Bgain = Gavg/Bavg;
    D = [Rgain 1 Bgain];
%     D = [2 1 1.6311];
    D=grayworld(GAM_image_dis2);% RGB GAIN 
    GAM_image_dis2(:,:,1) = GAM_image_dis2(:,:,1)*D(1);
    GAM_image_dis2(:,:,2) = GAM_image_dis2(:,:,2)*D(2);
    GAM_image_dis2(:,:,3) = GAM_image_dis2(:,:,3)*D(3);



%     figure;imshow(GAM_image_dis);
    figure;imshow(GAM_image_dis2);title('OB = 63 62 62 grayworld');


    out_img = GAM_image_dis;
    return ;

end