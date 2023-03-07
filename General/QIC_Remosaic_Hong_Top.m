% --------- QIC-Remosaic ---------- %
clc;
close all;
%fid = fopen('pRaw10_QIC.raw');
fid = fopen('4cell-OriginalRawBuf_4656x3504.raw');
%fid = fopen('pRaw10_remozc.raw');
input = fread(fid,'uint16','ieee-le');
four_cell_Raw = reshape(input,[4656,3504]);
four_cell_Raw = four_cell_Raw';% before QIC
% ------------- BLC ------------- %%
four_cell_Raw =  four_cell_Raw;
four_cell_Raw = clip(four_cell_Raw-64,0,1023);
four_cell_Reorder = four_cell_Raw ;
% ----------- ReOrder --------- %%

four_cell_Reorder(1:4:end,2:4:end) = four_cell_Raw(1:4:end,3:4:end);
four_cell_Reorder(1:4:end,3:4:end) = four_cell_Raw(1:4:end,2:4:end);
four_cell_Reorder(4:4:end,2:4:end) = four_cell_Raw(4:4:end,3:4:end);
four_cell_Reorder(4:4:end,3:4:end) = four_cell_Raw(4:4:end,2:4:end);

four_cell_Reorder(2:4:end,1:4:end) = four_cell_Raw(3:4:end,1:4:end);
four_cell_Reorder(3:4:end,1:4:end) = four_cell_Raw(2:4:end,1:4:end);
four_cell_Reorder(2:4:end,4:4:end) = four_cell_Raw(3:4:end,4:4:end);
four_cell_Reorder(3:4:end,4:4:end) = four_cell_Raw(2:4:end,4:4:end);

four_cell_Reorder(2:4:end,2:4:end) = four_cell_Raw(3:4:end,3:4:end);
four_cell_Reorder(3:4:end,3:4:end) = four_cell_Raw(2:4:end,2:4:end);
four_cell_Reorder(3:4:end,2:4:end) = four_cell_Raw(2:4:end,3:4:end);
four_cell_Reorder(2:4:end,3:4:end) = four_cell_Raw(3:4:end,2:4:end);
clear four_cell_Raw
%% -------------- Remosaic with calibration8 ------------- %

Recovery_Bayer_QIC8 = Remosaic_Hong_with_QIC8(four_cell_Reorder);
%
% Recovery_RGB_QIC7_Hong = Demosaic_Hong_display(Recovery_Bayer_QIC7,0);
% Recovery_RGB_QIC7_Hong = fliplr(Recovery_RGB_QIC7_Hong);
% demosaic_qic7_hong = Recovery_RGB_QIC7_Hong;
% demosaic_qic7_hong = double(demosaic_qic7_hong)./1023;
% figure,imshow(uint8(demosaic_qic7_hong*255.0*4)),title('QIC and Remosaic 7.0 and Demosaic flip without BLC')
%% -------------- Remosaic with calibration7 ------------- %
Recovery_Bayer_QIC7 = Remosaic_Hong_with_QIC7(four_cell_Reorder);
%
% Recovery_RGB_QIC7_Hong = Demosaic_Hong_display(Recovery_Bayer_QIC7,0);
% Recovery_RGB_QIC7_Hong = fliplr(Recovery_RGB_QIC7_Hong);
% demosaic_qic7_hong = Recovery_RGB_QIC7_Hong;
% demosaic_qic7_hong = double(demosaic_qic7_hong)./1023;
% figure,imshow(uint8(demosaic_qic7_hong*255.0*4)),title('QIC and Remosaic 7.0 and Demosaic flip without BLC')
%% -------------- Remosaic with calibration6 ------------- %

Recovery_Bayer_QIC6 = Remosaic_Hong_with_QIC6(four_cell_Reorder);
%
% Recovery_RGB_QIC5_Hong = Demosaic_Hong_display(Recovery_Bayer_QIC5,0);
% Recovery_RGB_QIC5_Hong = fliplr(Recovery_RGB_QIC5_Hong);
% demosaic_qic5_hong = Recovery_RGB_QIC5_Hong;
% demosaic_qic5_hong = double(demosaic_qic5_hong)./1023;
% figure,imshow(uint8(demosaic_qic5_hong*255.0*4)),title('QIC and Remosaic 6.0 and Demosaic flip without BLC')



