%Recovery_Bayer_G = imread('Recovery_Bayer_G.png');
function [Std_Recovery_G] = Std_Recovery3(Recovery_Bayer_G)
Recovery_Bayer_G = double(Recovery_Bayer_G);
mean_kernel = [ 1 1 1
                1 1 1
                1 1 1]/9;
Mean_Recovery_G = conv2(Recovery_Bayer_G,mean_kernel,'same');
Std_Recovery_G = zeros(size(Mean_Recovery_G));
[h,w] = size(Recovery_Bayer_G);
for j = 2:h-1
    for i = 2:w-1
        sum_diff = 0;        
        for w_j = -1:1
            for w_i = -1:1
                sum_diff = sum_diff+abs(Recovery_Bayer_G(j+w_j,i+w_i)-Mean_Recovery_G(j,i));
            end
        end
        Std_Recovery_G(j,i) = sum_diff/9;
    end
end
%Std_Recovery_G = Std_Recovery_G;
% figure(2),imshow(uint8(Std_Recovery_G*4))
% Std_Recovery_G = Std_Recovery_G/(max(max(Std_Recovery_G)));
% mean_kernel2 = [1 1 1 1 1
%                1 2 4 2 1
%                1 4 8 4 1
%                1 2 4 2 1
%                1 1 1 1 1]/48;
% Std_Recovery_G_filter = conv2(Std_Recovery_G,mean_kernel2,'same');
end

