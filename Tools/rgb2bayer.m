function [bayer_out] = rgb2bayer(input_img_path)
    file_names = split(input_img_path,'/');
    valid_name = file_names(end);
    file_name = valid_name{1};
    file_name_comps = split(file_name,'.');
    name_part = file_name_comps(1);
    bayer_out_name = strcat(name_part{1},'_bayer.txt');
    rgb_img = imread(input_img_path);
%     [h,w,~] = size(rgb_img);
    % assume the first pixel is B %
    bayer_out = rgb_img(:,:,2); %G
    % -- B & R -- %
    bayer_out(1:2:end,1:2:end) = rgb_img(1:2:end,1:2:end,3);
    bayer_out(2:2:end,2:2:end) = rgb_img(2:2:end,2:2:end,1); 
    % write txt maxtrix %
    writematrix(bayer_out,bayer_out_name,'Delimiter',' ');
end