%% -------------- Remosaic with calibration5 ------------- %
Recovery_Bayer_QIC5 = Remosaic_Hong_with_QIC5(four_cell_Reorder);
%
Recovery_RGB_QIC5_Hong = Demosaic_Hong_display(Recovery_Bayer_QIC5,0);
Recovery_RGB_QIC5_Hong = fliplr(Recovery_RGB_QIC5_Hong);
demosaic_qic5_hong = Recovery_RGB_QIC5_Hong;
demosaic_qic5_hong = double(demosaic_qic5_hong)./1023;
figure,imshow(uint8(demosaic_qic5_hong*255.0*4)),title('QIC and Remosaic 5.0 and Demosaic flip with BLC')
%% -------------- Remosaic with calibration4 ------------- %
Recovery_Bayer_QIC4 = Remosaic_Hong_with_QIC4(four_cell_Reorder);
%
Recovery_RGB_QIC4_Hong = Demosaic_Hong_display(Recovery_Bayer_QIC4,0);
Recovery_RGB_QIC4_Hong = fliplr(Recovery_RGB_QIC4_Hong);
demosaic_qic4_hong = Recovery_RGB_QIC4_Hong;
demosaic_qic4_hong = double(demosaic_qic4_hong)./1023;
figure,imshow(uint8(demosaic_qic4_hong*255.0*4)),title('QIC and Remosaic 4.0 and Demosaic flip with BLC')
%%
%Recovery_Bayer3D = GrayBayer2Bayer3D(Recovery_Bayer,'Recovery_Bayer3D');
Recovery_RGB_QIC4 = demosaic(uint16(65535*Recovery_Bayer_QIC4/1023),'bggr');
demosaic_qic4 = fliplr(Recovery_RGB_QIC4);
demosaic_qic4 = double(demosaic_qic4)./65535;
figure,imshow(uint8(demosaic_qic4*255.0*4)),title('test4-0 WO FCC2 QIC3 Reorder and Remosaic and Demosaic flip with BLC')
%imwrite(uint8(demosaic_qic4*255.0*4)),title('QIC1.3 and Remosaic1.0 and Demosaic flip with BLC')
%%
Recovery_RGB_QIC4_Hong = Demosaic_Hong_display(Recovery_RGB_QIC4,0);
Recovery_RGB_QIC4_Hong = fliplr(Recovery_RGB_QIC4_Hong);
demosaic_qic4_hong = Recovery_RGB_QIC4_Hong;
demosaic_qic4_hong = double(demosaic_qic4_hong)./1023;
figure,imshow(uint8(demosaic_qic4_hong*255.0*4)),title('QIC1.2 and Remosaic1.0 and Demosaic flip with BLC')
%imwrite(uint8(demosaic_qic3*255.0*4),'QIC1.2 and Remosaic1.0 and Demosaic flip with BLC.png')
%imwrite(uint8(demosaic_hong*255*4),'test QIC Reorder and Remosaic2 and Demosaic flip.png')
%imwrite(uint8(demosaic_hong*255*4),'test5 Remosaic AND QIC with BLC .png')
%% -------------- Remosaic with calibration2 ------------- %
Recovery_Bayer_QIC2 = Remosaic_Hong_with_QIC2(four_cell_Reorder);

%Recovery_Bayer3D = GrayBayer2Bayer3D(Recovery_Bayer,'Recovery_Bayer3D');
% Recovery_RGB_Hong =  Demosaic_Hong(Recovery_Bayer,0);
Recovery_RGB_QIC2 = demosaic(uint16(65535*Recovery_Bayer_QIC2/1023),'bggr');
demosaic_qic2 = fliplr(Recovery_RGB_QIC2);
demosaic_qic2 = double(demosaic_qic2)./65535;
%%demosaic_hong = fliplr(Recovery_RGB_Hong);
% demosaic_hong = Recovery_RGB_Hong;
% demosaic_hong = double(demosaic_hong)./1023;
figure,imshow(uint8(demosaic_qic2*255.0*4)),title('QIC1.0 and Remosaic1.0 and Demosaic Matlab')
imwrite(uint8(demosaic_qic2*255.0*4),'QIC1.0 and Remosaic1.0 and Demosaic Matlab.png')
%imwrite(uint8(demosaic_hong*255*4),'test5 Remosaic AND QIC with BLC .png')

