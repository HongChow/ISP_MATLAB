function CTMF2()

img = imread('lena512.bmp');
[m,n] = size(img);

for i = 1:1000
    x = ceil(rand(1,1)*m);
    y = ceil(rand(1,1)*n);
    img(x,y) = 255;
end;

for i = 1:1000
    x = ceil(rand(1,1)*m);
    y = ceil(rand(1,1)*n);
    img(x,y) = 0;
end;

t = zeros(n,256);
T = zeros(1,256);
img2 = zeros(m,n);

for j = 1:n
     t(j,img(1,j)+1) = t(j,img(1,j)+1)+1;
     t(j,img(2,j)+1) = t(j,img(2,j)+1)+1;
     t(j,img(3,j)+1) = t(j,img(3,j)+1)+1;
end

tic;
for i = 1:m
    if i~=m && i~=1 && i~=2
         for j = 1:n
             t(j,img(i-2,j)+1) = t(j,img(i-2,j)+1)-1;
             t(j,img(i+1,j)+1) = t(j,img(i+1,j)+1)+1;
        end
    end
    for j = 1:n
        if i~=1 && i~=m && j~=1 && j~=n
            if j==2
             	T = t(j-1,:)+t(j,:)+t(j+1,:);
            else
                T = T-t(j-2,:)+t(j+1,:);
            end
            count = 0;
             for k = 1:256
                count = count+T(k);
                if count>=5
                    img2(i,j) = k-1;
                    break;
                end
             end
        else
            img2(i,j) = img(i,j);
        end
    end
end
toc

img2 = double(img2)/255;
subplot(1,2,1);imshow(img);title('salt&peppy noise');
subplot(1,2,2);imshow(img2);title('CTMF');
