% remosaic_test = load('remosaiced_test.txt');
% [remosaiced_inpted] = Demosaic_Hong(remosaic_test,1);
% figure,imshow(uint8(remosaiced_inpted))


remosaic_test = load('remosaiced_kodark2.txt');
[remosaiced_inpted] = Demosaic_Hong(remosaic_test,1);
figure,imshow(uint8(remosaiced_inpted));
imwrite(uint8(remosaiced_inpted),'remosaiced_kodark_fromC.png');
title('remosaiced_kodark_fromC')
%%
remosaic_test = load('remosaiced_kodark2.txt');
[Bayer3D] = GrayBayer2Bayer3D(remosaic_test);

% 
% remosaic_test = load('remosaiced_simple.txt');
% remosaic_test_bayer_3D = zeros(800,800,3);
% remosaic_test_bayer_3D(2:2:end,2:2:end,1) = remosaic_test(2:2:end,2:2:end);
% remosaic_test_bayer_3D(1:2:end,1:2:end,3) = remosaic_test(1:2:end,1:2:end);
% remosaic_test_bayer_3D(1:2:end,2:2:end,2) = remosaic_test(1:2:end,2:2:end);
% remosaic_test_bayer_3D(2:2:end,1:2:end,2) = remosaic_test(2:2:end,1:2:end);
% %[remosaiced_inpted] = Demosaic_Hong(remosaic_test,1);
% figure,imshow(uint8(remosaic_test_bayer_3D));title('remosaic_test_bayer_3D')

