fid1 = fopen('C5590_mirror_off_flip_off_output.raw');
input_off = fread(fid1,'uint16','ieee-le');
bpc_Raw_off = reshape(input_off,[1600,1200]);
bpc_Raw_off=bpc_Raw_off';

fid2 = fopen('C5590_mirror_on_flip_on_sensor_raw_output.raw');
input_on = fread(fid2,'uint16','ieee-le');
bpc_Raw_on = reshape(input_on,[1600,1200]);
bpc_Raw_on = bpc_Raw_on';

figure(1),imshow(bpc_Raw_off/1023);title('bpc Raw off')
figure(2),imshow(bpc_Raw_on/1023);title('bpc Raw on')

bpc_Raw_off_demosaiced = demosaic(uint16(65535*bpc_Raw_off/1023),'bggr');
bpc_Raw_off_demosaiced_float = double(bpc_Raw_off_demosaiced)./65535;

bpc_Raw_on_demosaiced = demosaic(uint16(65535*bpc_Raw_on/1023),'bggr');
bpc_Raw_on_demosaiced_float = double(bpc_Raw_on_demosaiced)./65535;
figure(3),imshow(bpc_Raw_off_demosaiced_float);title('Raw off before BPC');
figure(4),imshow(bpc_Raw_on_demosaiced_float);title('Raw on before BPC');

hot_th =8; cold_th = 8;
C=-0;
output_off = BPC_1line_V4(bpc_Raw_off,hot_th,cold_th,C);
output_on = BPC_1line_V4(bpc_Raw_on,hot_th,cold_th,C);

% Out_off_demosaiced = demosaic(output_off,'bggr');
% Out_on_demosaiced = demosaic(output_on,'bggr');
bpc_out_off_demosaiced = demosaic(uint16(65535*output_off/1023),'bggr');
bpc_out_off_demosaiced_float = double(bpc_out_off_demosaiced)./65535;
figure(5),imshow(bpc_out_off_demosaiced_float);title('bpc_out_off_demosaiced_float');
bpc_out_on_demosaiced = demosaic(uint16(65535*output_on/1023),'rggb');
bpc_out_on_demosaiced_float = double(bpc_out_on_demosaiced)./65535;
figure(6),imshow(bpc_out_on_demosaiced_float);title('bpc_out_on_demosaiced_float');

imwrite(bpc_out_on_demosaiced_float,'bpc_out_on_demosaiced_float_matlab_th=8c=0.png');
imwrite(bpc_out_on_demosaiced_float,'bpc_out_on_demosaiced_float_matlab_th=8c=0.png');


%% --- TEST C --- %%
% writematrix TO C
bpc_Raw_off_1d = bpc_Raw_off(:);
writematrix(bpc_Raw_off_1d,'bpc_Raw_off_1d.txt');
bpc_Raw_on_1d = bpc_Raw_on(:);
writematrix(bpc_Raw_on_1d,'bpc_Raw_on_1d.txt');
%READ FROM C OUTPUTs%
DPC_OUT_C_demosaiced = demosaic(uint16(65535*DPC_OUT_C/1023),'bggr');
DPC_OUT_C_demosaiced_float = double(DPC_OUT_C_demosaiced)./65535;
figure(7),imshow(DPC_OUT_C_demosaiced_float);title('DPC OUT C off demosaiced float');
%% READ FROM C OUTPUTs%
DPC_OUT_C_on =readmatrix('Out_C=1bpc_Raw_on_1d.txt');
DPC_OUT_C_on_demosaiced = demosaic(uint16(65535*DPC_OUT_C_on/1023),'rggb');
DPC_OUT_C_on_demosaiced_float = double(DPC_OUT_C_on_demosaiced)./65535;
figure(9),imshow(DPC_OUT_C_on_demosaiced_float);title('DPC OUT C=1 on demosaiced float');
imwrite(DPC_OUT_C_on_demosaiced_float,'DPC OUT C=1 on demosaiced float th=128.png');
%% READ FROM C OUTPUTs%
DPC_OUT_C_off =readmatrix('Out_C=1bpc_Raw_off_1d.txt');
DPC_OUT_C_off_demosaiced = demosaic(uint16(65535*DPC_OUT_C_off/1023),'bggr');
DPC_OUT_C_off_demosaiced_float = double(DPC_OUT_C_off_demosaiced)./65535;
figure(10),imshow(DPC_OUT_C_off_demosaiced_float);title('DPC OUT C=1 off demosaiced float');
imwrite(DPC_OUT_C_off_demosaiced_float,'DPC OUT C=1 off demosaiced float th=128.png');
%%
fid = fopen('bpcoff00.raw');
input_off = fread(fid,'uint16','ieee-le');
bpc_Raw_off = reshape(input_off,[2592,1944]);
bpc_Raw_off=bpc_Raw_off';
bpc_Raw_off_1d = bpc_Raw_off(:);
writematrix(bpc_Raw_off_1d,'bpc_Raw_off_all_1d.txt');
bpc_Raw_off_demosaiced = demosaic(uint16(65535*bpc_Raw_off/1023),'bggr');
bpc_Raw_off_demosaiced_float = double(bpc_Raw_off_demosaiced)./65535;
figure(1),imshow(bpc_Raw_off_demosaiced_float);title('bpc Raw off')
% bpc_Raw_on_1d = bpc_Raw_on(:);
% writematrix(bpc_Raw_on_1d,'bpc_Raw_on_1d.txt');
%READ FROM C OUTPUTs%
%%
%% READ FROM C OUTPUTs%
DPC_OUT_C_on =readmatrix('Out_C=1bpc_Raw_off_all_1d.txt');
DPC_OUT_C_on_demosaiced = demosaic(uint16(65535*DPC_OUT_C_on/1023),'bggr');
DPC_OUT_C_on_demosaiced_float = double(DPC_OUT_C_on_demosaiced)./65535;
figure(9),imshow(DPC_OUT_C_on_demosaiced_float);title('DPC OUT all C=1 on demosaiced float');
imwrite(DPC_OUT_C_on_demosaiced_float,'DPC OUT all C=1 on demosaiced float th=128.png');
%%
DPC_OUT_C_demosaiced = demosaic(uint16(65535*DPC_OUT_C/1023),'bggr');
DPC_OUT_C_demosaiced_float = double(DPC_OUT_C_demosaiced)./65535;
figure(2),imshow(DPC_OUT_C_demosaiced_float);title('DPC OUT C off demosaiced float');


