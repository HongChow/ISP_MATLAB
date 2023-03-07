 % ------- Convert Quard Bayer to Traditional Bayer  -------%
% Author: Hong %
% Date : 2022-07-17 %
% function [Recovery_Bayer] = Remosaic_Hong(quard_bayer,radius,flag)
function [Recovery_Bayer] = Remosaic_Hong_with_QIC7(quard_bayer)
% function Remosaic(quard_bayer)
    tic
    [h,w,~] = size(quard_bayer);
    quard_bayer = double(quard_bayer);
    Down_Bayer = double(zeros(size(quard_bayer)/2));
    G_intped_Up =  zeros(size(quard_bayer)); 
    R_intped_Up =  zeros(size(quard_bayer)); 
    B_intped_Up =  zeros(size(quard_bayer)); 
    Std_Recovery_G_up = zeros(size(quard_bayer)); 
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
    [RGB_inpted,directions] =  Demosaic_Hong_with_QIC7(X,0);
    G_intped = RGB_inpted(:,:,2);
    R_intped = RGB_inpted(:,:,1);
    B_intped = RGB_inpted(:,:,3);
    %figure,imshow(RGB_inpted/1023.0*4),title('RGB inpted 7  hvn with filter ')
    %figure,imshow(uint8(RGB_inpted/1023.0*4*255)),title('RGB_inpted')
    %imwrite(uint8(RGB_inpted),'cista_bin_intp_v7.png')
    %imwrite(uint8(RGB_inpted/1023.0*255*4),'cista_bin_intp_v7.png')
%     error("debug out");
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
    %figure(2);imshow(Recovery_Bayer_RGB/1023*4),title('Recovery Bayer RGB')
    
    W = zeros(size(Recovery_Bayer_G));
    imwrite(uint8(Recovery_Bayer_RGB),'Recovery_Bayer_RGB_v7.png');
    error('暂停Debug');
%    Std_Recovery_G = Std_Recovery(uint8(G_intped/1023*255));
    Std_Recovery_G = Std_Recovery(uint8(Recovery_Bayer_G/1023*255));
%     Std_Recovery_G03 = Std_Recovery3(uint8(Recovery_Bayer_G/1023*255));
%     figure,imshow(uint8(Std_Recovery_G));title('Std_Recovery_G');    
%     figure,imshow(uint8(Std_Recovery_G0));title('Std_Recovery_G0');    
   % figure,imshow(uint8(Std_Recovery_G03*4));title('Std_Recovery_G03');    

    x0=12;y0=1.0;
    x1=14;y1=0.9;x2=20;y2=0.0;
    k0=(y1-y0)/(x1-x0);
    b0 = y1-k0*x1;
    k1=(y1-y2)/(x1-x2);
    b1 = y1-k1*x1;
      
%     Std_Recovery_G = Std_Recovery_G0;
    
    
%     Std_Recovery_G_up(1:2:end,1:2:end) = Std_Recovery_G;
%     Std_Recovery_G_up(2:2:end,1:2:end) = Std_Recovery_G;
%     Std_Recovery_G_up(2:2:end,2:2:end) = Std_Recovery_G;
%     Std_Recovery_G_up(1:2:end,2:2:end) = Std_Recovery_G;
%     W(Std_Recovery_G_up<=x0) = 1.0;
    
    W(Std_Recovery_G<=x0) = 1.0;
    
    W((x0<Std_Recovery_G)&(Std_Recovery_G<=x1)) = k0*(Std_Recovery_G((x0<Std_Recovery_G)&(Std_Recovery_G<=x1)))+b0;
    W((x1<Std_Recovery_G)&(Std_Recovery_G<=x2)) = k1*(Std_Recovery_G((x1<Std_Recovery_G)&(Std_Recovery_G<=x2)))+b1;
    W_up = imresize(W,[h w]);
    W_ds = imresize(W,[h/4 w/4]);
    W_ps = imresize(W_ds,[h/2 w/2]);    
%      figure,imshow(W);title('W');
    %figure,imshow(W_up);title('W_up');
    %W = W_ps;
    mean_kernel = [1 1 1 1 1
               1 1 1 1 1
               1 1 1 1 1
               1 1 1 1 1
               1 1 1 1 1]/25;
    mean_kernel5 = mean_kernel;       
    mean_kernel3 = [1 1 1
                    1 1 1
                    1 1 1];
    h_kernel = [1 1 1 1 1 ]/5;
    v_kernel = h_kernel';
%     n_kernel = [1 2 1 
%                 2 4 2
%                 1 2 1]/16;
%             
    n_kernel = [1 1 1 1 1 
                1 1 1 1 1
                1 1 1 1 1
                1 1 1 1 1
                1 1 1 1 1]/25;        
