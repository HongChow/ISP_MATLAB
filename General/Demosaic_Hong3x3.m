% -------Do Demosaic Using Modified AHD  -------%
% Author: Hong %
% Date : 2022-07-17 %
function [RGB_inpted] = Demosaic_Hong3x3(X)
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
    diff_h1 = [1 -1 0;
               1 -1 0;
               1 -1 0;];
    diff_v1 = diff_h1';
    diff_h2 = [-1 1 0;
               -1 1 0;
               -1 1 0];
    diff_v2 = diff_h2';
    diff_YC_h = cy*(abs(conv2(Yh,diff_h1,'same'))+abs(conv2(Yh,diff_h2,'same')))+cc*(abs(conv2(Diff_Color_h,diff_h1,'same'))+abs(conv2(Diff_Color_h,diff_h2,'same')));
    diff_YC_v = cy*(abs(conv2(Yv,diff_v1,'same'))+abs(conv2(Yv,diff_v2,'same')))+cc*(abs(conv2(Diff_Color_v,diff_v1,'same'))+abs(conv2(Diff_Color_v,diff_v2,'same')));
    G_intped = Gh;R_intped = Rh;B_intped = Bh;
    
    directions = zeros(size(Gh));
    directions(diff_YC_h>diff_YC_v) = 1;    
    G_intped(diff_YC_h>diff_YC_v) = Gv(diff_YC_h>diff_YC_v);
    R_intped(diff_YC_h>diff_YC_v) = Rv(diff_YC_h>diff_YC_v);
    B_intped(diff_YC_h>diff_YC_v) = Bv(diff_YC_h>diff_YC_v);
    
    RGB_inpted = cat(3,R_intped,G_intped,B_intped);
end