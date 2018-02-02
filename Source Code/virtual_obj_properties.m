function [ normal,V,Vsort,F, width, length] = virtual_obj_properties( filename )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[V,F] = read_vertices_and_faces_from_obj_file(filename);
% figure;
% h = trisurf(F,V(:,1),V(:,2),V(:,3),'FaceColor',[0.26,0.33,1.0 ]);
% light('Position',[-1.0,-1.0,100.0],'Style','infinite');
% lighting phong;

% V = 301x3
sizeV = size(V,1);
V = transpose(V);  % V = 3x301
o = ones(1, sizeV);
V = vertcat(V, o);  % V = 4x301
Rz = [cosd(90) -sind(90) 0 0; sind(90) cosd(90) 0 0; 0 0 1 0; 0 0 0 1];
Ry = [cosd(90) 0 sind(90) 0; 0 1 0 0; -sind(90) 0 cosd(90) 0; 0 0 0 1];
Rx = [1 0 0 0; 0 cosd(180) -sind(180) 0; 0 sind(180) cosd(180) 0; 0 0 0 1];

xmin = min(V(:,1));
xmax = max(V(:,1));
zmin = min(V(:,3));
zmax = max(V(:,3));
ymin = min(V(:,2));
ymax = max(V(:,2));

length = abs(xmax - xmin);
width = abs(zmax - zmin);
displace = ymax - ymin;
Ty = [1 0 0 0; 0 1 0 displace; 0 0 1 0; 0 0 0 1];

V = Ty * Rx * V;

V = V';  % V = 301x4
baseMin = min(V(:,2));

if nnz(V(:,2)==baseMin) < 3 % i.e if min value exits only once then 
    %find 2nd min y value of obj to for calculating base normal
    out = sort(unique(V(:,2)));
    min2 = out(2);  % 2nd min value found
    %now find 3 vertices that contain 2nd z min
    Vsort = sortrows(V,2); 
    count = 0;
    index = 1;
    normal_points = ones(3,3);
    while count < 3
        if Vsort(index,2) == min2
           count = count + 1;
           normal_points(count,:) = Vsort(index,1:3);
        end
        index = index + 1;
    end
    PO1 = normal_points(1,:);  PO2 = normal_points(2,:);  PO3 = normal_points(3,:);
    normal = cross(PO1-PO2, PO1-PO3);
    normal = -normal/norm(normal);
    
end

dist_from_orig = transpose([0 0 0 1] - Vsort(1,:));
dist_from_orig(4,1) = 1;
translation = [1 0 0; 0 1 0; 0 0 1; 0 0 0];
translation = horzcat(translation, dist_from_orig);

V = translation * V'; % V = 4x301
V = V';  % V = 301x4


    

% saveas(h,'2Dteapot.jpg');




end

