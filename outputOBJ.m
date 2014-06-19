function [] = outputOBJ(XList, pTexture, textureFilename)

outputTexture = 1;
x = XList(1,:);
y = XList(2,:);
z = XList(3,:);
%tri = delaunay3(x,y,z);
tri = delaunay(x,y);
h = trisurf(tri,x,y,z);

%tri = delaunayn(XList(1:3,:)');



% % points
% p = XList(1:3,:)';
% 
% % radius of the fretting ball 
% r = 1
% 
% % tesselate points if not tesselated yet
% tetr = delaunayn(p);
% 
% %fret the surface
% tri = BallFretting(tetr,p,r);
% size(tri)

%[tri,tnorm]=MyRobustCrust(p);



[textureRows textureCols bits] = size(imread(textureFilename));
numPoints = size(XList,2);

% Output Object (OBJ) file
fid = fopen('3d-reconstruction.obj', 'w');
fprintf(fid,'o 1\r\n');
fprintf(fid,'mtllib 3d-reconstruction.mtl\r\n');

% vertices
for i=1:numPoints
    fprintf(fid,'v %f %f %f\r\n', XList(1,i),XList(2,i),XList(3,i)); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end;

fprintf(fid,'\r\n');

if ( outputTexture == 1 )
    fprintf(fid,'usemtl texture\r\ns 1\r\n');
    fprintf(fid,'\r\n');
    
    % vertex textures
    for i=1:numPoints
        fprintf(fid,'vt %f %f\r\n', pTexture(1,i)/textureCols, 1-pTexture(2,i)/textureRows);
    end;
end;

numTris = size(tri,1);

% faces
for i=1:numTris
    fprintf(fid,'f %d/%d/ %d/%d/ %d/%d/\r\n', tri(i,1),tri(i,1),tri(i,2),tri(i,2),tri(i,3),tri(i,3));
end;

fclose(fid);

% Output Material (MTL) file
fid = fopen('3d-reconstruction.mtl', 'w');
fprintf(fid,'newmtl texture\r\n');
fprintf(fid,'Ns 0\r\n');
fprintf(fid,'Ka 0.0 0.0 0.0\r\n');
fprintf(fid,'Kd 0.8 0.8 0.8\r\n');
fprintf(fid,'Ks 0.8 0.8 0.8\r\n');
fprintf(fid,'d 1\r\n');
fprintf(fid,'illum 2\r\n');
fprintf(fid,'map_Kd %s', textureFilename);
fclose(fid);