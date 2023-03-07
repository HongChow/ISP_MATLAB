%Matrix Write to file
filename = 'Test_Quad.raw';
bayer_gray = bayer_gray';
bayer_gray = bayer_gray(:);
dlmwrite(filename,bayer_gray);

%% ----------- ISO For Debug ------------ %%
filename = './NR_Files/C8490_TL84_30LUX_ISO6400_Chart.txt';
matrix_full = readmatrix(filename);
matrix_debug = matrix_full(1:600,1:600);
debug_filename = 'C8490_TL84_30LUX_ISO6400_Chart_Part.txt';
writematrix(matrix_debug,debug_filename,"Delimiter",' ');
%%
