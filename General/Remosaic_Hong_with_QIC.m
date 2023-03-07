 % ------- Convert Quard Bayer to Traditional Bayer  -------%
% Author: Hong %
% Date : 2022-07-17 %
% function [Recovery_Bayer] = Remosaic_Hong(quard_bayer,radius,flag)
function [Recovery_Bayer] = Remosaic_Hong_with_QIC(quard_bayer)
% function Remosaic(quard_bayer)
    tic
    [h,w,~] = size(quard_bayer);
    quard_bayer = double(quard_bayer);
    Down_Bayer = double(zeros(size(quard_bayer)/2));
    G_intped_Up =  zeros(size(quard_bayer)); 
    R_intped_Up =  zeros(size(quard_bayer)); 
    B_intped_Up =  zeros(size(quard_bayer)); 
    Directions_Up = zeros(size(quard_bayer)); 
    Quard_Cell_W = w/4;
    Quard_Cell_H = h/4;
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
    MASK_B = repmat(mask_b,[Quard_Cell_H,Quard_Cell_W]);
    MASK_R = repmat(mask_r,[Quard_Cell_H,Quard_Cell_W]);
    MASK_Gb = repmat(mask_Gb,[Quard_Cell_H,Quard_Cell_W]);
    MASK_Gr = repmat(mask_Gr,[Quard_Cell_H,Quard_Cell_W]);
    MASK_G = MASK_Gr + MASK_Gb;
    
    for j = 1:h/2
        for i = 1:w/2
            Down_Bayer(j,i) = (quard_bayer(j*2,i*2)+quard_bayer(j*2-1,i*2)+quard_bayer(j*2,i*2-1)+quard_bayer(j*2-1,i*2-1));
        end
    end
    Down_Bayer = Down_Bayer/4;
    X = Down_Bayer;
    %X_rgb = demosaic(uint16(65535*X/1023),'bggr');
%     X_rgb = demosaic(uint8(X),'bggr');
%     figure,imshow(X_rgb),title('bin sample');
%     imwrite((X_rgb),'bin_sample_cista.png');
    % masks for Bayer pattern
    [RGB_inpted,directions] =  Demosaic_Hong_with_QIC(X,0);
    G_intped = RGB_inpted(:,:,2);
    R_intped = RGB_inpted(:,:,1);
    B_intped = RGB_inpted(:,:,3);
%     figure,imshow(uint8(RGB_inpted)),title('bin intp');
%     imwrite(uint8(RGB_inpted),'cista_bin_intp.png');
    Mr_Re  = zeros(size(quard_bayer)); Mr_Re(2:2:end,2:2:end) = 1;   % 0:not red,  1:red
    Mb_Re  = zeros(size(quard_bayer)); Mb_Re(1:2:end,1:2:end) = 1;   % 0:not blue, 1:blue
    Mg1_Re = zeros(size(quard_bayer)); Mg1_Re(1:2:end,2:2:end) = 1;  % 0: not G1,  1:G1
    Mg2_Re = zeros(size(quard_bayer)); Mg2_Re(2:2:end,1:2:end) = 1;  % 0: not G2,  1:G2
    Mg_Re = Mg1_Re+Mg2_Re;   
    
    Directions_Up(1:2:end,1:2:end) = directions;
    Directions_Up(2:2:end,1:2:end) = directions;
    Directions_Up(2:2:end,2:2:end) = directions;
    Directions_Up(1:2:end,2:2:end) = directions;
    
    G_intped_Up(1:2:end,1:2:end) = G_intped;
    G_intped_Up(2:2:end,1:2:end) = G_intped;
    G_intped_Up(2:2:end,2:2:end) = G_intped;
    G_intped_Up(1:2:end,2:2:end) = G_intped;
    
    R_intped_Up(1:2:end,1:2:end) = R_intped;
    R_intped_Up(2:2:end,1:2:end) = R_intped;
    R_intped_Up(2:2:end,2:2:end) = R_intped;
    R_intped_Up(1:2:end,2:2:end) = R_intped;
    
    B_intped_Up(1:2:end,1:2:end) = B_intped;
    B_intped_Up(2:2:end,1:2:end) = B_intped;
    B_intped_Up(2:2:end,2:2:end) = B_intped;
    B_intped_Up(1:2:end,2:2:end) = B_intped;
    
    % -------low pass filter for flat area ------- %
    left_up = [0 0 0
               0 1 1
               0 1 1]/4;
    right_up = [0 0 0
                1 1 0
                1 1 0]/4;
    left_down = [0 1 1
                 0 1 1
                 0 0 0]/4;
    right_down = [1 1 0
                  1 1 0
                  0 0 0]/4;
    left_up_G = conv2(G_intped_Up,left_up,'same');
    right_up_G = conv2(G_intped_Up,right_up,'same');
    left_down_G = conv2(G_intped_Up,left_down,'same');
    right_down_G = conv2(G_intped_Up,right_down,'same');
    
    left_up_R = conv2(R_intped_Up,left_up,'same');
    right_up_R = conv2(R_intped_Up,right_up,'same');
    left_down_R = conv2(R_intped_Up,left_down,'same');
    right_down_R = conv2(R_intped_Up,right_down,'same');
    
    left_up_B = conv2(B_intped_Up,left_up,'same');
    right_up_B = conv2(B_intped_Up,right_up,'same');
    left_down_B = conv2(B_intped_Up,left_down,'same');
    right_down_B = conv2(B_intped_Up,right_down,'same');
    
    B_direction0_up = B_intped_Up;
    B_direction0_up(1:4:end,1:4:end) = left_up_B(1:4:end,1:4:end);
    B_direction0_up(1:4:end,2:4:end) = right_up_B(1:4:end,2:4:end);
    B_direction0_up(2:4:end,1:4:end) = left_down_B(2:4:end,1:4:end);
    B_direction0_up(2:4:end,2:4:end) = right_down_B(2:4:end,2:4:end);
    R_direction0_up = R_intped_Up;
    R_direction0_up(3:4:end,3:4:end) = left_up_R(3:4:end,3:4:end);
    R_direction0_up(3:4:end,4:4:end) = right_up_R(1:4:end,2:4:end);
    R_direction0_up(4:4:end,3:4:end) = left_down_R(2:4:end,1:4:end);
    R_direction0_up(4:4:end,4:4:end) = right_down_R(2:4:end,2:4:end);
    
    G_direction0_up = G_intped_Up;
    G_direction0_up(1:4:end,3:4:end) = left_up_G(1:4:end,3:4:end);
    G_direction0_up(1:4:end,4:4:end) = right_up_G(1:4:end,4:4:end);
    G_direction0_up(2:4:end,3:4:end) = left_down_G(2:4:end,3:4:end);
    G_direction0_up(2:4:end,4:4:end) = right_down_G(2:4:end,4:4:end);
   
    G_direction0_up(3:4:end,1:4:end) = left_up_G(3:4:end,1:4:end);
    G_direction0_up(3:4:end,2:4:end) = right_up_G(3:4:end,2:4:end);
    G_direction0_up(4:4:end,1:4:end) = left_down_G(4:4:end,1:4:end);
    G_direction0_up(4:4:end,2:4:end) = right_down_G(4:4:end,2:4:end);

