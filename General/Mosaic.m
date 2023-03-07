function [bayer_gray]= Mosaic(rgb_image) 
 bayer_RGB = zeros(size(rgb_image));
 bayer_b = bayer_RGB(:,:,3);
 bayer_r = bayer_RGB(:,:,1);
 bayer_g = bayer_RGB(:,:,2);
 
 bayer_r(2:2:end,2:2:end) = rgb_image(2:2:end,2:2:end,1);
 bayer_g(1:2:end,2:2:end) = rgb_image(1:2:end,2:2:end,2);
 bayer_g(2:2:end,1:2:end) = rgb_image(2:2:end,1:2:end,2);
 bayer_b(1:2:end,1:2:end) = rgb_image(1:2:end,1:2:end,3);
 bayer_RGB(:,:,1) = bayer_r;
 bayer_RGB(:,:,2) = bayer_g;
 bayer_RGB(:,:,3) = bayer_b;
% imwrite(uint8(bayer_RGB),'golden_bayer.png');
figure,imshow(uint8(bayer_RGB));title('golden simple bayer')
 bayer_gray = bayer_r+bayer_g+bayer_b;
% imwrite(uint8(bayer_gray),'golden_bayer_gray.png');
end