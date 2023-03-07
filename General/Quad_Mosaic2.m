%% --------- This a script for Quad Mosaic --------- %%
function [QuadBayer] =  Quad_Mosaic(rgb_in)
mask_b = [1 1 0 0
          1 1 0 0
          0 0 0 0
          0 0 0 0];
mask_g = [0 0 1 1
          0 0 1 1
          1 1 0 0
          1 1 0 0];
mask_r = [0 0 0 0
          0 0 0 0
          0 0 1 1
          0 0 1 1];
[H,W,~] = size(rgb_in);
height = H/4;
width = W/4;
MASKB = repmat(mask_b,[height,width]);
MASKG = repmat(mask_g,[height,width]);
MASKR = repmat(mask_r,[height,width]);
Quad_R = rgb_in(:,:,1).*uint8(MASKR);
Quad_G = rgb_in(:,:,2).*uint8(MASKG);
Quad_B = rgb_in(:,:,3).*uint8(MASKB);
Quad_RGB = cat(3,Quad_R,Quad_G,Quad_B);
QuadBayer = Quad_R + Quad_G + Quad_B;
figure(1),imshow(Quad_RGB);title('Quad_RGB');      
end