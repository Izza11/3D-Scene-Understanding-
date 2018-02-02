clc; close all; clear;
[V,F] = read_vertices_and_faces_from_obj_file('cubeobj.obj');
[Obj_nor,V2,Vsort,F2] = read_obj_canonical('teapot2.obj');

figure;
plot3(V(:,1), V(:,2), V(:,3), 'o', 'MarkerFaceColor', 'b');

%% Ransac Algorithm  
%choose 3 random points
%calculate plane
%check how many remaining points lie on plane
%give them a score, update score and update ppoints 2D array
no_of_points = size(V,1);
updateScore = 3;
tolerance = 0.00005;
final_normal = [];
NorPoints = [];
for i = 1:1000
    r = randperm(no_of_points);
    r = r(1:3);   % 2, 4, 9
    P1 = V(r(1),:);
    P2 = V(r(2),:);
    P3 = V(r(3),:);
    normal = cross(P1-P2, P1-P3);
    if isequal(normal, [0 0 0]) == 0
       
        %9*x - 10*y + 31*z - 112
        d = normal * (P1');  % d is -ve here i.e ax+by+cz = -d for d to be +ve do (-P1')
        point_array = [];
        score = 0;
        %Checking if points in PC lie on plane i
        for j = 1:1:size(V,1) %increment score if point lies on plane
           point = V(j,:);
           d = -d;
%            if normal * point' == d 
%                score = score + 1;
%                point_array(score,:) = point; % [a b c; d e f;...]
%            end
            if abs((normal * point') + d)/norm(normal) < 0.1
                score = score + 1;
                point_array(score,:) = point; % [a b c; d e f;...]
            end
        end
        if score > updateScore
            updateScore = score;
            NorPoints = point_array;
        end
    end
end
normalf = [0 0 0];
while isequal(normalf, [0 0 0])
    r = randperm(size(NorPoints,1));
    r = r(1:3);   % 2, 4, 9
    P1 = NorPoints(r(1),:);
    P2 = NorPoints(r(2),:);
    P3 = NorPoints(r(3),:);
    normalf = cross(P1-P2, P1-P3);
end
obj_pos = mean(NorPoints, 1);
figure;
% plot3(V(:,1), V(:,2), V(:,3), 'o', 'MarkerFaceColor', 'r');
% hold on;
% plot3(obj_pos(1), obj_pos(2), obj_pos(3), 'o', 'MarkerFaceColor', 'g');
% hold on;
plot3(NorPoints(:,1),NorPoints(:,2), NorPoints(:,3), 'o', 'MarkerFaceColor', 'b');
hold on;
%%%%%%%%%%%%%%%%%%%
points_mean = mean(NorPoints,1);
e = points_mean; % your point [x0,y0,z0]
d = normalf; % your normal vector 
r = e + 0.3.*d; % end position of normal vector
rotvec_between_normals = vrrotvec(d,Obj_nor);
rbn_rot_matrix = - vrrotvec2mat(rotvec_between_normals);
Rot_obj = horzcat(rbn_rot_matrix, [0; 0; 0;]);           %first rotate then translate
Rot_obj = vertcat(Rot_obj, [0 0 0 1]);
V2 = [1 0 0 e(1); 0 1 0 e(2); 0 0 1 e(3); 0 0 0 1] * Rot_obj * V2';
V2 = V2';
O = ones(size(F2,1),3);
F2 = F2 - O;
dlmwrite('teaPot.txt',V2(:,1:3),'newline','pc');
dlmwrite('TPfaces.txt',F2,'newline','pc');
plot3([e(1);r(1)], [e(2); r(2)], [e(3); r(3)]);
hold on;
plot3(V2(:,1), V2(:,2), V2(:,3), 'o', 'MarkerFaceColor', 'r');






