function [PC,RT,fL,X,Y,Z,C] = load_PC(bundler,path2bundler,imageIndex,w,h)

PC = [];
X = [];
Y = [];
Z = [];
C = [];
if(bundler == 0)

    %first point
    PC = [PC;
        -0.2115,536; %x -> x
        0.1142, 78;  %y -> y
        -1.209, 1;   %z -> z
        1, -1];

    %second point
    PC = [PC;
        -0.2889,306;
        0.09376,134;
        -1.19, 1;
        1, -1];

     %third point
    PC = [PC;
        -0.3393, 111;
        0.1097, 83;
        -1.156, 1;
        1, -1];

    %fourth point
    PC = [PC;
        -0.2916, 292;
        0.117, 64;
        -1.197, 1;
        1, -1];    
else
    [camera, point] = interpretBundler(path2bundler);
    RT = [camera(imageIndex).R,camera(imageIndex).t];
    fL = [camera(imageIndex).focalLength];
    counter=0;
    for i=1:size(point,2)
        for j=1:point(i).viewPoints
            if(point(i).views(j).cameraIndex==imageIndex)
                PC = [PC;
                    point(i).position(1),point(i).views(j).keyPos(1)+(w/2);
                    point(i).position(2),(point(i).views(j).keyPos(2)-(h/2))*-1;
                    point(i).position(3),1;
                    1,-1];
                counter = counter+1;
            end
            
        end
        X = [X;
            point(i).position(1)];
        Y = [Y;
            point(i).position(2)];
        Z = [Z;
            point(i).position(3)];
        C = [C;
            point(i).color'];
    end
end
