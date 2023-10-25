x0=10;y0=1.0;
    x1=14;y1=0.9;x2=20;y2=0.0;
    k0=(y1-y0)/(x1-x0);
    b0 = y1-k0*x1;
    k1=(y1-y2)/(x1-x2);
    b1 = y1-k1*x1;
    %y = zeros(1,128);
    x = 1:128;
    for k = 1:128
        if(x(k)<x0)
            y(k) = 1.0;
        else
            if(x(k)<x1)
                y(k) = k0*x(k)+b0;
            else
                if(x(k)<x2)
                    y(k) = k1*x(k)+b1;
                else
                    y(k) = 0;
                end
            end
        end
    end
    