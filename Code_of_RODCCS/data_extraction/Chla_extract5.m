%%-------------------------------------------------------------------------
%  Written in 2024.5.10 CeceWang at IMST, SDU, in QD
%  The purpose is to read table data(Chla)
%%-------------------------------------------------------------------------
%% ------------------------------ chla ------------------------------------
clear
close
clc
load Bohai.mat;
load CHOICE.mat;
load YE.mat;
load YE103.mat;
chl_data = [Bohai,CHOICE,YE,YE103];

lon = chl_data(1,:);
lat = chl_data(2,:);
depth = chl_data(3,:);
year = chl_data(4,:);
month = chl_data(5,:);
day = chl_data(6,:);
time = chl_data(7,:);
chla = chl_data(8,:);
lon(lon==0) = nan;
lat(lat==0) = nan;
year(year==0) = nan;
month(month==0) = nan;
day(day==0) = nan;


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
Chla(1:2,:) = [qc1',qc2']';
Chla(5,:) = 1;
Chla(8,:) = 4;
Chla(9:15,:) = chl_data(1:7,:);
Chla(23,:) = chl_data(8,:);

save (['E:\y-cc\RODECS\chla\',['Chla.mat']],'Chla');