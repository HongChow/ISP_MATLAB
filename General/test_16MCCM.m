% 16M C16390 promation image: WB+CCM+Gamma
clear all c
close all
%% load the image
img=load('BPC_NR_out_fix_fSigma68_win1_sv1_sh1_eroded_NRBPC_3264_2448_3.txt');
J = demosaic(uint16(65535*img/1023),'bggr');
J=double(J)/65535; % range 0-1
imwrite(J,'BPC_NR_out_fix_fSigma68_win1_sv1_sh1_eroded_NRBPC_3264_2448_3.bmp','bmp');
figure;imshow(J),title('BPC_NR_out_fix_fSigma68_win1_sv1_sh1_eroded_NRBPC_3264_2448_3');
%%
J = reshape(J, size(J,1)*size(J,2),3);
J=J';% 3x 

%% 
%
ob=[-119	-111	-115]/1024; %0-1 for RGB
%ob=[-64	-64	-64]/1024; %0-1 for RGB
%wb_gain=[4.346369	3.312420	3.699826]/3.312420;
wb_gain=[4.346369	3.312420	3.699826]/1; %RGB
ccm=[2.615221	-1.654988	0.039768
-0.291468	1.550016	-0.258548
0.055554	-0.990407	1.934853];

WB_image=diag(wb_gain)*(J+repmat(ob',1,size(J,2)));
WB_image=min(max(WB_image,0),1);

CCM_image = ccm*WB_image;
CCM_image=min(max(CCM_image,0),1);


% gamma correction
GAM_image= lin2rgb(CCM_image);
GAM_image_dis=reshape(GAM_image',size(img,1),size(img,2),3);
figure;imshow(GAM_image_dis);
%imwrite(GAM_image_dis,'nr_WB_CCM_Gam_2.bmp','bmp');