%% -------------- Remosaic with calibration3 ------------- %
Recovery_Bayer_QIC3 = Remosaic_Hong_with_QIC3(four_cell_Reorder);
%% -------------- Remosaic with calibrationM3 ------------- %
Recovery_Bayer_QICM3 = Remosaic_Hong_with_QICM3(four_cell_Reorder);
%%
%Recovery_Bayer3D = GrayBayer2Bayer3D(Recovery_Bayer,'Recovery_Bayer3D');
Recovery_RGB_QIC3 = demosaic(uint16(65535*Recovery_Bayer_QIC3/1023),'bggr');
demosaic_qic3 = fliplr(Recovery_RGB_QIC3);
demosaic_qic3 = double(demosaic_qic3)./65535;
figure,imshow(uint8(demosaic_qic3*255.0*4)),title('test3-0 WO FCC2 QIC3 Reorder and Remosaic2 and Demosaic flip with BLC')
imwrite(uint8(demosaic_qic3*255.0*4)),title('QIC1.2 and Remosaic1.0 and Demosaic flip with BLC')
%%
Recovery_RGB_QIC3_Hong = Demosaic_Hong_display(Recovery_Bayer_QIC3,0);
Recovery_RGB_QIC3_Hong = fliplr(Recovery_RGB_QIC3_Hong);
demosaic_qic3_hong = Recovery_RGB_QIC3_Hong;
demosaic_qic3_hong = double(demosaic_qic3_hong)./1023;
figure,imshow(uint8(demosaic_qic3_hong*255.0*4)),title('QIC1.2 and Remosaic1.0 and Demosaic flip with BLC')
imwrite(uint8(demosaic_qic3_hong*255.0*4),'Mode3_with_lp.png')
%imwrite(uint8(demosaic_hong*255*4),'test QIC Reorder and Remosaic2 and Demosaic flip.png')
%imwrite(uint8(demosaic_hong*255*4),'test5 Remosaic AND QIC with BLC .png')

%% -------------- Remosaic witout calibration ------------- %
Recovery_Bayer_wo_QIC = Remosaic_Hong(four_cell_Reorder);
%     Recovery_Bayer3D = GrayBayer2Bayer3D(Recovery_Bayer,'Recovery_Bayer3D');
% Recovery_RGB_wo_QIC = demosaic(uint16(65535*Recovery_Bayer_wo_QIC/1023),'bggr');
% Recovery_RGB_wo_QIC = fliplr(Recovery_RGB_wo_QIC);
% Recovery_RGB_wo_QIC = double(Recovery_RGB_wo_QIC)./65535;
% figure,imshow(uint8(Recovery_RGB_wo_QIC*255.0*4)),title('test0 QIC Reorder and Remosaic2 and Demosaic flip with BLC')

Recovery_RGB_wo_QIC_Hong =  Demosaic_Hong_display(Recovery_Bayer_wo_QIC,0);
Recovery_RGB_wo_QIC_Hong = fliplr(Recovery_RGB_wo_QIC_Hong);
Recovery_RGB_wo_QIC_Hong = double(Recovery_RGB_wo_QIC_Hong)./1023;
figure,imshow(uint8(Recovery_RGB_wo_QIC_Hong*255.0*4)),title('test0-2 only Reorder and Remosaic2 and Demosaic flip with BLC')
imwrite(uint8(Recovery_RGB_wo_QIC_Hong*255.0*4),'only Reorder and Remosaic1.0 and Demosaic flip with BLC.png')

%%demosaic_hong = fliplr(Recovery_RGB_Hong);
% Recovery_RGB_Hong =  Demosaic_Hong(Recovery_Bayer,0);
% demosaic_hong = Recovery_RGB_Hong;

