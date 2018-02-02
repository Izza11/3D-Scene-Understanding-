%%print .ply mesh

path2Ply='F:\LUMS\semester7\sproj_1\Assignments\BA_Bundler\osm-bundler-jqf1ol\pmvs\pmvs_options.txt.ply';

[PLX,PLY,PLZ,PLC] = interpretPLY(path2Ply);
figure(1);
scatter3(PLX,PLY,PLZ,10,PLC./255,'*');
xlabel('X');
ylabel('Y');
zlabel('Z');
