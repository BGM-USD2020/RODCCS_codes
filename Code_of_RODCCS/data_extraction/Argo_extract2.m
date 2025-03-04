%%-------------------------------------------------------------------------
%  Written in 2024.5.10 CeceWang at IMST, SDU, in QD
%  The purpose is to read table data(Argo)
%%-------------------------------------------------------------------------
%------------------------------- Argo -------------------------------------
clear
cd  'E:\y-cc\RODECS\Argo';
namelist_lon = dir(['E:\y-cc\RODECS\Argo\','*lon.mat']);
namelist_lat = dir(['E:\y-cc\RODECS\Argo\','*lat.mat']);
namelist_pres = dir(['E:\y-cc\RODECS\Argo\','*pre.mat']);
namelist_time = dir(['E:\y-cc\RODECS\Argo\','*juld.mat']);
namelist_oxy = dir(['E:\y-cc\RODECS\Argo\','*oxy.mat']);
namelist_salt = dir(['E:\y-cc\RODECS\Argo\','*salt.mat']);
namelist_temp = dir(['E:\y-cc\RODECS\Argo\','*temp.mat']);
% l = length(namelist);
for v=1:26
    lon_name = namelist_lon(v).name;
    lat_name = namelist_lat(v).name;
    pres_name = namelist_pres(v).name;
    time_name = namelist_time(v).name;
    oxy_name = namelist_oxy(v).name;
    salt_name = namelist_salt(v).name;
    temp_name = namelist_temp(v).name;
    load (lon_name);
    load (lat_name);
    load (pres_name);
    load (time_name);
    load (oxy_name);
    load (salt_name);
    load (temp_name);
    l = size(temp,1);
    k = size(temp,2);
    for i=1:k
    data((1+l.*(i-1)):(i.*l),1) = longitude(i);
    data((1+l.*(i-1)):(i.*l),2) = latitude(i);
    data((1+l.*(i-1)):(i.*l),3) = sw_dpth(squeeze(pressure(:,i)),latitude(i)');
    time = (datestr(juld,24));
    data((1+l.*(i-1)):(i.*l),4) = str2num(time(i,7:10));
    data((1+l.*(i-1)):(i.*l),5) = str2num(time(i,4:5));
    data((1+l.*(i-1)):(i.*l),9) = str2num(time(i,1:2));
    data((1+l.*(i-1)):(i.*l),6) = temp(:,i);
    data((1+l.*(i-1)):(i.*l),7) = salinity(:,i);
    data((1+l.*(i-1)):(i.*l),8) = oxygen(:,i);
    end

    if v==1
       j = 0;
       data_argo((1+j):(k.*l),:) = data;
    else
       j = size(data_argo,1);
       data_argo((1+j):(j+(k.*l)),:) = data;
    end
%     scatter(data(:,8),-data(:,3));
%     title(oxy_name);
%     print(['ArgoDO',num2str(v),'.tif'],'-dtiff');
%     close;
    clear data;
end
lon = data_argo(:,1);
lat = data_argo(:,2);
depth = data_argo(:,3);
year = data_argo(:,4);
month = data_argo(:,5);
temp = data_argo(:,6);
salt = data_argo(:,7);
oxy = data_argo(:,8);
day = data_argo(:,9);

%% -------------------- quality check ----------------------------
% ------------------------- Location check --------------------------------
% ---------------------- Depth positive check -----------------------------
location_index = find(lon<=135&lon>=116&lat<=42&lat>=20);
depth_index = find(depth>=0);
qc1(1:length(lon)) = 4; 
qc2(1:length(lon)) = 4;
qc1(location_index) = 3; 
qc2(depth_index) = 3; 
%%
timea(1:length(lon)) = nan;
Argo_data1 = [lon,lat,depth,year,month,day,timea',temp,salt,oxy];
Argo(1:2,:) = [qc1',qc2']';
Argo(5,:) = 1;
Argo(8,:) = 2;
Argo(9:18,:) = Argo_data1';

save (['E:\y-cc\RODECS\Argo\',['Argo.mat']],'Argo');