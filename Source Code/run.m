clc; close all; clear;
[V,F] = read_vertices_and_faces_from_obj_file('chess2.obj');
figure;
h = trisurf(F,V(:,1),V(:,2),V(:,3),'FaceColor',[0.26,0.33,1.0 ]);
light('Position',[-1.0,-1.0,100.0],'Style','infinite');
lighting phong;
% O = ones(576,3);
% F = F - O;
% dlmwrite('teaPot.txt',V,'newline','pc');
% dlmwrite('TPfaces.txt',F,'newline','pc');




% V = transpose(V);
% o = ones(1, 301);
% V = vertcat(V, o);
% T = [1 0 0 2; 0 1 0 3; 0 0 1 4; 0 0 0 1];
% Rz = [cosd(90) -sind(90) 0 0; sind(90) cosd(90) 0 0; 0 0 1 0; 0 0 0 1];
% Ry = [cosd(90) 0 sind(90) 0; 0 1 0 0; -sind(90) 0 cosd(90) 0; 0 0 0 1];
% Rx = [1 0 0 0; 0 cosd(90) -sind(90) 0; 0 sind(90) cosd(90) 0; 0 0 0 1];
% V = Rx*V;
% V = transpose(V(1:3, :));
% figure;
% h = trisurf(F,V(:,1),V(:,2),V(:,3),'FaceColor',[0.26,0.33,1.0 ]);
% light('Position',[-1.0,-1.0,100.0],'Style','infinite');
% lighting phong;
% baseMin = min(V(:,3));
% if nnz(V(:,3)==baseMin) < 3 % i.e if min value exits only once then 
%     %find 2nd min z value of obj to for calculating base normal
%     out = sort(unique(V(:,3)));
%     min2 = out(2);  % 2nd min value found
%     %now find 3 vertices that contain 2nd z min
%     Vsort = sort(V,3); 
%     count = 0;
%     index = 1;
%     normal_points = zeros(3,3);
%     while count < 3
%         if V(index,3) == min2
%            count = count + 1;
%            normal_points(count,:) = V(index,:);
%         end
%         index = index + 1;
%     end
%     PO1 = normal_points(1,:);  PO2 = normal_points(2,:);  PO3 = normal_points(3,:);
%     normal = cross(PO1-PO2, PO1-PO3);
%     
% end
%     
% 
% % saveas(h,'2Dteapot.jpg');
% 
% 
