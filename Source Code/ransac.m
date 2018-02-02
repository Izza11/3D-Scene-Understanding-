% clc; close all; clear;
% 
% filename = 'teapot2.obj';
% [Obj_nor,V,Vsort,Faces,ObjWidth,ObjLength] = virtual_obj_properties(filename);
% I = imread('img.jpg');
% s = size(I);
% w = s(2);
% h = s(1);
% n = 3;
% % V = 301x4
% 
% [PC,RT,fL,X,Y,Z,C] = load_PC(1,'F:\LUMS\semester7\sproj_1\Assignments\1\code\osm-bundler-jqf1ol\bundle\bundle.out',1,w,h);
% 
% %% Ransac Algorithm - 
% %choose 3 random points
% %calculate plane
% %check how many remaining points lie on plane
% %give them a score, update score and update ppoints 2D array
% no_of_points = size(PC,1)/4;
% UPscore = 0;
% tolerance = 0.00005;
% final_normal = [];
% NorPoints = [];
% for i = 1:5000
%     r = randperm(no_of_points);
%     r = r(1:3);   % 2, 4, 9
%     P1 = transpose(PC(4*(r(1)-1) + 1 : (4*(r(1)-1) + 1) + 2, 1));
%     P2 = transpose(PC(4*(r(2)-1) + 1 : (4*(r(2)-1) + 1) + 2, 1));
%     P3 = transpose(PC(4*(r(3)-1) + 1 : (4*(r(3)-1) + 1) + 2, 1));
%     normal = cross(P1-P2, P1-P3);
%     %9*x - 10*y + 31*z - 112
%     d = normal * (P1');  % d is -ve here i.e ax+by+cz = -d for d to be +ve do (-P1')
%     point_array = [];
%     score = 0;
%     %Checking if points in PC lie on plane i
%     for j = 1:4:size(PC,1) %increment score if point lies on plane
%        point = PC(j:j+2,1);
%        if point(1,1)*normal(1) + point(2,1)*normal(2) + point(3,1)*normal(3) == d 
%            score = score + 1;
%            point_array(score,:) = point'; % [a b c; d e f;...]
%        end
%     end
%     if score > 4
%         if ~((point_array(1,1)-point_array(2,1) < tolerance || point_array(1,1)-point_array(3,1) < tolerance || point_array(1,1)-point_array(4,1) < tolerance))
%             [boundX, boundZ] = compute_boundary(point_array(:,1)', point_array(:,3)');
%             NorPoints = point_array;
%             final_normal = normal;
%         end
%     end
% %     if score > 3 && score > UPscore %if more than 3 points lie on plane check plane width
% %         UPscore = score;
% %     
% %     end
% end
% P1 = NorPoints(1,:);  P2 = NorPoints(2,:);  P3 = NorPoints(3,:);
% 
% obj_pos = mean(NorPoints, 1);
% 
% translation = transpose(Vsort(1,1:3) - obj_pos);
% translation(4,1) = 1;
% translation = horzcat([1 0 0; 0 1 0; 0 0 1; 0 0 0], translation);
% rotvec_between_normals = vrrotvec(final_normal,Obj_nor);
% rbn_rot_matrix = vrrotvec2mat(rotvec_between_normals);
% RT_obj = horzcat(rbn_rot_matrix, translation(1:3,4)); %first rotate then translate
% RT_obj = vertcat(RT_obj, [0 0 0 1]);
% V_3D_to_3D = RT_obj * V';  % V = 4x301
% save('tea.mat', 'V_3D_to_3D');
% k = load ('tea.mat');
dlmwrite('teaPot.txt',V_3D_to_3D(1:3,:)','newline','pc');
dlmwrite('TPfaces.txt',Faces,'newline','pc');
% fid = fopen('teaPot.txt','w');
% fprintf(fid,'%.0f\t%.0f\r\n');
% fid = fclose(fid);
% dlmwrite('teaPot2.txt',V_3D_to_3D,'precision',4,'delimiter',' ');
% myMatrix2 = double(V_3D_to_3D);
% save teaPot2.txt myMatrix2 -ASCII;


