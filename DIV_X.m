x=4:1:2^16;
y=floor((2^17)*1./x);
x1 = 4:1:10000;
y1=floor((2^17)*1./x1);
x2 = 4:1:200;
y2=floor((2^17)*1./x2);
x3 = 200:1000;
y3=floor((2^17)*1./x3);
figure(1);plot(x,y);title('1/x');
figure(2);plot(x1,y1);title('1/x1');
figure(3);plot(x2,y2);title('1/x2');
figure(4);plot(x3,y3);title('1/x3');

x4 = 1000:2000;
y4=floor((2^17)*1./x4);
figure(5);plot(x4,y4);title('1/x4');


x5 = 1:1000;
y5=floor((2^17)*1./x5);
figure(6);plot(x5,y5);title('1/x5');
