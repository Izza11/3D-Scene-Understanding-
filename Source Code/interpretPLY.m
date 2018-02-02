function [X,Y,Z,C] = interpretPLY(ply_file)

X = [];
Y = [];
Z = [];
C = [];

fID = fopen(ply_file);

points = fscanf(fID, '%*s\n %*s %*s %*f\n %*s %*s %d\n',1);
for i=1:9
    for j=1:2
        fscanf(fID,'%s ',1);
    end
    fscanf(fID,'%s\n',1);
end
fscanf(fID,'%s\n',1);

for i=1:points
    X=[X;
        fscanf(fID,'%f',1)];
    Y = [Y;
        fscanf(fID,'%f',1)];
    Z = [Z;
        fscanf(fID,'%f',1)];
    ignore = fscanf(fID,'%f',3);
    C = [C;
        fscanf(fID,'%d',3)'];
end

fclose(fID);