% -------Do Demosaic Using Modified AHD  -------%
% Author: Hong %
% Date : 2022-09-19 %
% R-G and B-G to determine the direction %
function [RGB_inpted,directions] = Demosaic_Hong_with_QIC8(X,flag)
% function [RGB_inpted] = Demosaic_Hong(X)
    radius = 5;
    [h,w,~] = size(X);
    X = double(X);
    Mr  = double(zeros(size(X))); Mr(2:2:end,2:2:end) = 1;   % 0:not red,  1:red
    Mb  = double(zeros(size(X))); Mb(1:2:end,1:2:end) = 1;   % 0:not blue, 1:blue
    Mg1 = double(zeros(size(X))); Mg1(1:2:end,2:2:end) = 1;  % 0: not G1,  1:G1
    Mg2 = double(zeros(size(X))); Mg2(2:2:end,1:2:end) = 1;  % 0: not G2,  1:G2
    Hg = [0 1/2 0 1/2 0] + [-1/4  0 1/2 0 -1/4];
    Vg = Hg';
    Gh = (Mg1+Mg2).*X + (Mb+Mr).*conv2(X,Hg,'same'); % ---- H direction Interpolation all G ----- %
    Gv = (Mg1+Mg2).*X + (Mb+Mr).*conv2(X,Vg,'same'); % ---- V direction Interpolation all G ----- %
    % red/blue
    Hrb = [1/4 1/2 1/4; 1/2 1 1/2; 1/4 1/2 1/4];
    Vrb = Hrb;
    Rh = Gh+conv2(Mr.*(X-Gh),Hrb,'same');
    Bh = Gh+conv2(Mb.*(X-Gh),Hrb,'same');
    Rv = Gv+conv2(Mr.*(X-Gv),Vrb,'same');
    Bv = Gv+conv2(Mb.*(X-Gv),Vrb,'same');
    % ------- Select The More Aqurate Direction  for 2X downsample image --------- %
    RGB_Down_h = cat(3,Rh,Gh,Bh);
    RGB_Down_v = cat(3,Rv,Gv,Bv);
    Ycbcr_Down_h = rgb2ycbcr(RGB_Down_h);
    Ycbcr_Down_v = rgb2ycbcr(RGB_Down_v);
    Yh = Ycbcr_Down_h(:,:,1);
    Diff_Color_h = double(Ycbcr_Down_h(:,:,2)) - double(Ycbcr_Down_h(:,:,3));
    Yv = Ycbcr_Down_v(:,:,1);
    Diff_Color_v = double(Ycbcr_Down_v(:,:,2)) - double(Ycbcr_Down_v(:,:,3));
    cy=1;cc=1;
    RG_diff_h = Rh-Gh;
    RG_diff_v = Rv-Gv;
    BG_diff_h = Bh-Gh;
    BG_diff_v = Bv-Gv;
    if radius<=3
        diff_h1 = [1 -1 0;
               1 -1 0;
               1 -1 0;];
        diff_v1 = diff_h1';
        diff_h2 = [0 1 -1;
               0 1 -1;
               0 1 -1];
        diff_v2 = diff_h2';
        diff_YC_h = cy*(abs(conv2(RG_diff_h,diff_h1,'same'))+abs(conv2(RG_diff_h,diff_h2,'same')))+cy*(abs(conv2(BG_diff_h,diff_h1,'same'))+abs(conv2(BG_diff_h,diff_h2,'same')));
        diff_YC_v = cy*(abs(conv2(RG_diff_v,diff_v1,'same'))+abs(conv2(RG_diff_v,diff_v2,'same')))+cc*(abs(conv2(BG_diff_v,diff_v1,'same'))+abs(conv2(BG_diff_v,diff_v2,'same')));           
    else
           diff_h1 = [1 -1 0 0 0 0 0 0 0 0 0;
               1 -1 0 0 0 0 0 0 0 0 0 ;
               1 -1 0 0 0 0 0 0 0 0 0 ;
               1 -1 0 0 0 0 0 0 0 0 0 ;
               1 -1 0 0 0 0 0 0 0 0 0 ;
               1 -1 0 0 0 0 0 0 0 0 0 ;
               1 -1 0 0 0 0 0 0 0 0 0 ;
               1 -1 0 0 0 0 0 0 0 0 0 ;
               1 -1 0 0 0 0 0 0 0 0 0 ;
               1 -1 0 0 0 0 0 0 0 0 0 ;
               1 -1 0 0 0 0 0 0 0 0 0 ;];
           diff_h2 =[0 1 -1 0 0 0 0 0 0 0 0;
               0 1 -1 0 0 0 0 0 0 0 0;
               0 1 -1 0 0 0 0 0 0 0 0;
               0 1 -1 0 0 0 0 0 0 0 0;
               0 1 -1 0 0 0 0 0 0 0 0;
               0 1 -1 0 0 0 0 0 0 0 0;
               0 1 -1 0 0 0 0 0 0 0 0;
               0 1 -1 0 0 0 0 0 0 0 0;
               0 1 -1 0 0 0 0 0 0 0 0;
               0 1 -1 0 0 0 0 0 0 0 0;
               0 1 -1 0 0 0 0 0 0 0 0;];
           diff_h3 =[0 0 1 -1 0 0 0 0 0 0 0;
               0 0 1 -1 0 0 0 0 0 0 0 ;
               0 0 1 -1 0 0 0 0 0 0 0 ;
               0 0 1 -1 0 0 0 0 0 0 0 ;
               0 0 1 -1 0 0 0 0 0 0 0 ;
               0 0 1 -1 0 0 0 0 0 0 0 ;
               0 0 1 -1 0 0 0 0 0 0 0 ;
               0 0 1 -1 0 0 0 0 0 0 0 ;
               0 0 1 -1 0 0 0 0 0 0 0 ;
               0 0 1 -1 0 0 0 0 0 0 0 ;
               0 0 1 -1 0 0 0 0 0 0 0 ;];
           diff_h4 = [0 0 0 1 -1 0 0 0 0 0 0;
               0 0 0 1 -1 0 0 0 0 0 0 ;
               0 0 0 1 -1 0 0 0 0 0 0 ;
               0 0 0 1 -1 0 0 0 0 0 0 ;
               0 0 0 1 -1 0 0 0 0 0 0 ;
               0 0 0 1 -1 0 0 0 0 0 0 ;
               0 0 0 1 -1 0 0 0 0 0 0 ;
               0 0 0 1 -1 0 0 0 0 0 0 ;
               0 0 0 1 -1 0 0 0 0 0 0 ;
               0 0 0 1 -1 0 0 0 0 0 0 ;
               0 0 0 1 -1 0 0 0 0 0 0 ;];
           diff_h5 = [0 0 0 0 1 -1 0 0 0 0 0;
               0 0 0 0 1 -1 0 0 0 0 0 ;
               0 0 0 0 1 -1 0 0 0 0 0 ;
               0 0 0 0 1 -1 0 0 0 0 0 ;
               0 0 0 0 1 -1 0 0 0 0 0 ;
               0 0 0 0 1 -1 0 0 0 0 0 ;
               0 0 0 0 1 -1 0 0 0 0 0 ;
               0 0 0 0 1 -1 0 0 0 0 0 ;
               0 0 0 0 1 -1 0 0 0 0 0 ;
               0 0 0 0 1 -1 0 0 0 0 0 ;
               0 0 0 0 1 -1 0 0 0 0 0 ;];
           diff_h6 = [0 0 0 0 0 1 -1 0 0 0 0;
               0 0 0 0 0 1 -1 0 0 0 0;
               0 0 0 0 0 1 -1 0 0 0 0;
               0 0 0 0 0 1 -1 0 0 0 0;
               0 0 0 0 0 1 -1 0 0 0 0;
               0 0 0 0 0 1 -1 0 0 0 0;
               0 0 0 0 0 1 -1 0 0 0 0;
               0 0 0 0 0 1 -1 0 0 0 0;
               0 0 0 0 0 1 -1 0 0 0 0;
               0 0 0 0 0 1 -1 0 0 0 0;
               0 0 0 0 0 1 -1 0 0 0 0;];
           diff_h7 = [0 0 0 0 0 0 1 -1 0 0 0;
               0 0 0 0 0 0 1 -1 0 0 0;
               0 0 0 0 0 0 1 -1 0 0 0;
               0 0 0 0 0 0 1 -1 0 0 0;
               0 0 0 0 0 0 1 -1 0 0 0;
               0 0 0 0 0 0 1 -1 0 0 0;
               0 0 0 0 0 0 1 -1 0 0 0;
               0 0 0 0 0 0 1 -1 0 0 0;
               0 0 0 0 0 0 1 -1 0 0 0;
               0 0 0 0 0 0 1 -1 0 0 0;
               0 0 0 0 0 0 1 -1 0 0 0;];
           diff_h8 = [0 0 0 0 0 0 0 1 -1 0 0;
               0 0 0 0 0 0 0 1 -1 0 0;
               0 0 0 0 0 0 0 1 -1 0 0;
               0 0 0 0 0 0 0 1 -1 0 0;
               0 0 0 0 0 0 0 1 -1 0 0;
               0 0 0 0 0 0 0 1 -1 0 0;
               0 0 0 0 0 0 0 1 -1 0 0;
               0 0 0 0 0 0 0 1 -1 0 0;
               0 0 0 0 0 0 0 1 -1 0 0;
               0 0 0 0 0 0 0 1 -1 0 0;
               0 0 0 0 0 0 0 1 -1 0 0;];
           diff_h9 = [0 0 0 0 0 0 0 0 1 -1 0;
               0 0 0 0 0 0 0 0 1 -1 0;
               0 0 0 0 0 0 0 0 1 -1 0;
               0 0 0 0 0 0 0 0 1 -1 0;
               0 0 0 0 0 0 0 0 1 -1 0;
               0 0 0 0 0 0 0 0 1 -1 0;
               0 0 0 0 0 0 0 0 1 -1 0;
               0 0 0 0 0 0 0 0 1 -1 0;
               0 0 0 0 0 0 0 0 1 -1 0;
               0 0 0 0 0 0 0 0 1 -1 0;
               0 0 0 0 0 0 0 0 1 -1 0;];
           diff_h10 = [0 0 0 0 0 0 0 0 0 1 -1;
               0 0 0 0 0 0 0 0 0 1 -1;
               0 0 0 0 0 0 0 0 0 1 -1;
               0 0 0 0 0 0 0 0 0 1 -1;
               0 0 0 0 0 0 0 0 0 1 -1;
               0 0 0 0 0 0 0 0 0 1 -1;
               0 0 0 0 0 0 0 0 0 1 -1;
               0 0 0 0 0 0 0 0 0 1 -1;
               0 0 0 0 0 0 0 0 0 1 -1;
               0 0 0 0 0 0 0 0 0 1 -1;
               0 0 0 0 0 0 0 0 0 1 -1;];
        diff_v1 = diff_h1';        
        diff_v2 = diff_h2';
        diff_v3 = diff_h3';
        diff_v4 = diff_h4';
        diff_v5 = diff_h5';
        diff_v6 = diff_h6';
        diff_v7 = diff_h7';
        diff_v8 = diff_h8';
        diff_v9 = diff_h9';
        diff_v10 = diff_h10';
        diff_YC_h = cy*(abs(conv2(RG_diff_h,diff_h1,'same'))+abs(conv2(RG_diff_h,diff_h2,'same'))+abs(conv2(RG_diff_h,diff_h3,'same'))+abs(conv2(RG_diff_h,diff_h4,'same'))+abs(conv2(RG_diff_h,diff_h5,'same'))+abs(conv2(RG_diff_h,diff_h6,'same')) ...
                  +abs(conv2(RG_diff_h,diff_h7,'same'))+abs(conv2(RG_diff_h,diff_h8,'same'))+abs(conv2(RG_diff_h,diff_h9,'same'))+abs(conv2(RG_diff_h,diff_h10,'same')))...
                  + cc*(abs(conv2(BG_diff_h,diff_h1,'same'))+abs(conv2(BG_diff_h,diff_h2,'same'))+abs(conv2(BG_diff_h,diff_h3,'same'))+abs(conv2(BG_diff_h,diff_h4,'same'))+abs(conv2(BG_diff_h,diff_h5,'same'))+abs(conv2(BG_diff_h,diff_h6,'same'))...
                  +abs(conv2(BG_diff_h,diff_h7,'same'))+abs(conv2(BG_diff_h,diff_h8,'same'))+abs(conv2(BG_diff_h,diff_h9,'same'))+abs(conv2(BG_diff_h,diff_h10,'same')));
        diff_YC_v = cy*(abs(conv2(RG_diff_v,diff_v1,'same'))+abs(conv2(RG_diff_v,diff_v2,'same'))+abs(conv2(RG_diff_v,diff_v4,'same'))+abs(conv2(RG_diff_v,diff_v4,'same'))+abs(conv2(RG_diff_v,diff_v5,'same'))+abs(conv2(RG_diff_v,diff_v6,'same')) ...
                  +abs(conv2(RG_diff_v,diff_v7,'same'))+abs(conv2(RG_diff_v,diff_v8,'same'))+abs(conv2(RG_diff_v,diff_v9,'same'))+abs(conv2(RG_diff_v,diff_v10,'same')))...
                  + cc*(abs(conv2(BG_diff_v,diff_v1,'same'))+abs(conv2(BG_diff_v,diff_v2,'same'))+abs(conv2(BG_diff_v,diff_v3,'same'))+abs(conv2(BG_diff_v,diff_v4,'same'))+abs(conv2(BG_diff_v,diff_v5,'same'))+abs(conv2(BG_diff_v,diff_v6,'same'))...
                  +abs(conv2(BG_diff_v,diff_v7,'same'))+abs(conv2(BG_diff_v,diff_v8,'same'))+abs(conv2(BG_diff_v,diff_v9,'same'))+abs(conv2(BG_diff_v,diff_v10,'same')));
    end
   
     G_intped = Gh;R_intped = Rh;B_intped = Bh;
     
     low_pass_diff = [1 1 1 1 1 1 1 1 1
                      1 1 1 1 1 1 1 1 1
                      1 1 1 1 1 1 1 1 1
                      1 1 1 1 1 1 1 1 1
                      1 1 1 1 1 1 1 1 1
                      1 1 1 1 1 1 1 1 1
                      1 1 1 1 1 1 1 1 1
                      1 1 1 1 1 1 1 1 1
                      1 1 1 1 1 1 1 1 1];
