clc
i=imread('t.bmp');
%imshow(i);
a=rgb2gray(i);
%bw=edge(a,'canny');
%imshow(bw);
%bw = bwareaopen(bw,30);
%se = strel('disk',2);
%bw = imclose(bw,se);
%bw = imfill(bw,'holes');
%imshow(bw);
bw=im2bw(a);
%regionprops(bw)

L = bwlabel(bw);
figure;imshow(L);
s  = regionprops(L);
dt  = regionprops(L, 'area');
cv = regionprops(L, 'perimeter');
BW_filled = imfill(bw,'holes');
boundaries = bwboundaries(BW_filled);
figure;imshow(i);
hold on;
for k=1:size(s,1)
    bo= boundaries{k};
    for i=1:size(bo,1) %tinh các khoang cách tu biên den trong tâm hinh
        khoangcach{k}(1,i) = sqrt ( ( bo(i,2) - s(k).Centroid(1) )^2 + ( bo(i,1) - s(k).Centroid(2) )^2 );
    end 
    a=max(khoangcach{k}); %chon ra 2 khoang cách lon nhat (a) và bé nhat (b) den trong tâm vùng
    b=min(khoangcach{k});
    c=dt(k).Area; %dien tích cua tung vùng
    dolech=a-b;
    %tim ti le giua dien tích that su vùng và dien tích tích dua vào a & b
    vuong = c/(4*b^2)
    chunhat=c/(4*b*(a^2-b^2)^0.5)
    tamgiacdeu=(c*3^0.5)/((a+b)^2)
    elip =c/(a*b*pi)
    thoi= (c*( a^2 - b^2 )^0.5) / (2*a^2*b)
       
    
    if dolech < 10
            text(s(k).Centroid(1)-20,s(k).Centroid(2),'circle','color','black');
    elseif (vuong < 1.05 ) & (vuong > 0.95 )
            text(s(k).Centroid(1)-20,s(k).Centroid(2),'square','color','black');
    elseif (elip < 1.05 ) & (elip > 0.95 )
            text(s(k).Centroid(1)-20,s(k).Centroid(2),'ellipse','color','black');
    elseif (thoi < 1.05 ) & (thoi > 0.95 )
            text(s(k).Centroid(1)-20,s(k).Centroid(2),'diamond','color','black');
    elseif ((chunhat <1.15) & (chunhat >0.85))
            text(s(k).Centroid(1)-20,s(k).Centroid(2),'rectangle','color','black');
    elseif  (tamgiacdeu < 1.05 ) & (tamgiacdeu > 0.95 )
            text(s(k).Centroid(1)-20,s(k).Centroid(2),'triangle','color','black');
    end
   
end