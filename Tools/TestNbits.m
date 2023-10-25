NBITS = 15;
maxdiff = 0;
flag = 0;
for i = 1:1:2^27
    if(flag==0)
        flag=1;
        tic
    end    
    if(mod(i,1000)==0)
        disp(i)
        toc
        flag=0;
    end    
    for j=1:1:2^15
        diff = round(4*i/j) - bitshift(i*(round(4*NBITS/j)),NBITS);
        if(diff>maxdiff)
            maxdiff = diff;
        end
    end
end