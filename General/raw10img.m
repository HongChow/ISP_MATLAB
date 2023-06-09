function rawimg = raw10img(input,width,height)

% width = 1920; 
% height = 1080; 

%  width = 2560; 
%  height = 1440;

% width = 2304; 
% height = 1296;

% width = 800; 
% height = 480; 
% width = 1600; 
% height = 1200; 


% width = 4656; 
% height = 3504;% 8M
% 
% width=3264;
% height=2448;

width2 = width / 4 * 5;
input = reshape(input, width2, height);
input = input';
rawimg(:, 1:4:width) = input(:,1:5:width2);
rawimg(:, 2:4:width) = input(:,2:5:width2);
rawimg(:, 3:4:width) = input(:,3:5:width2);
rawimg(:, 4:4:width) = input(:,4:5:width2);
rawimg(:, 1:4:width) = bitshift(rawimg(:, 1:4:width), 2) + bitshift(bitand(input(:,5:5:width2), 192), -6); 
rawimg(:, 2:4:width) = bitshift(rawimg(:, 2:4:width), 2) + bitshift(bitand(input(:,5:5:width2), 48), -4); 
rawimg(:, 3:4:width) = bitshift(rawimg(:, 3:4:width), 2) + bitshift(bitand(input(:,5:5:width2), 12), -2);
rawimg(:, 4:4:width) = bitshift(rawimg(:, 4:4:width), 2) + bitand(input(:,5:5:width2), 3);


% inputlen = width * height / 4 * 5;
% rawimg = zeros(height, width);
% for i = 1 : inputlen
%         bLSB = mod(i, 5); 
%         ind = floor(i / 5) * 4 + bLSB;
%         jj = mod(ind-1, width) + 1;
%         ii = floor((ind - 1) / width)+1;
%         if (bLSB == 0) % lsb byte
%             rawimg(ii, jj - 3) = bitshift(rawimg(ii, jj - 3), 2) + bitshift(bitand(input(i), 192), -6); 
%             rawimg(ii, jj - 2) = bitshift(rawimg(ii, jj - 2), 2) + bitshift(bitand(input(i), 48), -4); 
%             rawimg(ii, jj - 1) = bitshift(rawimg(ii, jj - 1), 2) + bitshift(bitand(input(i), 12), -2); 
%             rawimg(ii, jj) = bitshift(rawimg(ii, jj), 2) + bitand(input(i), 3); 
%         else
%             rawimg(ii,jj) = bitand(input(i), 255); 
%         end
% end
