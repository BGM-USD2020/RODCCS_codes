clear
close
clc
load R2R_v3.mat;

lon = R2R_ori(:,1);
lat = R2R_ori(:,2);
depth = R2R_ori(:,3);
o2 = R2R_ori(:,10);
location_index = find(lon<=135&lon>=116&lat<=42&lat>=20);
depth_index = find(depth>=0);
qc1(1:length(lon)) = 4; 
qc2(1:length(lon)) = 4;
qc1(location_index) = 3; 
qc2(depth_index) = 3; 

R2R(1,:) = qc1'; 
R2R(2,:) = qc2'; 

R2R(5,:) = 1;
R2R(8,:) = 5; 
R2R(9:18,:) = R2R_ori'; 
save(strcat('E:\y-cc\RODECS\R2R\R2R.mat'),'R2R');