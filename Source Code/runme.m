clc; close all; clear;

filename = 'teapot2.obj';
[Obj_nor,V,Vsort,Faces] = virtual_obj_properties(filename);
I = imread('4.jpg');
s = size(I);
w = s(2);
h = s(1);
n = 3;
% V = 301x4

[PC,RT,fL,X,Y,Z,C] = load_PC(1,'F:\LUMS\semester7\sproj_1\Assignments\1\code\osm-bundler-jqf1ol\bundle\bundle.out',4,w,h);

fig = figure;
imagesc([0 w], [0 h], I);
hold on;
p = impoly;
pos=getPosition(p);
% close(fig);
dpiX = PC(1,2)/abs(PC(1,1));  dpiY = PC(2,2)/abs(PC(2,1)); % dots per pixel

count = 0;
for i = 1:4:size(PC,1)
    in = inpolygon(PC(i,2),PC(i+1,2),pos(:,1),pos(:,2));
    if in == 1
        count = count + 1;
        NorPoints(count,1) = PC(i,1);   Dp(count,1) = PC(i,2);
        NorPoints(count,2) = PC(i+1,1);  Dp(count,2) = PC(i+1,2);
        NorPoints(count,3) = PC(i+2,1);  Dp(count,3) = PC(i+2,2);
    end
end
xq = Dp(:,1); yq = Dp(:,2);
plot(xq,yq,'r+'); % points inside
hold off;
% figure;
% plot3(NorPoints(:,1),NorPoints(:,2),NorPoints(:,3),'r+');
if count < 3
    disp('not enough points to calculate normal');
end
P1 = NorPoints(1,:);  P2 = NorPoints(2,:);  P3 = NorPoints(3,:);
% figure(99);
% plot3(NorPoints(:,1), NorPoints(:,2), NorPoints(:,3), 'o');
normal = cross(P1-P2, P1-P3);
normal = normal/norm(normal);
obj_pos = mean(NorPoints, 1);

translation = transpose(Vsort(1,1:3) - obj_pos);
translation(4,1) = 1;
translation = horzcat([1 0 0; 0 1 0; 0 0 1; 0 0 0], translation);
rotvec_between_normals = vrrotvec(normal,Obj_nor);
rbn_rot_matrix = vrrotvec2mat(rotvec_between_normals);
Rot_obj = horzcat(rbn_rot_matrix, [0; 0; 0;]);           %first rotate then translate
Rot_obj = vertcat(Rot_obj, [0 0 0 1]);
K = [fL 0 0; 0 fL 0; 0 0 1];

scaled = [0.1 0 0 0; 0 0.1 0 0; 0 0 0.1 0; 0 0 0 1];
PovV = translation  * Rot_obj * scaled * V';
V_3D_to_2D = K * RT * PovV;  % V = 4x301
V_3D_to_2D = V_3D_to_2D';
V_3D_to_2D = V_3D_to_2D(:,1:2);

PovV = PovV(1:3, :)';
PovFaces = Faces;
O = ones(576,3);
PovFaces = PovFaces - O;

dlmwrite('teaPot.txt',PovV,'newline','pc');
dlmwrite('TPfaces.txt',PovFaces,'newline','pc');

R = RT(1:3, 1:3);
TM = R'*RT;
TM = TM(:, 4)';
CamPovRay = vertcat(normal, TM);
CamPovRay = vertcat(CamPovRay, R); 
dlmwrite('camera.txt',CamPovRay,'newline','pc');

figure;
plot3(CamPovRay(2,1),CamPovRay(2,2),CamPovRay(2,3),'go', 'MarkerSize', 10);
hold on;
plot3(PovV(:,1), PovV(:,2), PovV(:,3), 'r.');
hold off;

figure;
I = imread('4.JPG');
xl = xlim; yl = ylim;
imagesc([0 w], [0 h], I) %flipdim(I, 1));
hold on;
% figure;
patch('Faces',Faces,'Vertices',V_3D_to_2D,'FaceColor','red');
% set(gca,'ydir','normal');

% % saveas(fig, 'now', 'jpeg');
% % close(fig);
% % reflect in zy axis;




