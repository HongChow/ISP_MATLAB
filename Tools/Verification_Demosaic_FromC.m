outR = readmatrix('out_R_afc.txt',Delimiter=" ");
outG = readmatrix('out_G_afc.txt',Delimiter=" ");
outB = readmatrix('out_B_afc.txt',Delimiter=" ");
outRGB = cat(3,outR,outG,outB);
figure(4),imshow(uint8(outRGB));title('demosaicked')
imwrite(uint8(outRGB),'6lines_korda_with_ColorDiff_Median.png');