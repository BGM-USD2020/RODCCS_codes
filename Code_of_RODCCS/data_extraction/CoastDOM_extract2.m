%%-------------------------------------------------------------------------
%  Written in 2024.5.10 CeceWang at IMST, SDU, in QD
%  The purpose is to read table data(CoastDOM)
%%-------------------------------------------------------------------------
clear all
close all
clc
load CoastDOM_v2.mat;
lon = CoastDOM_data(:,1);
lat = CoastDOM_data(:,2);
% lon = CoastDOM(:,2);
% lat = CoastDOM(:,1);
% depth = CoastDOM(:,4);
% temp = CoastDOM(:,5);
% salt = CoastDOM(:,6);
% chla = CoastDOM(:,8);
% no3 = CoastDOM(:,10);
% nh4 = CoastDOM(:,12);
% doc = CoastDOM(:,16);
% don = CoastDOM(:,17);
% dop = CoastDOM(:,19);
% poc = CoastDOM(:,21);
% pn = CoastDOM(:,22);
% pp = CoastDOM(:,23);
% dic = CoastDOM(:,24);
% year = CoastDOM(:,26);
% mon = CoastDOM(:,27);
% o2 = zeros(70823,1);
% Si = zeros(70823,1);
% no2 = zeros(70823,1);
% po4 = zeros(70823,1);
% CoastDOM_data = [lon,lat,depth,year,mon,temp,salt,o2,Si,no3,no2,po4,chla,dic,doc,poc,pp,nh4];
% CoastDOM_data(6:13,:) = nan;
%% -------------------- quality check ----------------------------
% ------------------------- Location check --------------------------------
% ---------------------- Depth positive check -----------------------------
location_index = find(lon<=135&lon>=116&lat<=42&lat>=20);
% depth_index = find(depth>=0);
% disp(length(location_outliers));
% if length(location_outliers)==0&&length(depth_outliers)==0
%     qc1(1:length(lon)) = 3; 
%     qc2(1:length(lon)) = 3; 
% else
qc1(1:length(lon)) = 4; 
% qc2(1:length(lon)) = 4;
qc1(location_index) = 3; 
% qc2(depth_index) = 3; 
% end
%%
CoastDOM1(1:1,:) = [qc1']';
CoastDOM1(5,:) = 1;
CoastDOM1(8,:) = 6;
CoastDOM1(9:27,:) = CoastDOM_data';

save (['E:\y-cc\RODECS\CoastDOM\',['CoastDOM.mat']],'CoastDOM1');