%     N_Recovery_G = conv2(Recovery_Bayer_G,n_kernel,'same');
%     N_Recovery_R = conv2(Recovery_Bayer_R,n_kernel,'same');
%     N_Recovery_B = conv2(Recovery_Bayer_B,n_kernel,'same');    
%     H_Recovery_G = conv2(Recovery_Bayer_G,h_kernel,'same');
%     H_Recovery_R = conv2(Recovery_Bayer_R,h_kernel,'same');
%     H_Recovery_B = conv2(Recovery_Bayer_B,h_kernel,'same');
%     V_Recovery_G = conv2(Recovery_Bayer_G,v_kernel,'same');
%     V_Recovery_R = conv2(Recovery_Bayer_R,v_kernel,'same');
%     V_Recovery_B = conv2(Recovery_Bayer_B,v_kernel,'same');
            
    Mean_Recovery_G = conv2(Recovery_Bayer_G,mean_kernel,'same');
    Mean_Recovery_R = conv2(Recovery_Bayer_R,mean_kernel,'same');
    Mean_Recovery_B = conv2(Recovery_Bayer_B,mean_kernel,'same');
    
    Mean_Recovery_RGB = cat(3,Mean_Recovery_R,Mean_Recovery_G,Mean_Recovery_B);
    %figure(4);imshow(Mean_Recovery_RGB/1023*4),title('Mean Recovery RGB')
    imwrite(uint8(Mean_Recovery_RGB/1023*4),'Mean Recovery RGB_V7.png')
 
    H_G = conv2(Recovery_Bayer_G,h_kernel,'same');
    H_R = conv2(Recovery_Bayer_R,h_kernel,'same');
    H_B = conv2(Recovery_Bayer_B,h_kernel,'same');
    V_G = conv2(Recovery_Bayer_G,v_kernel,'same');
    V_R = conv2(Recovery_Bayer_R,v_kernel,'same');
    V_B = conv2(Recovery_Bayer_B,v_kernel,'same');
    N_G = conv2(Recovery_Bayer_G,n_kernel,'same');
    N_R = conv2(Recovery_Bayer_R,n_kernel,'same');
    N_B = conv2(Recovery_Bayer_B,n_kernel,'same');
        
    Direction_R = zeros(size(H_R));
    Direction_G = zeros(size(H_G));
    Direction_B = zeros(size(H_B));
    
    
    
    
    Direction_R(Directions_Up==1) = V_R(Directions_Up==1);
    Direction_R(Directions_Up==0) = H_R(Directions_Up==0);
    Direction_R(Directions_Up==0.5) = N_R(Directions_Up==0.5);
    
    Direction_G(Directions_Up==1) = V_G(Directions_Up==1);
    Direction_G(Directions_Up==0) = H_G(Directions_Up==0);
    Direction_G(Directions_Up==0.5) = N_G(Directions_Up==0.5);
    
    Direction_B(Directions_Up==1) = V_B(Directions_Up==1);
    Direction_B(Directions_Up==0) = H_B(Directions_Up==0);
    Direction_B(Directions_Up==0.5) = N_B(Directions_Up==0.5);
    
    RGB_intp_direction = cat(3,Direction_R,Direction_G,Direction_B);
    %figure(3);imshow(RGB_intp_direction/1023.0*4),title('RGB intp direction')
    imwrite(uint8(RGB_intp_direction),'RGB_intp_direction_V7.png')
    
    
    QIC_Recovery_Bayer_R = Recovery_Bayer_R - (Recovery_Bayer_R - Mean_Recovery_R).*W;
    QIC_Recovery_Bayer_G = Recovery_Bayer_G - (Recovery_Bayer_G - Mean_Recovery_G).*W;
    QIC_Recovery_Bayer_B = Recovery_Bayer_B - (Recovery_Bayer_B - Mean_Recovery_B).*W;
    
    
    QIC_Recovery_Bayer_R = QIC_Recovery_Bayer_R - (QIC_Recovery_Bayer_R - Direction_R).*(1-W);
    QIC_Recovery_Bayer_G = QIC_Recovery_Bayer_G - (QIC_Recovery_Bayer_G - Direction_G).*(1-W);
    QIC_Recovery_Bayer_B = QIC_Recovery_Bayer_B - (QIC_Recovery_Bayer_B - Direction_B).*(1-W);
    
%     QIC_Recovery_Bayer_R = Recovery_Bayer_R.*(1-W_ps) + Direction_R.*W_ps;
%     QIC_Recovery_Bayer_G = Recovery_Bayer_G.*(1-W_ps) + Direction_G.*W_ps;
%     QIC_Recovery_Bayer_B = Recovery_Bayer_B.*(1-W_ps) + Direction_B.*W_ps;
    
    Recovery_Bayer_R = QIC_Recovery_Bayer_R;
    Recovery_Bayer_G = QIC_Recovery_Bayer_G;
    Recovery_Bayer_B = QIC_Recovery_Bayer_B;
    [Recovery_Bayer_R,Recovery_Bayer_G,Recovery_Bayer_B] = FCC(Recovery_Bayer_R,Recovery_Bayer_G,Recovery_Bayer_B,2);
    Recovery_Bayer_R = clip(Recovery_Bayer_R,0,255);
    Recovery_Bayer_G = clip(Recovery_Bayer_G,0,255);
    Recovery_Bayer_B = clip(Recovery_Bayer_B,0,255);
    
    Recovery_Bayer = Recovery_Bayer_R.*Mr_Re + Recovery_Bayer_G.*Mg_Re + Recovery_Bayer_B.*Mb_Re;

    RGB_intp_merge_dir_avg =  cat(3,Recovery_Bayer_R,Recovery_Bayer_G,Recovery_Bayer_B);
    %figure,imshow(uint8(RGB_intp_merge_dir_avg));title('RGB intp merge dir avg ')
    imwrite(uint8(RGB_intp_merge_dir_avg),'RGB intp merge dir avg_V7.png')

    toc
    disp('end');
end
function [Y] = clip(X,lo,hi)
Y = X;
Y(X<lo)=lo;
Y(X>hi)=hi;
end