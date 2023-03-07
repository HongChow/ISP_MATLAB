Test_image = zeros(800,800,3);
Test_image(1:400,1:400,1) = 100;
Test_image(400:end,400:end,1) = 200;
Test_image(400:end,400:end,2) = 100;
figure,imshow(uint8(Test_image));
bayer_gray = Quard_Mosaic(uint8(Test_image));
%Matrix Write to file
filename = 'Simple_Quad.raw';
bayer_gray_re = bayer_gray';
bayer_gray_1D = bayer_gray_re(:);
dlmwrite(filename,bayer_gray_1D);
%%
 [bayer_gray_gt]= Mosaic(Test_image);
 figure,imshow(uint8(Test_image));title('bayer_gray_gt')
%%
filename_c = 'remosaiced_kodark.txt';
bayer_C_1D = dlmread(filename_c);
bayer_C_1D_re = reshape(bayer_C_1D,[512,768]);
Bayer_Simple_C = bayer_C_1D_re';
Bayer_Simple_C  = GrayBayer2Bayer3D(Bayer_Simple_C);