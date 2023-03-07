% ------- To Generate a Mosaic Image from a RGB Image  -------%
% Author: Hong %
% Date : 2022-07-17 %
function [quard_bayer] = Quard_Mosaic(rgb_image)
    [h,w,~] = size(rgb_image);
%     quard_bayer_R = zeros([h,w]);
%     quard_bayer_G = zeros([h,w]);
%     quard_bayer_B = zeros([h,w]);
%     quard_bayer = zeros([h,w]);
    quard_bayer_RGB = zeros(size(rgb_image));
    rgb_b = rgb_image(:,:,3);
    rgb_r = rgb_image(:,:,1);
    rgb_g = rgb_image(:,:,2);
    
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
    quard_bayer_R = uint8(MASK_R).*rgb_r;
    quard_bayer_B = uint8(MASK_B).*rgb_b;
    quard_bayer_G = uint8(MASK_Gb).*rgb_g+uint8(MASK_Gr).*rgb_g;
    quard_bayer_RGB(:,:,1) = quard_bayer_R;
    quard_bayer_RGB(:,:,2) = quard_bayer_G;
    quard_bayer_RGB(:,:,3) = quard_bayer_B;
    quard_bayer = quard_bayer_R+quard_bayer_B+quard_bayer_G;
    figure,imshow(uint8(quard_bayer_RGB));
end