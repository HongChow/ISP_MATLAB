 % ------- Convert Quard Bayer to Traditional Bayer  -------%
% Author: Hong %
% Date : 2022-07-17 %
% function [Recovery_Bayer] = Remosaic_Hong(quard_bayer,radius,flag)
function [Recovery_Bayer] = Remosaic_Hong_with_QIC3(quard_bayer)
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
    [RGB_inpted,directions] =  Demosaic_Hong_with_QIC3(X,0);
    G_intped = RGB_inpted(:,:,2);
    R_intped = RGB_inpted(:,:,1);
    B_intped = RGB_inpted(:,:,3);
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
%     Recovery_Bayer = quard_bayer;
    Down_Bayer_Up = zeros(size(quard_bayer));
    Down_Bayer_Up(1:2:end,1:2:end) = Down_Bayer;
    Down_Bayer_Up(2:2:end,1:2:end) = Down_Bayer;
    Down_Bayer_Up(2:2:end,2:2:end) = Down_Bayer;
    Down_Bayer_Up(1:2:end,2:2:end) = Down_Bayer;
    Delt_Bayer = abs(quard_bayer - Down_Bayer_Up)./Down_Bayer_Up;
    W = zeros(size(Delt_Bayer));
%     W(Delt_Bayer<=0.2) = 1-Delt_Bayer(Delt_Bayer<=0.2);
%     W((0.2<Delt_Bayer)&(Delt_Bayer<=0.3)) = -5.5*(Delt_Bayer((0.2<Delt_Bayer)&(Delt_Bayer<=0.3)))+1.9;
%     W((0.3<Delt_Bayer)&(Delt_Bayer<=0.38)) = -3.125*(Delt_Bayer((0.3<Delt_Bayer)&(Delt_Bayer<=0.38))) + 1.1875;
%     W(Delt_Bayer<=0.4) = 1-0.5*Delt_Bayer(Delt_Bayer<=0.4);    
%     W((0.4<Delt_Bayer)&(Delt_Bayer<=0.5)) = -8*(Delt_Bayer((0.4<Delt_Bayer)&(Delt_Bayer<=0.5)))+4;   
% 
%     qic_bayer = quard_bayer - (quard_bayer -Down_Bayer_Up ).*W;
%     figure,imshow(uint8(qic_bayer));title('qic_bayer')
%     figure,imshow(Delt_Bayer);title('Down_Bayer_Up')
    %error('暂停Debug');
    %quard_bayer = qic_bayer;
    Recovery_Bayer_R = quard_bayer;
    Recovery_Bayer_G = quard_bayer;
    Recovery_Bayer_B = quard_bayer;

    Recovery_Bayer_R(MASK_B==1) =  R_intped_Up(MASK_B==1) + (quard_bayer(MASK_B==1))-B_intped_Up(MASK_B==1);
    Recovery_Bayer_R(MASK_G==1) =  R_intped_Up(MASK_G==1) + (quard_bayer(MASK_G==1))-G_intped_Up(MASK_G==1);
    
    Recovery_Bayer_B(MASK_R==1) =  B_intped_Up(MASK_R==1) + (quard_bayer(MASK_R==1))-R_intped_Up(MASK_R==1);  
    Recovery_Bayer_B(MASK_G==1) =  B_intped_Up(MASK_G==1) + (quard_bayer(MASK_G==1))-G_intped_Up(MASK_G==1);
    
    Recovery_Bayer_G(MASK_B==1) =  G_intped_Up(MASK_B==1) + (quard_bayer(MASK_B==1))-B_intped_Up(MASK_B==1);
    Recovery_Bayer_G(MASK_R==1) =  G_intped_Up(MASK_R==1) + (quard_bayer(MASK_R==1))-R_intped_Up(MASK_R==1);
    
    Recovery_Bayer_RGB = cat(3,Recovery_Bayer_R,Recovery_Bayer_G,Recovery_Bayer_B);
    
    imwrite(uint8(Recovery_Bayer_RGB/1023*4*255),'Recovery_Baye_Mode3_with lowPass.png');
    figure,imshow(uint8(Recovery_Bayer_RGB/1023*255*4)),title('Recovery Bayer Mode3 with lp');
    Std_Recovery_G = Std_Recovery(uint8(Recovery_Bayer_G/1023*255));
    %figure,imshow(uint8(Std_Recovery_G));title('Std_Recovery_G');    
    x0=12;y0=1.0;
    x1=14;y1=0.9;x2=20;y2=0.0;
    k0=(y1-y0)/(x1-x0);
    b0 = y1-k0*x1;
    k1=(y1-y2)/(x1-x2);
    b1 = y1-k1*x1;
    W(Std_Recovery_G<=x0) = 1.0;
    W((x0<Std_Recovery_G)&(Std_Recovery_G<=x1)) = k0*(Std_Recovery_G((x0<Std_Recovery_G)&(Std_Recovery_G<=x1)))+b0;
    W((x1<Std_Recovery_G)&(Std_Recovery_G<=x2)) = k1*(Std_Recovery_G((x1<Std_Recovery_G)&(Std_Recovery_G<=x2)))+b1;
    W_ds = imresize(W,[h/8 w/8]);
    W_ps = imresize(W_ds,[h w]);    
     figure,imshow(W);title('W');
