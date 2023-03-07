function demoOnImageClick(I)
clc;
%clear;
imObj = imread(I);
disp(size(imObj));
figure;
hAxes = axes();
imageHandle = imshow(imObj);
set(imageHandle,'ButtonDownFcn',@ImageClickCallback);
end
function coordinates = ImageClickCallback ( objectHandle , eventData )
axesHandle  = get(objectHandle,'Parent');
coordinates = get(axesHandle,'CurrentPoint'); 
coordinates = coordinates(1,1:2);
end
