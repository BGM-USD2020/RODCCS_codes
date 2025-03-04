clear
close
clc
lon_g0 = ncread('D:\y-cc\data\GEBCO\GEBCO_2023_sub_ice_topo.nc','lon');
lat_g0 = ncread('D:\y-cc\data\GEBCO\GEBCO_2023_sub_ice_topo.nc','lat');
depth_g0 = ncread('D:\y-cc\data\GEBCO\GEBCO_2023_sub_ice_topo.nc','elevation');
depth_g = depth_g0(116.*240+180.*240:135.*240+180.*240,20.*240+90.*240:42.*240+90.*240);
lon_g = lon_g0(116.*240+180.*240:135.*240+180.*240);
lat_g = lat_g0(20.*240+90.*240:42.*240+90.*240);

for i=[1:10:length(lon_g)]
     lon_g1((i+9)/10) = mean(lon_g(i:min(i+9,end)),'omitnan');
end
for i=[1:10:length(lat_g)]
     lat_g1((i+9)/10) = mean(lat_g(i:min(i+9,end)),'omitnan');
end
for i=[1:10:length(lon_g)]
     depth_g3((i+9)/10,:) = mean(depth_g(i:min(i+9,end),:),1,'omitnan');
end
for j=[1:10:length(lat_g)]
     depth_g1(:,(j+9)/10) = mean(depth_g3(:,j:min(j+9,end)),2,'omitnan');
end
[lon_g2,lat_g2] = meshgrid(lon_g,lat_g);
depth_g1(depth_g1>0) = nan;

value_name = {'Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC','DOC','POC','NH4'};

% cd 'E:\y-cc\RODECS\final_data_v3';
load 'E:\y-cc\RODECS\GLODAPv2\GLODAPv2.mat';
load 'E:\y-cc\RODECS\Argo\Argo.mat';
load 'E:\y-cc\RODECS\CCHDO\CCHDO.mat';
load 'E:\y-cc\RODECS\chla\Chla.mat';
load 'E:\y-cc\RODECS\R2R\R2R.mat';
load 'E:\y-cc\RODECS\CoastDOM\CoastDOM.mat';
RODECS(1:26,1:17136) = GLODAPv2;
RODECS(8,1:17136) = 5;
RODECS(1:18,17136+1:17136+160605) = Argo;
RODECS(8,17136+1:17136+160605) = 1;
RODECS(1:26,17136+160605+1:17136+160605+317192) = CCHDO;
% Chla(Chla==0) = nan;
RODECS(8,17136+160605+1:17136+160605+317192) = 2;
RODECS(1:23,17136+160605+317192+1:17136+160605+317192+5323) = Chla;
RODECS(8,17136+160605+317192+1:17136+160605+317192+5323) = 3;
RODECS(1:18,17136+160605+317192+5323+1:17136+160605+317192+5323+3373449) = R2R;
RODECS(8,17136+160605+317192+5323+1:17136+160605+317192+5323+3373449) = 6;
RODECS(1:27,17136+160605+317192+5323+3373449+1:17136+160605+317192+5323+3373449+70823) = CoastDOM1;
RODECS(8,17136+160605+317192+5323+3373449+1:17136+160605+317192+5323+3373449+70823) = 4;
lon3 = RODECS(9,:);
lat3 = RODECS(10,:);
depth3 = RODECS(11,:);
id3 = RODECS(8,:);
% month3 = RODECS(13,:);
qc1 = RODECS(1,:);
qc2 = RODECS(2,:);
range_caxis1 = [0 0 0 -5 30 0 0 0 0 0 0 0];
range_caxis2 = [300 1800 10 50 37 400 200 50 0.3 3 2 2500];
% ---------------------- temp ---------------------------------------------
for v=[1 2 3 4 5 6 7 8 9 10 11 12]
    disp(v);
    value3 = RODECS(15+v,:);
    location_index = find(qc1==3);
    lon2 = lon3(location_index);
    lat2 = lat3(location_index);
    depth2 = depth3(location_index);
    
%     value3 = RODECS_value1(14,:)';    
    value2 = value3(location_index);
    if v>1
       value2(value2<=0|value2>10000) = nan; 
    end
    longitude1 = lon2(~isnan(value2));
    latitude1 = lat2(~isnan(value2));
    depth1 = depth2(~isnan(value2));
    value1 = value2(~isnan(value2));

    for n=1:length(longitude1)
        if isnan(longitude1(n))|isnan(latitude1(n))
            qc3_1(n) = 1;
        else
            lon_index1 = find(abs(lon_g-longitude1(n))==min(abs(lon_g-longitude1(n))));
            lon_index(n) = lon_index1(1);
            lat_index1 = find(abs(lat_g-latitude1(n))==min(abs(lat_g-latitude1(n))));
            lat_index(n) = lat_index1(1);
            if depth1(n)<=-depth_g(lon_index1(1),lat_index1(1))&&depth_g(lon_index1(1),lat_index1(1))<0
                delta_depth(n) = -depth1(n)-depth_g(lon_index1(1),lat_index1(1));
                qc3_1(n) = 3;
            else
                delta_depth(n) = -depth1(n)-depth_g(lon_index1(1),lat_index1(1));
                qc3_1(n) = 4;
            end
        end
    end
    delta_depth = delta_depth';
    qc3_2 = zeros(length(value2),1);
    qc3_2(~isnan(value2)) = qc3_1;
    qc3 = zeros(length(value3),1);
    qc3(location_index) = qc3_2;
    qc3_all(v,1:length(qc3)) = qc3;
    
    qc3(qc1==3&qc2==4) = 4;
    qc_time = RODECS(5,:);
    RODECS_value123(1:15,:) = RODECS(1:15,:);
    RODECS_value123(3,:) = qc3;
    RODECS_value123(2,:) = qc_time;
    RODECS_value123(16,:) = RODECS(15+v,:);
    if v==13
       save(strcat('E:\y-cc\RODECS\final_data_v4\qc3_',string(v-1),'RODECS123_',string(value_name(v)),'.mat'),'RODECS_value123');
    else
       save(strcat('E:\y-cc\RODECS\final_data_v4\qc3_',string(v),'RODECS123_',string(value_name(v)),'.mat'),'RODECS_value123');
    end
    
    clear qc_time;
    clear depth_out1;
    clear qc3;
    clear qc3_1;
    clear qc3_2;
end