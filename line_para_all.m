x_all = [256,335,427,512,669,833,999,1425,2000,3000,4040,4423,5844,7854,10181,17190,26887];
y_all = [2048,1565,1228,1024,784,629,525,368,262,175,130,119,90,67,51,30,19];

[~,N_picese] = size(x_all);
N_picese = N_picese-1;
K_picese = zeros(1,N_picese);
B_picese = zeros(1,N_picese);
for index=1:N_picese
    K_picese(index) = (y_all(index+1)-y_all(index))/(x_all(index+1)-x_all(index));
end

for index=1:N_picese
    B_picese(index) = round(y_all(index)-K_picese(index)*x_all(index));
end

int_K_picese = round((-K_picese)*(2^9));
int_B_picese = round(B_picese);