%     figure,imshow(W_ps);title('W　ps');
    %W = W_ps;
    mean_kernel = [1 1 1 1 1
               1 1 1 1 1
               1 1 1 1 1
               1 1 1 1 1
               1 1 1 1 1]/25;
    h_kernel = [1 2 2 2 1]/8;
    v_kernel = h_kernel';
    n_kernel = [1 2 1 
                2 4 2
                1 2 1]/16;
    N_Recovery_G = conv2(Recovery_Bayer_G,n_kernel,'same');
    N_Recovery_R = conv2(Recovery_Bayer_R,n_kernel,'same');
    N_Recovery_B = conv2(Recovery_Bayer_B,n_kernel,'same');    
    H_Recovery_G = conv2(Recovery_Bayer_G,h_kernel,'same');
    H_Recovery_R = conv2(Recovery_Bayer_R,h_kernel,'same');
    H_Recovery_B = conv2(Recovery_Bayer_B,h_kernel,'same');
    V_Recovery_G = conv2(Recovery_Bayer_G,v_kernel,'same');
    V_Recovery_R = conv2(Recovery_Bayer_R,v_kernel,'same');
    V_Recovery_B = conv2(Recovery_Bayer_B,v_kernel,'same');
            
    Mean_Recovery_G = conv2(Recovery_Bayer_G,mean_kernel,'same');
    Mean_Recovery_R = conv2(Recovery_Bayer_R,mean_kernel,'same');
    Mean_Recovery_B = conv2(Recovery_Bayer_B,mean_kernel,'same');
    
    Direction_R = zeros(size(N_Recovery_R));
    Direction_G = zeros(size(N_Recovery_G));
    Direction_B = zeros(size(N_Recovery_B));
    
    Direction_R(Directions_Up==0.5) = N_Recovery_R(Directions_Up==0.5);
    Direction_R(Directions_Up==1) = V_Recovery_R(Directions_Up==1);
    Direction_R(Directions_Up==0) = H_Recovery_R(Directions_Up==0);
    Direction_G(Directions_Up==0.5) = N_Recovery_G(Directions_Up==0.5);
    Direction_G(Directions_Up==1) = V_Recovery_G(Directions_Up==1);
    Direction_G(Directions_Up==0) = H_Recovery_G(Directions_Up==0);
    Direction_B(Directions_Up==0.5) = N_Recovery_B(Directions_Up==0.5);
    Direction_B(Directions_Up==1) = V_Recovery_B(Directions_Up==1);
    Direction_B(Directions_Up==0) = H_Recovery_B(Directions_Up==0);
       
    QIC_Recovery_Bayer_R = Recovery_Bayer_R - (Recovery_Bayer_R - Mean_Recovery_R).*W;
    QIC_Recovery_Bayer_G = Recovery_Bayer_G - (Recovery_Bayer_G - Mean_Recovery_G).*W;
    QIC_Recovery_Bayer_B = Recovery_Bayer_B - (Recovery_Bayer_B - Mean_Recovery_B).*W;
    
    QIC_Recovery_Bayer_R = QIC_Recovery_Bayer_R - (QIC_Recovery_Bayer_R - Direction_R).*(1-W);
    QIC_Recovery_Bayer_G = QIC_Recovery_Bayer_G - (QIC_Recovery_Bayer_G - Direction_G).*(1-W);
    QIC_Recovery_Bayer_B = QIC_Recovery_Bayer_B - (QIC_Recovery_Bayer_B - Direction_B).*(1-W);
    
    Recovery_Bayer_R = QIC_Recovery_Bayer_R;
    Recovery_Bayer_G = QIC_Recovery_Bayer_G;
    Recovery_Bayer_B = QIC_Recovery_Bayer_B;
    %[Recovery_Bayer_R,Recovery_Bayer_G,Recovery_Bayer_B] = FCC(Recovery_Bayer_R,Recovery_Bayer_G,Recovery_Bayer_B,2);
%     Recovery_Bayer_R = clip(Recovery_Bayer_R,0,255);
%     Recovery_Bayer_G = clip(Recovery_Bayer_G,0,255);
%     Recovery_Bayer_B = clip(Recovery_Bayer_B,0,255);
    Recovery_Bayer = Recovery_Bayer_R.*Mr_Re + Recovery_Bayer_G.*Mg_Re + Recovery_Bayer_B.*Mb_Re;
    RGB_intp_merge_dir_avg =  cat(3,Recovery_Bayer_R,Recovery_Bayer_G,Recovery_Bayer_B);
    figure(2),imshow(uint8(RGB_intp_merge_dir_avg));title('RGB intp merge')
%     Recovery_Bayer_RGB = zeros([h,w,3]);
%     Recovery_Bayer_RGB(:,:,1) = Recovery_Bayer_R.*Mr_Re;
%     Recovery_Bayer_RGB(:,:,2) = Recovery_Bayer_G.*Mg_Re;
%     Recovery_Bayer_RGB(:,:,3) = Recovery_Bayer_B.*Mb_Re;
    imwrite(uint8(RGB_intp_merge_dir_avg),'new_version1_final.png');
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