clc; close all; clear;
[V,F] = read_vertices_and_faces_from_obj_file('cubeobj.obj');
figure;
h = trisurf(F,V(:,1),V(:,2),V(:,3),'FaceColor',[0.26,0.33,1.0 ]);
% axis vis3d
% axis equal
% campos([0,20,150]);
% camtarget([0,10,1]);

VOnes = ones(size(V,1),1);
V = horzcat(V, VOnes); %152x4

%% Camera model
CamInt = [1 0 0 0; 0 1 0 0; 0 0 1 0];
Rotx = [1 0 0 0; 0 cosd(-45) -sind(-45) 0; 0 sind(-45) cosd(-45) 0; 0 0 0 1];
Roty = [cosd(-45) 0 sind(-45) 0; 0 1 0 0; -sind(-45) 0 cosd(-45) 0; 0 0 0 1];
Trans = [1 0 0 10; 0 1 0 0; 0 0 1 0; 0 0 0 1];
CamExt = Trans * Rotx * Roty;
Pic = Trans * V';  %V = 4x152
Pic = Pic';
figure;
s = patch('Faces',F,'Vertices',Pic(:,1:2),'FaceColor','red');
xlim([-20 20]);
ylim([0 30]);
% dlmwrite('chess.txt',V(:,1:3),'newline','pc');
% O = ones(size(F,1),3);
% F = F - O;
% dlmwrite('chessFaces.txt',F,'newline','pc');
% camva;
% campos
% camtarget
% 
% 
% % for k = 1:length(s) 
% %   c = get(s(k), 'cdata'); 
% %   c(c<-.1) = nan;
% %   set(s(k), 'cdata', c)
% % end