%     Recovery_Bayer = quard_bayer;
    Recovery_Bayer_R = quard_bayer;
    Recovery_Bayer_G = quard_bayer;
    Recovery_Bayer_B = quard_bayer;
    Recovery_Bayer_R(Directions_Up==0.5) = R_direction0_up(Directions_Up==0.5);
    Recovery_Bayer_G(Directions_Up==0.5) = G_direction0_up(Directions_Up==0.5);
    Recovery_Bayer_B(Directions_Up==0.5) = B_direction0_up(Directions_Up==0.5);
    
    quard_bayer = Recovery_Bayer_R.*MASK_R + Recovery_Bayer_G.*MASK_G +Recovery_Bayer_B.*MASK_B;

    Recovery_Bayer_R(MASK_B==1) =  R_intped_Up(MASK_B==1) + (quard_bayer(MASK_B==1))-B_intped_Up(MASK_B==1);
    Recovery_Bayer_R(MASK_G==1) =  R_intped_Up(MASK_G==1) + (quard_bayer(MASK_G==1))-G_intped_Up(MASK_G==1);
    
    Recovery_Bayer_B(MASK_R==1) =  B_intped_Up(MASK_R==1) + (quard_bayer(MASK_R==1))-R_intped_Up(MASK_R==1);  
    Recovery_Bayer_B(MASK_G==1) =  B_intped_Up(MASK_G==1) + (quard_bayer(MASK_G==1))-G_intped_Up(MASK_G==1);
    
    Recovery_Bayer_G(MASK_B==1) =  G_intped_Up(MASK_B==1) + (quard_bayer(MASK_B==1))-B_intped_Up(MASK_B==1);
    Recovery_Bayer_G(MASK_R==1) =  G_intped_Up(MASK_R==1) + (quard_bayer(MASK_R==1))-R_intped_Up(MASK_R==1);

%     Recovery_Bayer_R = clip(Recovery_Bayer_R,0,255);
%     Recovery_Bayer_G = clip(Recovery_Bayer_G,0,255);
%     Recovery_Bayer_B = clip(Recovery_Bayer_B,0,255);
    Recovery_Bayer = Recovery_Bayer_R.*Mr_Re + Recovery_Bayer_G.*Mg_Re + Recovery_Bayer_B.*Mb_Re;
%     Recovery_Bayer_RGB = zeros([h,w,3]);
%     Recovery_Bayer_RGB(:,:,1) = Recovery_Bayer_R.*Mr_Re;
%     Recovery_Bayer_RGB(:,:,2) = Recovery_Bayer_G.*Mg_Re;
%     Recovery_Bayer_RGB(:,:,3) = Recovery_Bayer_B.*Mb_Re;
%     imwrite(uint8(Recovery_Bayer_RGB/1023*255),'Recovery_Bayer_CISTA_3X3_wo.png');
%     figure,imshow(uint8(Recovery_Bayer_RGB/1023*255)),title('Recovery Bayer RGB.png');
    Recovery_Bayer = clip(Recovery_Bayer,0,1023);
%     Recovery_Bayer = uint16(Recovery_Bayer);
    toc
    disp('end');
end
function [Y] = clip(X,lo,hi)
Y = X;
Y(X<lo)=lo;
Y(X>hi)=hi;
end