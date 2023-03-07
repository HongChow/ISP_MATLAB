clc;
close all;
%fid = fopen('pRaw10_QIC.raw');
fid = fopen('4cell-OriginalRawBuf_4656x3504.raw');
input = fread(fid,'uint16','ieee-le');
four_cell_Raw = reshape(input,[4656,3504]);
four_cell_Raw = four_cell_Raw';% before QIC
% ------------- BLC ------------- %
four_cell_Raw =  four_cell_Raw -64;
four_cell_Raw = clip(four_cell_Raw,0,1023);
four_cell_Reorder = four_cell_Raw ;
% % ----------- ReOrder --------- %

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
% -------------- QIC or GIC ------ %

%% -------- Show Quad Bayer Image ------------ %
%
    mask_b = [1 1 0 0;
              1 1 0 0;
              0 0 0 0;
              0 0 0 0;];
    mask_r = [0 0 0 0;
              0 0 0 0;
              0 0 1 1;
              0 0 1 1;];  

    mask_Gb = [0 0 1 1;
              0 0 1 1;
              0 0 0 0;
              0 0 0 0;];
    mask_Gr = [0 0 0 0;
              0 0 0 0;
              1 1 0 0;
              1 1 0 0;];
Quard_Cell_W = 4656/4;
Quard_Cell_H = 3504/4;
    MASK_B = repmat(mask_b,[Quard_Cell_H,Quard_Cell_W]);
    MASK_R = repmat(mask_r,[Quard_Cell_H,Quard_Cell_W]);
    MASK_Gb = repmat(mask_Gb,[Quard_Cell_H,Quard_Cell_W]);
    MASK_Gr = repmat(mask_Gr,[Quard_Cell_H,Quard_Cell_W]);
    quard_bayer_R = (MASK_R).*four_cell_Reorder;
    quard_bayer_B = (MASK_B).*four_cell_Reorder;
    quard_bayer_G = (MASK_Gb).*four_cell_Reorder+(MASK_Gr).*four_cell_Reorder;
quad_bayer = cat(3,quard_bayer_R,quard_bayer_G,quard_bayer_B);
figure,imshow(uint8(4*quad_bayer/1023.0*255));title('quad bayer after Reorder BLC ');
%%
quad_bayer = four_cell_Reorder;
Down_Bayer = double(zeros(size(quad_bayer)/2));
half_w = 4656/2;
half_h = 3504/2;
    for j = 1:3504/2
        for i = 1:4656/2
            Down_Bayer(j,i) = (quad_bayer(j*2,i*2)+quad_bayer(j*2-1,i*2)+quad_bayer(j*2,i*2-1)+quad_bayer(j*2-1,i*2-1));
        end
    end
    Down_Bayer = Down_Bayer/4;
X = Down_Bayer;
figure,imshow(uint8(demosaic_hong*255*4)),title('test QIC Reorder and Remosaic and Demosaic flip')
X_Bayer3D = zeros(half_h,half_w,3);
X_Bayer3D(1:2:end,1:2:end,3) = X(1:2:end,1:2:end);
X_Bayer3D(2:2:end,2:2:end,1) = X(2:2:end,2:2:end);
X_Bayer3D(1:2:end,2:2:end,2) = X(1:2:end,2:2:end);
X_Bayer3D(2:2:end,1:2:end,2) = X(2:2:end,1:2:end);

figure,imshow(uint8(4*X_Bayer3D/1023.0*255));title('Bin Bayer');
%%    
%-------------- Renosaic ------------- %
Recovery_Bayer = Remosaic_Hong(four_cell_Reorder);
[Bayer3D] = GrayBayer2Bayer3D(Recovery_Bayer);
%%
%Recovery_RGB_Hong = Demosaic_Hong3x3(Recovery_Bayer);
Recovery_RGB_Hong =  Demosaic_Hong(Recovery_Bayer,0);
% Recovery_RGB_Hong = demosaic(uint16(65535*Recovery_Bayer/1023),'bggr');
% demosaic_hong = fliplr(Recovery_RGB_Hong);
% demosaic_hong = double(demosaic_hong)./65535;
%demosaic_hong = fliplr(Recovery_RGB_Hong);
demosaic_hong = Recovery_RGB_Hong;
demosaic_hong = double(demosaic_hong)./1023;
figure,imshow(uint8(demosaic_hong*255*4)),title('test QIC Reorder and Remosaic2 and Demosaic flip with BLC')
%imwrite(uint8(demosaic_hong*255*4),'test QIC Reorder and Remosaic2 and Demosaic flip.png')
imwrite(uint8(demosaic_hong*255*4),'test Remosaic with BLC.png')


% ------------ Gb Gr Correction ----------- %


