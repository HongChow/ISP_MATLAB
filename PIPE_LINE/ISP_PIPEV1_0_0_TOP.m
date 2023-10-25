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
    %fid = fopen('pRaw10_remozc.raw');
%     input = fread(fid,'uint16','ieee-le');
    input = fread(fid,'uint8','ieee-le');
    img = raw10img(input,2560,1440);
%     NR_Raw = reshape(input,[3264,2448]);
%     DATA_Raw = reshape(img,[2560,1440]);
 
     DATA_Raw = img;
%     writematrix(DATA_Raw,strcat(file_name,'.txt'),'Delimiter',' '); % SAVE RAw DATA to txt file 
    % ------------ Step1: BPC ------------- %
    % ------------ Step2: RAW NR ------------- %
    % ------------ Step3: Demosaicking ------------- %
    rgb_img_demosaked = demosaic(uint16(65535*DATA_Raw/1023),'bggr');
    rgb_img_demosaked_float=double(rgb_img_demosaked)/65535; % range 0-1
    % ------------ Step4: OB ------------- %
%     ob=[-119	-111	-115]/1024;
     ob=[0	0	0]/1024;
    
    rgb_img_demosaked_float_withOB = rgb_img_demosaked_float-64/1024;
    ob=[-64	-64	-64]/1024;
    rgb_demo = rgb_img_demosaked_float;
    rgb_demo = reshape(rgb_demo, size(rgb_demo,1)*size(rgb_demo,2),3);
    rgb_demo = rgb_demo';
    rgb_ob = rgb_demo+repmat(ob',1,size(rgb_demo,2));
    % ------------ Step5: GRAYWORLD AWB ------------- %
%     D=grayworld(rgb_img_demosaked_float);% RGB GAIN 
%     D=grayworld(rgb_img_demosaked_float);% RGB GAIN 
%     D = [1.1301 1 1.1028];
    
%     WB_image=diag(D)*(rgb_ob);
%     WB_image=min(max(WB_image,0),1);
    % ------------ Step5: CCM ------------- %
    ccm=[2.615221	-1.654988	0.039768
        -0.291468	1.550016	-0.258548
        0.055554	-0.990407	1.934853];
    CCM_image = ccm*rgb_ob;
    CCM_image=min(max(CCM_image,0),1);
    
    GAM_image= lin2rgb(CCM_image);
    GAM_image_dis=reshape(GAM_image',size(rgb_img_demosaked,1),size(rgb_img_demosaked,2),3);
    D = [1.2534e+04  1  4.0239];
    GAM_image_dis(:,:,1) = GAM_image_dis(:,:,1)*D(1);
    GAM_image_dis(:,:,2) = GAM_image_dis(:,:,2)*D(2);
    GAM_image_dis(:,:,3) = GAM_image_dis(:,:,3)*D(3);

    figure;imshow(GAM_image_dis);


    out_img = GAM_image_dis;
    return ;

end