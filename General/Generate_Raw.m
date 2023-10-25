%% ------ Generate Bayer Data ------ %%
rgb_image = imread('plane_clean_for_debug.png');
figure,imshow(rgb_image);
[h,w,~] = size(rgb_image);
bayer_image = zeros([h,w]);
R_image = rgb_image(:,:,1);
G_image = rgb_image(:,:,2);
B_image = rgb_image(:,:,3);
bayer_image(1:2:end,1:2:end) = B_image(1:2:end,1:2:end);
bayer_image(2:2:end,1:2:end) = G_image(2:2:end,1:2:end);
bayer_image(1:2:end,2:2:end) = G_image(1:2:end,2:2:end);
bayer_image(2:2:end,2:2:end) = R_image(2:2:end,2:2:end);
to_demosaic = uint8(bayer_image);
%writematrix(NR_Raw,strcat(file_name,'.txt'),'Delimiter',' ');
writematrix(to_demosaic,'noisy_bayer_plane_for_debug.txt','Delimiter',' ');
figure,imshow(to_demosaic),title('noisy_ bayer_ 1D');
%NR_Raw_demosaiced = demosaic(to_demosaic,'bggr');


% figure,imshow(NR_Raw_demosaiced);
% figure,imshow(uint8(bayer_image)),title('noisy_ bayer_ 3D');


%% ------ Generate Bayer Data ------ %%
% rgb_image = imread('noisy_plane_M.png');
% figure,imshow(rgb_image);
% [h,w,~] = size(rgb_image);
% bayer_image = zeros([h,w]);
% R_image = rgb_image(:,:,1);
% G_image = rgb_image(:,:,2);
% B_image = rgb_image(:,:,3);
% bayer_image(1:2:end,1:2:end) = B_image(1:2:end,1:2:end);
% bayer_image(2:2:end,1:2:end) = G_image(2:2:end,1:2:end);
% bayer_image(1:2:end,2:2:end) = G_image(1:2:end,2:2:end);
% bayer_image(2:2:end,2:2:end) = R_image(2:2:end,2:2:end);
% to_demosaic = uint8(bayer_image);
% % writematrix(NR_Raw,strcat(file_name,'.txt'),'Delimiter',' ');
% writematrix(to_demosaic,'noisy_bayer_plane_M.txt','Delimiter',' ');
% figure,imshow(to_demosaic),title('noisy_ bayer_ 1D_ M');
% NR_Raw_demosaiced = demosaic(to_demosaic,'bggr');
% 
% 
% % figure,imshow(NR_Raw_demosaiced);
% figure,imshow(uint8(bayer_image)),title('noisy_ bayer_ 3D_ M');
%%
%%------------------- %%
rgb_image_plane = 100*ones([480,480,3]);
%rgb_image_plane(:,:,3)  = 200;
imwrite(uint8(rgb_image_plane),'plane_clean_for_debug.png');
%%
plane_clean_image = imread('plane_clean.png');
plane_clean_image_double = im2double(plane_clean_image);
noisy_image_m = imnoise(plane_clean_image_double,"gaussian",0,0.005);
figure,imshow(uint8(noisy_image_m*255));title('noisy_ image_ m')
imwrite(uint8(noisy_image_m*255),'noisy_plane_M.png');
