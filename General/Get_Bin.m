% ------- Convert Quard Bayer to Traditional Bayer  -------%
% Author: Hong %
% Date : 2022-07-17 %
% function [Recovery_Bayer] = Remosaic_Hong(quard_bayer,radius,flag)
function [Down_Bayer] = Get_Bin(quard_bayer)
% function Remosaic(quard_bayer)
    tic
    [h,w,~] = size(quard_bayer);
    quard_bayer = double(quard_bayer);
    Down_Bayer = double(zeros(size(quard_bayer)/2));    
    for j = 1:h/2
        for i = 1:w/2
            Down_Bayer(j,i) = (quard_bayer(j*2,i*2)+quard_bayer(j*2-1,i*2)+quard_bayer(j*2,i*2-1)+quard_bayer(j*2-1,i*2-1));
        end
    end
    Down_Bayer = Down_Bayer/4;

    toc
    disp('end');
end