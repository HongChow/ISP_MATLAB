 fid = fopen('pRaw10_QIC.raw');
input = fread(fid,'uint16','ieee-le');
quard_bayer = reshape(input,[4656,3504]);
quard_bayer = quard_bayer';
quard_bayer_RGB = demosaic(uint16(65535*quard_bayer/1023),'bggr');
figure,imshow(double(quard_bayer_RGB)./65535),title('quad');
%%


[Recovery_Bayer] = Remosaic_Hong(quard_bayer);
% Recovery_RGB_Hong = Demosaic_Hong3x3(Recovery_Bayer);
Recovery_RGB_Hong = demosaic(uint16(65535*Recovery_Bayer/1023),'bggr');
demosaic_hong = fliplr(Recovery_RGB_Hong);
demosaic_hong = double(demosaic_hong)./65535;
figure,imshow(demosaic_hong),title('test')
% 
% J = reshape(demosaic_hong, size(demosaic_hong,1)*size(demosaic_hong,2),3);
% J=J';% 3x 
% % ob=[-119	-111	-115]/1024; %0-1 for RGB
% % ob=[0	0	0]/1024; %0-1 for RGB
% ob=[-64	-64	-64]/1024; %0-1 for RGB
% %wb_gain=[4.346369	3.312420	3.699826]/3.312420;
% wb_gain=[4.346369	3.312420	3.699826]/1; %RGB
% ccm=[2.615221	-1.654988	0.039768
% -0.291468	1.550016	-0.258548
% 0.055554	-0.990407	1.934853];
% 
% WB_image=diag(wb_gain)*(J+repmat(ob',1,size(J,2)));
% WB_image=min(max(WB_image,0),1);
% 
% CCM_image = ccm*WB_image;
% CCM_image=min(max(CCM_image,0),1);
% 
% 
% % gamma correction
% GAM_image= lin2rgb(CCM_image);
% GAM_image_dis=reshape(GAM_image',size(demosaic_hong,1),size(demosaic_hong,2),3);
% figure;imshow(GAM_image_dis);title('Remosaic Hong')
% imwrite(uint8(GAM_image_dis*255),'Remosaic_Cista_Hong_wi2.png');
% figure,imshow(demosaic_edwin)


