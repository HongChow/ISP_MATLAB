outR = readmatrix('out_binning_r_pad.txt',Delimiter=" ");
outG = readmatrix('out_binning_g_pad.txt',Delimiter=" ");
outB = readmatrix('out_binning_b_pad.txt',Delimiter=" ");
outRGB = cat(3,outR,outG,outB);
figure(7),imshow((outRGB));title('AI NR out PAD')
% imwrite((outRGB),'AI NR OUT.png');
%%
outR = readmatrix('pipeline_out_R_ai_nr.txt',Delimiter=" ");
outG = readmatrix('pipeline_out_G_ai_nr.txt',Delimiter=" ");
outB = readmatrix('pipeline_out_B_ai_nr.txt',Delimiter=" ");
outRGB = cat(3,outR,outG,outB);
figure(6),imshow(uint8(outRGB));title('PipeLine NR OUT')
imwrite(uint8(outRGB),'outRGB_pipelin_AI_NR_0911.png');