% %demosaic_hong = double(demosaic_hong)./1023;
% figure,imshow(uint8(demosaic_hong*255.0*4)),title('test1_1 NO QIC Reorder and Remosaic2 and Demosaic flip with BLC')
%imwrite(uint8(demosaic_hong*255*4),'test QIC Reorder and Remosaic2 and Demosaic flip.png')
% imwrite(uint8(demosaic_hong*255*4),'test1_1 NO Remosaic AND QIC with BLC .png')
%% -------------- Remosaic with calibration1 ------------- %Recovery_Bayer = Remosaic_Hong_with_QIC(four_cell_Reorder);
Recovery_Bayer = Remosaic_Hong_with_QIC(four_cell_Reorder);
Recovery_Bayer3D = GrayBayer2Bayer3D(Recovery_Bayer,'Recovery_Bayer3D');
%Recovery_RGB_Hong =  Demosaic_Hong(Recovery_Bayer,0);
Recovery_RGB_Hong = Demosaic_Hong_display(Recovery_Bayer,0);
demosaic_hong = fliplr(Recovery_RGB_Hong);
demosaic_hong = double(demosaic_hong)/1023;
%demosaic_hong = fliplr(Recovery_RGB_Hong);
%demosaic_hong = Recovery_RGB_Hong;
%demosaic_hong = double(demosaic_hong)./1023;
figure,imshow(uint8(demosaic_hong*255.0*4)),title('test-new1-3QIC Reorder and Remosaic2 and Demosaic flip with BLC')
%imwrite(uint8(demosaic_hong*255*4),'test QIC Reorder and Remosaic2 and Demosaic flip.png')
imwrite(uint8(demosaic_hong*255*4),'testnew1-3 Remosaic AND QIC with BLC .png')
%% ------------- QIC ------------- %
h_diff = [-1 0 1];
v_diff = h_diff';
sum_diff = [0 1 0
            1 0 1
            0 1 0]/4;
h_avg = [1 0 1 0 1]/3;
v_avg = h_avg';
        
H_Diff2D = conv2(Recovery_Bayer,h_diff,'same');
H_Diff2D = abs(H_Diff2D);
V_Diff2D = conv2(Recovery_Bayer,v_diff,'same');
V_Diff2D = abs(V_Diff2D);
% ----------- Consider G Plane ---------- % 
sum_H = conv2(H_Diff2D,sum_diff,'same');
sum_V = conv2(V_Diff2D,sum_diff,'same');
Directions = zeros(size(Recovery_Bayer));
Th1 = 15; % 10bits for 12bits Th1=180
Directions((sum_H>=sum_V)&(sum_H>Th1))=1;% V direction
Directions((sum_H<sum_V)&(sum_V>Th1))=2; % H direction
sum_E = (sum_H+sum_V)/2;
Weights = zeros(size(Recovery_Bayer));
Weight_Max = 1.0;
TH2_low = 20;
TH2_high = 45;
Weights(sum_E<TH2_low) = Weight_Max;
Weights(sum_E>=TH2_high) = 0;
Weights((sum_E>=TH2_low)&(sum_E<TH2_high)) = (TH2_high-sum_E((sum_E>=TH2_low)&(sum_E<TH2_high)) )*Weight_Max/(TH2_high-TH2_low);
%%
G_V = conv2(Recovery_Bayer,v_avg,'same');
G_H = conv2(Recovery_Bayer,h_avg,'same');
Recovery_Bayer_QIC = Recovery_Bayer;
Delt_H = Weights.*(G_V-G_H);
Delt_V = Weights.*(G_H-G_V);
Recovery_Bayer_QIC = Recovery_Bayer_QIC+ Delt_V.*(Directions==1)+ Delt_H.*(Directions==2);
Recovery_Bayer_QIC3D = GrayBayer2Bayer3D(Recovery_Bayer_QIC,'Recovery_Bayer_QIC3D');

%% ------ Disp ------ %%
Recovery_RGB_QIC_Hong =  Demosaic_Hong(Recovery_Bayer_QIC,0);
% Recovery_RGB_Hong = demosaic(uint16(65535*Recovery_Bayer/1023),'bggr');
% demosaic_hong = fliplr(Recovery_RGB_Hong);
% demosaic_hong = double(demosaic_hong)./65535;
%demosaic_hong = fliplr(Recovery_RGB_Hong);
demosaic_QIC_Remosaic_hong = Recovery_RGB_QIC_Hong;
demosaic_QIC_Remosaic_hong = double(demosaic_QIC_Remosaic_hong)./1023;
figure,imshow(uint8(demosaic_QIC_Remosaic_hong*255*4)),title('test QIC and Remosaic with BLC')
%imwrite(uint8(demosaic_hong*255*4),'test QIC Reorder and Remosaic2 and Demosaic flip.png')
imwrite(uint8(demosaic_QIC_Remosaic_hong*255*4),'test QIC and Remosaic.png')