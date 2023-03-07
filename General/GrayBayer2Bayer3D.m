% ----------- gray bayer to bayer3D -------------- %
function [Bayer3D] = GrayBayer2Bayer3D(gray_bayer,filename)
     [h,w] = size(gray_bayer);
     Bayer3D = zeros(h,w,3);
     Bayer3D(1:2:end,1:2:end,3) = gray_bayer(1:2:end,1:2:end);
     Bayer3D(2:2:end,1:2:end,2) = gray_bayer(2:2:end,1:2:end);
     Bayer3D(1:2:end,2:2:end,2) = gray_bayer(1:2:end,2:2:end);
     Bayer3D(2:2:end,2:2:end,1) = gray_bayer(2:2:end,2:2:end);
     figure,imshow(uint8(Bayer3D));title(filename);
end