%%
clc;
close all;
%fid = fopen('pRaw10_QIC.raw');
file = 'C8490_TL84_30LUX_ISO800_Chart.raw';
file_name = file(1:end-4);
fid = fopen(file);
disp(file_name);

%fid = fopen('pRaw10_remozc.raw');
input = fread(fid,'uint16','ieee-le');
NR_Raw = reshape(input,[3264,2448]);
NR_Raw = NR_Raw';
% ------ 10bits raw ------- %
writematrix(NR_Raw,strcat(file_name,'.txt'),'Delimiter',' ');
% NR_Raw = flipud(NR_Raw);
NR_Raw_demosaiced = demosaic(uint16(65535*NR_Raw/1023),'bggr');
NR_Raw_demosaiced_float = double(NR_Raw_demosaiced)./65535;

figure,imshow(NR_Raw_demosaiced_float);

%% --------- Bat Write raw into txt for C code denoising -------- %%
file_path = '/home/hong/BNR/Datasets/NOISY_ISO_0306/deploy/LUX30_ISO400/';

%file_path = './TEST6/';
close all;
img_path_list = dir(strcat(file_path,'*.raw'));
for i=1:length(img_path_list)
    disp('i=');
    disp(i);
    image_name = img_path_list(i).name;
    disp('image_name=');
    disp(image_name);
    file_name = image_name(1:end-4);
    fid = fopen(strcat(file_path,image_name));
    input = fread(fid,'uint16','ieee-le');
    NR_Raw = reshape(input,[3264,2448]);
    NR_Raw = NR_Raw';
    % ------ 10bits raw ------- %
    %writematrix(NR_Raw,strcat(file_name,'.txt'),'Delimiter',' ');
    NR_Raw_demosaiced = demosaic(uint16(65535*NR_Raw/1023),'bggr');
    NR_Raw_demosaiced_float = double(NR_Raw_demosaiced)./65535;
    figure,imshow(NR_Raw_demosaiced_float);
    imwrite(NR_Raw_demosaiced_float,strcat(file_name,'_matlab_demosaiced.png'));
end

%% --------- Bat Write MIPI raw into txt for C code denoising -------- %%
file_path = '/home/hong/BNR/Datasets/NOISY_ISO_0306/deploy/LUX500_ISO800/';

%file_path = './TEST6/';
close all;
img_path_list = dir(strcat(file_path,'*.raw'));
for i=1:length(img_path_list)
    disp('i=');
    disp(i);
    image_name = img_path_list(i).name;
    disp('image_name=');
    disp(image_name);
    file_name = image_name(1:end-4);
    fid = fopen(strcat(file_path,image_name));
    input = fread(fid);
    fclose(fid);
    img = raw10img(input,width,height);
%     img=double(img);    

    % ------ 10bits raw ------- %
    writematrix(img,strcat(file_path,strcat(file_name,'.txt')),'Delimiter',' ');
%     NR_Raw_demosaiced = demosaic(uint16(65535*NR_Raw/1023),'bggr');
%     NR_Raw_demosaiced_float = double(NR_Raw_demosaiced)./65535;
%     figure,imshow(NR_Raw_demosaiced_float);
%     imwrite(NR_Raw_demosaiced_float,strcat(file_name,'_matlab_demosaiced.png'));
end
