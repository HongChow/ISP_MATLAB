x=4:1:2^16;
y=round((2^17)*1./x);
x1 = 4:1:1000;
y1=round((2^17)*1./x1);
x2 = 1000:2000;
y2=round((2^17)*1./x2);
x3 = 2000:3000;
y3=round((2^17)*1./x3);
x4 = 3000:4000;
y4=round((2^17)*1./x4);
x5 = 4000:5000;
y5=round((2^17)*1./x5);
x6 = 5000:6000;
y6=round((2^17)*1./x6);
x7 = 6000:7000;
y7=round((2^17)*1./x7);
x8 = 7000:8000;
y8=round((2^17)*1./x8);
x9 = 8000:9000;
y9=round((2^17)*1./x9);
x10 = 9000:10000;
y10=round((2^17)*1./x10);

x11 = 10000:15000;
y11=round((2^17)*1./x11);
x12 = 15000:20000;
y12=round((2^17)*1./x12);
x13 = 20000:25000;
y13=round((2^17)*1./x13);
x14 = 25000:30000;
y14=round((2^17)*1./x14);
x15 = 30000:35000;
y15=round((2^17)*1./x15);
x16 = 35000:40000;
y16=round((2^17)*1./x16);
x17 = 40000:45000;
y17=round((2^17)*1./x17);
x18 = 45000:50000;
y18=round((2^17)*1./x18);
x19 = 50000:55000;
y19=round((2^17)*1./x19);
x20 = 55000:60000;
y20=round((2^17)*1./x20);
x21 = 60000:65000;
y21=round((2^17)*1./x21);
x22 = 65000:70000;
y22=round((2^17)*1./x22);
figure(11);plot(x11,y11);title('10000~15000');
figure(12);plot(x12,y12);title('15000~20000');
figure(13);plot(x13,y13);title('20000~25000');
figure(14);plot(x14,y14);title('25000~30000');
figure(15);plot(x15,y15);title('30000~35000');
figure(16);plot(x16,y16);title('35000~40000');
figure(17);plot(x17,y17);title('40000~45000');
figure(18);plot(x18,y18);title('45000~50000');
figure(19);plot(x19,y19);title('50000~55000');
figure(20);plot(x20,y20);title('55000~60000');
figure(21);plot(x21,y21);title('60000~65000');
figure(23);plot(x22,y22);title('65000~70000');

figure(24);title('range 10000~70000')
subplot(3,4,1);plot(x11,y11);title('10000~15000');
subplot(3,4,2);plot(x11,y11);title('10000~15000');
subplot(3,4,3);plot(x12,y12);title('15000~20000');
subplot(3,4,4);plot(x13,y13);title('20000~25000');
subplot(3,4,5);plot(x14,y14);title('25000~30000');
subplot(3,4,6);plot(x15,y15);title('30000~35000');
subplot(3,4,7);plot(x16,y16);title('35000~40000');
subplot(3,4,8);plot(x17,y17);title('40000~45000');
subplot(3,4,9);plot(x18,y18);title('45000~50000');
subplot(3,4,10);plot(x19,y19);title('50000~55000');
subplot(3,4,11);plot(x20,y20);title('55000~60000');
subplot(3,4,12);plot(x21,y21);title('60000~65000');
subplot(3,4,13);plot(x22,y22);title('65000~70000');


figure(25);
subplot(3,4,1);plot(x1,y1);title('4~1000');
subplot(3,4,2);plot(x2,y2);title('1000~2000');
subplot(3,4,3);plot(x3,y3);title('2000~3000');
subplot(3,4,4);plot(x4,y4);title('3000~4000');
subplot(3,4,5);plot(x5,y5);title('4000~5000');
subplot(3,4,6);plot(x6,y6);title('5000~6000');
subplot(3,4,7);plot(x7,y7);title('6000~7000');
subplot(3,4,8);plot(x8,y8);title('7000~8000');
subplot(3,4,9);plot(x9,y9);title('8000~9000');
subplot(3,4,10);plot(x10,y10);title('9000~10000');


x_1 = 4:1:256;
y_1=round((2^17)*1./x_1);
x_2 = 256:512;
y_2=round((2^17)*1./x_2);
x_3 = 512:1000;
y_3=round((2^17)*1./x_3);
figure(1);plot(x_1,y_1);title('1/x_1');
figure(2);plot(x_2,y_2);title('1/x_2');
figure(3);plot(x_3,y_3);title('1/x_3');




x_4 = 2000:1:15000;
y_4=round((2^17)*1./x_4);
figure(4);plot(x_4,y_4);title('1/x_4');

x2 = 1000:2000;
y2=round((2^17)*1./x2);
figure(5);plot(x2,y2);title('1000~2000');
