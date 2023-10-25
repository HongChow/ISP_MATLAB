gray_bayer_kodark19 = readmatrix('kodim19_bayer.txt');
[h,w] = size(gray_bayer_kodark19);
color_bayer_kodark19 = zeros(h,w,3);
color_bayer_kodark19(1:2:end,1:2:end,3) = gray_bayer_kodark19(1:2:end,1:2:end);%B
color_bayer_kodark19(2:2:end,2:2:end,1) = gray_bayer_kodark19(2:2:end,2:2:end);%R
color_bayer_kodark19(1:2:end,2:2:end,2) = gray_bayer_kodark19(1:2:end,2:2:end);%Gb
color_bayer_kodark19(2:2:end,1:2:end,2) = gray_bayer_kodark19(2:2:end,1:2:end);%Gr
figure(4),imshow(uint8(color_bayer_kodark19));title('Bayer in kodark 19')