%                   
%           low_pass_diff = [1 1 1 1 1
%                       1 1 1 1 1 
%                       1 1 1 1 1 
%                       1 1 1 1 1 
%                       1 1 1 1 1 
%                       ];             
     diff_YC_h = conv2(diff_YC_h,low_pass_diff,'same');       
     diff_YC_v = conv2(diff_YC_v,low_pass_diff,'same');
     diff_hv = abs(diff_YC_h - diff_YC_v)/8910;
%      figure,imshow(diff_hv),title('diff_hv')
     diff_YC_h = diff_YC_h/8910;
     diff_YC_v = diff_YC_v/8910;
     
%      figure,imshow(diff_YC_h/255.0),title('diff_YC_h')
%      figure,imshow(diff_YC_h/255.0),title('diff_YC_h')
    
   dire_th = 0.1;
%    directions = 0.5*ones(size(Gh));% no 
    directions = zeros(size(Gh));
%     directions(diff_YC_h>diff_YC_v+dire_th) = 1;% vertical
%     directions(diff_YC_v>=diff_YC_h+dire_th) = 0;% hirizontal 
    directions(diff_YC_h>diff_YC_v) = 1;% vertical
    directions(diff_YC_v>=diff_YC_h) = 0;% hirizontal 
    
%     % figure,imshow(directions);title('directions3')
%     G_intped(directions==1) = Gv(directions==1);
%     G_intped(directions==0.5) = (Gv(directions==0.5)+Gh(directions==0.5))/2;
%     R_intped(directions==1) = Rv(directions==1);
%     R_intped(directions==0.5) = (Rv(directions==0.5)+Rh(directions==0.5))/2;
%     B_intped(directions==1) = Bv(directions==1);
%     B_intped(directions==0.5) = (Bv(directions==0.5)+Bh(directions==0.5))/2;
% 

    G_intped(diff_YC_h>diff_YC_v) = Gv(diff_YC_h>diff_YC_v);
    R_intped(diff_YC_h>diff_YC_v) = Rv(diff_YC_h>diff_YC_v);
    B_intped(diff_YC_h>diff_YC_v) = Bv(diff_YC_h>diff_YC_v);
    % ------------ TEST ALL H Direction ------------------ %

    
    % ----------- Do Color-Diff Median Filter --------------- %
    
    if(flag)
        reap_times = 2;
        while reap_times>0
            color_diff_r = R_intped-G_intped;
            color_diff_b = B_intped-G_intped;
            for j = 2:h-2
                for i = 2:w-2
                    center_block_r = [color_diff_r(j-1,i-1) color_diff_r(j-1,i)  color_diff_r(j-1,i+1)  color_diff_r(j,i-1)  color_diff_r(j,i) color_diff_r(j,i+1)  color_diff_r(j+1,i-1) color_diff_r(j+1,i)  color_diff_r(j+1,i+1)];
                    center_block_b = [color_diff_b(j-1,i-1) color_diff_b(j-1,i)  color_diff_b(j-1,i+1)  color_diff_b(j,i-1)  color_diff_b(j,i) color_diff_b(j,i+1)  color_diff_b(j+1,i-1) color_diff_b(j+1,i)  color_diff_b(j+1,i+1)];
                    R_intped(j,i) = median(center_block_r)+G_intped(j,i);
                    B_intped(j,i) = median(center_block_b)+G_intped(j,i);
                end
            end
            color_diff_gb = G_intped - B_intped;
            color_diff_gr = G_intped - R_intped;
            for j = 2:h-2
                for i = 2:w-2
                    center_block_gr = [color_diff_gr(j-1,i-1) color_diff_gr(j-1,i)  color_diff_gr(j-1,i+1)  color_diff_gr(j,i-1)  color_diff_gr(j,i) color_diff_gr(j,i+1)  color_diff_gr(j+1,i-1) color_diff_gr(j+1,i)  color_diff_gr(j+1,i+1)];
                    center_block_gb = [color_diff_gb(j-1,i-1) color_diff_gb(j-1,i)  color_diff_gb(j-1,i+1)  color_diff_gb(j,i-1)  color_diff_gb(j,i) color_diff_gb(j,i+1)  color_diff_gb(j+1,i-1) color_diff_gb(j+1,i)  color_diff_gb(j+1,i+1)];
                    G_intped(j,i) = (median(center_block_gr)+R_intped(j,i)+median(center_block_gb)+B_intped(j,i))/2;                    
                end
            end
            reap_times=reap_times-1;
        end
        
    end 
    reap_times = 2;
    RGB_inpted = cat(3,R_intped,G_intped,B_intped);
    %imwrite(uint8(RGB_inpted),strcat('C_inpted_',string(reap_times),'.png'));
end
