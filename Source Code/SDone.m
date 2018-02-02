clc; close all; clear;
% V = [0 0 0; 2 0 0; 2 0 2; 0 0 2; 0 2 2; 0 2 0 ; 2 2 0; 2 2 2];
[V,F] = read_vertices_and_faces_from_obj_file('cubeobj.obj');
% % figure;
% % h = trisurf(F,V(:,1),V(:,2),V(:,3),'FaceColor',[0.26,0.33,1.0 ]);
% % light('Position',[-1.0,-1.0,100.0],'Style','infinite');
% % lighting phong;
% plot3(V(:,1), V(:,2), V(:,3), 'o');

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
for i = 1:5000
    r = randperm(no_of_points);
    r = r(1:3);   % 2, 4, 9
    P1 = V(r(1),:);
    P2 = V(r(2),:);
    P3 = V(r(3),:);
    normal = cross(P1-P2, P1-P3);
    %9*x - 10*y + 31*z - 112
    d = normal * (P1');  % d is -ve here i.e ax+by+cz = -d for d to be +ve do (-P1')
    point_array = [];
    score = 0;
    %Checking if points in PC lie on plane i
    for j = 1:1:size(V,1) %increment score if point lies on plane
       point = V(j,:);
       if normal * point' == d 
           score = score + 1;
           point_array(score,:) = point; % [a b c; d e f;...]
       end
    end
    if score > updateScore
        updateScore = score;
        NorPoints = point_array;
    end
%     if score > 3 && score > UPscore %if more than 3 points lie on plane check plane width
%         UPscore = score;
%     
%     end
end
P1 = NorPoints(1,:);  P2 = NorPoints(2,:);  P3 = NorPoints(3,:);
normal = cross(P1-P2, P1-P3);
obj_pos = mean(NorPoints, 1);
figure;
plot3(V(:,1), V(:,2), V(:,3), 'o', 'MarkerFaceColor', 'r');
hold on;
plot3(obj_pos(1), obj_pos(2), obj_pos(3), 'o', 'MarkerFaceColor', 'g');
hold on;
plot3(NorPoints(:,1),NorPoints(:,2), NorPoints(:,3), 'o', 'MarkerFaceColor', 'b');
%%%%%%%%%%%%%%%%%%%%
e = P1; % your point [x0,y0,z0]
d = normal; % your normal vector 
r = e + 1.5.*d; % end position of normal vector

%quiver3 syntax: quiver3(x,y,z,u,v,w)
plot3([e(1);r(1)], [e(2); r(2)], [e(3); r(3)]);






