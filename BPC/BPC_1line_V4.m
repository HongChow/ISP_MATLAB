function output = BPC_1line_V4(data,hot_th,cold_th,C)
% @
% Bad pixel correction using 1 line
% Input:
%       data:CFA Bayer 
%       hot_th,cold_th: hold/cold pixle threshold
%       hot_th=0-1023(10bits) cold_th=0-1023 (10bits Raw); 

% Default Setting:
% hot_th=128;
% cold_th=128;



% Get the size of the image.

[nRows nCols] = size(data); %nRows: Height; nCols: Width
output = double(data);
output0 = double(data);
clear data;

% C = [0.2 0.25 0.5 0.75 0.8];
% C = 0.25;  % larger C --> more BPC
%%
% Boudary Process:  In this code,Skip the first four rows and first four columns; Skip the
% last four rows and last four columns:
% For hard ware implementation, we use duplicate boudary option
% bool flag_left = False;
% bool flag_mid = False;
% bool flag_right = False;
    for i = 5 : 1 : nRows-4
       for j = 5 : 1 : nCols-4
%            flag_left = False;
%            flag_mid = False;
%            flag_right = False;      
           
%            00 01 02 03 04 05
%            10 11 12 13 14 15 
%            20 21 22 23 24 25 % current line, [22] is the current pixel
            row = mod(i, 2); %Odd or Even row: 1->Odd; 0->Even
            col = mod(j, 2); %Odd or Even column : 1->Odd; 0->Even     
            
            Y22 = output(i,j);%Current Pixel
            
            Y11=output(i-1,j-1);Y13=output(i-1,j+1);Y15=output(i-1,j+3);
            Y2p2=output(i,j-4);Y20=output(i,j-2);Y24=output(i,j+2); Y26=output(i,j+4);
            
%             Y21 = output(i,j-1);
            Y21 = output0(i,j-1);
            Y23 = output(i,j+1);
            Y24 = output(i,j+2);
            Y25 = output(i,j+3);
            Y2p1 = output(i,j-3);  
            Y12 = output(i-1,j);
            Y10 = output(i-1,j-2);
            Y14 = output(i-1,j+2);
            
            if (row==1 && col==1)|| (row==0 && col==0)     % RB pixel
                neighbor=[Y2p2 Y20 Y24 Y26];
                neighborn=[Y2p2 Y20 Y26];
                maxNeighbor=max(neighbor);
                minNeighbor=min(neighbor);
                maxNeighborn=max(neighborn);            
                minNeighborn=min(neighborn);
                medNeighbor=fix((sum(neighbor)-minNeighbor-maxNeighbor)/2);
            elseif (row==1 && col==0) || (row==0 && col==1)   % Gr Gb pixel
                neighbor=[Y11 Y13 Y20 Y24 Y26];
                neighborn=[Y11 Y13 Y20 Y26];
%                 neighbor=[Y11 Y13 Y15 Y20 Y24];
%                 neighborn=[Y11 Y13 Y15 Y20];
                maxNeighbor=max(neighbor);
                minNeighbor=min(neighbor);
                maxNeighborn=max(neighborn);            
                minNeighborn=min(neighborn);
                medNeighbor=fix((sum(neighbor)-minNeighbor-maxNeighbor)/3);
            end

            
%             neighbor=[Y00 Y02 Y04 Y20 Y24];
%             maxNeighbor=max(neighbor);
%             minNeighbor=min(neighbor);
%             medNeighbor=(sum(neighbor)-minNeighbor-maxNeighbor)/3;
            
       
       if(Y22>medNeighbor)          
            %------------------White Pixel---------------------
            %Type 1: single defective pixel
            key_diff = Y22-maxNeighbor;
            key_diff_n = Y22-maxNeighborn;            
            if(key_diff> + hot_th)
                shift_key_diff = bitshift(key_diff,-C);
                if((Y21<Y2p1+shift_key_diff) &&(Y23<Y25+shift_key_diff) )
                    if ((Y12< Y10+ shift_key_diff) && (Y12< Y14+ shift_key_diff))
                        output(i,j) = maxNeighbor;%maxNeighbor
                    end
                end
            end
            % Type 4/5/6           
            if key_diff_n> + hot_th
                shift_key_diffn = bitshift(key_diff_n,-C);
                if((Y21<Y2p1+shift_key_diffn)&&((Y23< Y25+ shift_key_diffn)))
                    if((Y12< Y10+ shift_key_diffn) && (Y12< Y14+shift_key_diffn))
                        output(i,j) = maxNeighborn;%maxNeighbor
                    end
                end             
            end
            %------------------White Pixel---------------------          
       else    
            %------------------Black Pixel----------------------
            %Type 1: single defective pixel
            key_diff = Y22-minNeighbor;
            key_diff_n = Y22-minNeighborn;
            if(key_diff< - cold_th)
                shift_key_diff = bitshift(-key_diff,-C);
                if((Y21>Y2p1 - shift_key_diff) &&(Y23>Y25 - shift_key_diff))
                    if ((Y12> Y10 - shift_key_diff) &&(Y12> Y14 - shift_key_diff))
                        output(i,j) = minNeighbor;%maxNeighbor
                    end
                end
            end
            % Type 4/5/6
            if key_diff_n< - cold_th
                shift_key_diff_n = bitshift(-key_diff_n,-C);
                 if((Y21>Y2p1 - shift_key_diff_n) &&(Y23>Y25 - shift_key_diff_n))
                    if ((Y12> Y10 - shift_key_diff_n) &&(Y12> Y14 - shift_key_diff_n))
                        output(i,j) = minNeighborn;%maxNeighbor
                    end
                 end
            end
       end
            
output(i,j)=min(max(output(i,j),0),1023);
% output(i,j)=min(max(output(i,j),0),255);
                
                
       end %end of Column Loop
    end % end of Row Loop
 % for 8bits
% output = uint8(output);




