function [R_intped,G_intped,B_intped] = FCC(R_intped,G_intped,B_intped,reap_times) 
        RGB_IN = cat(3,R_intped,G_intped,B_intped);
        figure,imshow(uint8(RGB_IN)),title('RGB_IN');
        [h,w] = size(R_intped);
        while reap_times>0
            color_diff_r = R_intped-G_intped;
            color_diff_b = B_intped-G_intped;
            for j = 2:h-2
                for i = 2:w-2
                    center_block_r = [color_diff_r(j-1,i-1) color_diff_r(j-1,i)  color_diff_r(j-1,i+1)  color_diff_r(j,i-1)  color_diff_r(j,i) color_diff_r(j,i+1)  color_diff_r(j+1,i-1) color_diff_r(j+1,i)  color_diff_r(j+1,i+1)];
                    center_block_b = [color_diff_b(j-1,i-1) color_diff_b(j-1,i)  color_diff_b(j-1,i+1)  color_diff_b(j,i-1)  color_diff_b(j,i) color_diff_b(j,i+1)  color_diff_b(j+1,i-1) color_diff_b(j+1,i)  color_diff_b(j+1,i+1)];
                    R_intped(j,i) = median(center_block_r)+G_intped(j,i);
                    B_intped(j,i) = median(center_block_b)+G_intped(j,i);
                end
            end
            color_diff_gb = G_intped - B_intped;
            color_diff_gr = G_intped - R_intped;
            for j = 2:h-2
                for i = 2:w-2
                    center_block_gr = [color_diff_gr(j-1,i-1) color_diff_gr(j-1,i)  color_diff_gr(j-1,i+1)  color_diff_gr(j,i-1)  color_diff_gr(j,i) color_diff_gr(j,i+1)  color_diff_gr(j+1,i-1) color_diff_gr(j+1,i)  color_diff_gr(j+1,i+1)];
                    center_block_gb = [color_diff_gb(j-1,i-1) color_diff_gb(j-1,i)  color_diff_gb(j-1,i+1)  color_diff_gb(j,i-1)  color_diff_gb(j,i) color_diff_gb(j,i+1)  color_diff_gb(j+1,i-1) color_diff_gb(j+1,i)  color_diff_gb(j+1,i+1)];
                    G_intped(j,i) = (median(center_block_gr)+R_intped(j,i)+median(center_block_gb)+B_intped(j,i))/2;                    
                end
            end
            reap_times=reap_times-1;
        end
        RGB_OUT = cat(3,R_intped,G_intped,B_intped);
        figure,imshow(uint8(RGB_OUT)),title('RGB_OUT');
end
