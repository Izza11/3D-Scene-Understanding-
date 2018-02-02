%Batool Abbas, October 2015

function[camera, point] = interpretBundler(bundler_file)

fID = fopen(bundler_file);

num_cameras = fscanf(fID, '# %*s %*s %*s\n%d',1);
num_points = fscanf(fID, ' %d\n',1);

camera = repmat(struct([]),num_cameras,1);
point = repmat(struct([]),num_points,1);
for i = 1:num_cameras
    camera(i).focalLength = fscanf(fID, ' %f ',1);
    camera(i).k1 = fscanf(fID, ' %f ',1);
    camera(i).k2 = fscanf(fID, ' %f\n',1);
    camera(i).R = fscanf(fID, '%f',[3 3]);
    camera(i).t = fscanf(fID,'%f',3);
end

for i = 1:num_points
    point(i).position = fscanf(fID,'%f',3);
    point(i).color = fscanf(fID,'%f',3);
    point(i).viewPoints = fscanf(fID,'%f',1);
    point(i).views = [];
    for j = 1:point(i).viewPoints
        point(i).views(j).cameraIndex = fscanf(fID,'%f',1) + 1;
        point(i).views(j).keyIndex = fscanf(fID,'%f',1) + 1;
        point(i).views(j).keyPos = fscanf(fID,'%f',2);
        %coordinate system has origin at center of image and x-axis
        %increasing to right + y-axis increasing to top
    end
end

%     P = R * X + t       (conversion from world to camera coordinates)
%     p = -P / P.z        (perspective division)
%     p' = f * r(p) * p   (conversion to pixel coordinates)
%     
%     r(p) = 1.0 + k1 * ||p||^2 + k2 * ||p||^4.

fclose(fID);