# matlab
nhandanganh
% Naila Bushra
function [] = detect_object_shape(img)

disp('********inside detect_object_shape function**************');

outlined_img = img;
img = im2bw(img);% img must be rgb and high resolution
img = edge(img);

for mm = 1:size(outlined_img,1)
    for nn = 1:size(outlined_img,2)
        if ((img(mm,nn) == 1))
            outlined_img(mm,nn,:) = [255 0 0]; % red outline in shapes
        end
    end
end


CC = bwconncomp(img);
STATS = regionprops(CC, 'all');

imshow(outlined_img);hold on;

for i = 1:CC.NumObjects
    BB = STATS(i).BoundingBox;
    BW = STATS(i).Image;% each connected object

    BW = bwmorph(BW,'diag');
    
    [H,T,R] = hough(BW);
    P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
    lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',7);
    %disp(length(lines));
    
    Area = STATS(i).FilledArea;
    Perimeter = STATS(i).Perimeter;
    Roundness=(4*Area*pi)/(Perimeter.^2);
        
    if(Roundness > 0.9)
            text(BB(1),BB(2),'Hinh tron','color','blue');
    elseif(length(lines) == 3)
        text(BB(1),BB(2),'Tam giac','color','blue');
    elseif(length(lines) == 4)
        text(BB(1),BB(2),'Hinh chu nhat','color','blue');
    elseif(length(lines) == 5)
        text(BB(1),BB(2),'Ngu giac','color','blue');
    else
        text(BB(1),BB(2),'Khong ro','color','blue');
    end
end
