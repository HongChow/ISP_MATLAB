Test_image = zeros(800,800,3);
Test_image(1:400,1:400,1) = 100;
Test_image(400:end,400:end,1) = 200;
Test_image(400:end,400:end,2) = 100;
figure,imshow(uint8(Test_image));