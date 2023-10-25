x = 0:0.125:16;
y = exp(-x);
y_enlarge = y./y(end);
high = y_enlarge(1:84);
high = high./high(end);
high_round = round(high);

high_end = y_enlarge(1)/(2^15);
high_norm = high./high_end;

low = y_enlarge(46:end);
low_norm = low;
low_round = round(low_norm);
figure(1),plot(low_round,'color',[1 0 0]);
figure(2),plot(high_round,'color',[0 1 0]);