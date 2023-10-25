clc;
close all;
%fid = fopen('pRaw10_QIC.raw');
file = 'FrameID001_W1280_H720Mipi_Raw10_.raw';
file_name = file(1:end-4);
fid = fopen(file);
disp(file_name);

%fid = fopen('pRaw10_remozc.raw');
input = fread(fid,'uint16','ieee-le');
NR_Raw = reshape(input,[1280,720]);
NR_Raw = NR_Raw';