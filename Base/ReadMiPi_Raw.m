function ReadMiPi_Raw(imagename,width,height)
%% load the image
% imagename='C8490_Shading_Bright_15fps.raw'; 
%imagename='./dark_blcon_mipi_raw10_long.raw'; 
%% 10 bit raw 
fid = fopen(imagename,'r');
input0 = fread(fid);
fclose(fid);
img = raw10img(input0,width,height);

img=double(img)/1023;
figure; imshow(img*4);
end