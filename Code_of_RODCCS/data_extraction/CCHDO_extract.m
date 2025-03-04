%%-------------------------------------------------------------------------
%  Written in 2024.5.10 CeceWang at IMST, SDU, in QD
%  The purpose is to read table data(CCHDO)
%%-------------------------------------------------------------------------
%% --------------------------- CCHDO -----------------------------
clear
clc
close
cd 'E:\y-cc\RODECS\CCHDO\';
load CCHDO_ori.mat;
% path =  'E:\y-cc\RODECS\CCHDO\';
% lon = xlsread([path,'CCHDO.xlsx'],'E3:E48870');
% lat = xlsread([path,'CCHDO.xlsx'],'D3:D48870');
% depth = xlsread([path,'CCHDO.xlsx'],'F3:F48870');
% time = xlsread([path,'CCHDO.xlsx'],'B3:B48870');
% time_s = xlsread([path,'CCHDO.xlsx'],'C3:C48870');
% temp = xlsread([path,'CCHDO.xlsx'],'G3:G48870');
% salt = xlsread([path,'CCHDO.xlsx'],'H3:H48870');
% oxy = xlsread([path,'CCHDO.xlsx'],'J3:J48870');
% Si = xlsread([path,'CCHDO.xlsx'],'L3:L48870');
% NO3 = xlsread([path,'CCHDO.xlsx'],'M3:M48870');
% NO2 = xlsread([path,'CCHDO.xlsx'],'N3:N48870');
% PO4 = xlsread([path,'CCHDO.xlsx'],'O3:O48870');
% CHLA = xlsread([path,'CCHDO.xlsx'],'T3:T48870');
lon = lon_all;
lat = lat_all;
press = pressure_all;
depth = sw_dpth(press,lat);
time = date_all;
time_s = time_all;
temp = ctdtemp_all;
salt = ctdsalt_all;
oxy = oxygen_all;
Si = silicate_all;
NO3 = nitrate_all;
NO2 = nitrite_all;
PO4 = phosphate_all;
CHLA = chla_all;

time1 = num2str(time');
year = str2num(time1(:,1:4));
month = str2num(time1(:,5:6));
day = str2num(time1(:,7:8));

% -------------------- quality check ----------------------------
% ------------------------- Location check --------------------------------
% ---------------------- Depth positive check -----------------------------
location_index = find(lon<=135&lon>=116&lat<=42&lat>=20);
depth_index = find(depth>=0);
qc1(1:length(lon)) = 4; 
qc2(1:length(lon)) = 4;
qc1(location_index) = 3; 
qc2(depth_index) = 3; 
% ---------------------- Time inversion check -----------------------------
% time_date = time(2:end)-time(1:end-1);
% time_second = time_s(2:end)-time_s(1:end-1);
qc5(1:length(time_s)) = 3;
for i=2:length(time_s)
for j = i-1:-1:1
    if time_s(j) ~= time_s(i)
    break
    end
end
 for k = i+1:length(time_s)-1
     if time_s(k) ~= time_s(i)
     break
     end
end
 for l = k:length(time_s)-1
     if time_s(l) ~= time_s(k)
     break
     end
end
 if (time(i)-time(j))==0&(time_s(i)<time_s(j))
     qc5(i) = 4;
 end
if (time(i)-time(k))==0&(time(l)-time(k))==0&(time_s(k)<time_s(i))&(time_s(l)<time_s(k))&qc5(i)==4
     qc5(i) = 3;
end
end
qc5_o = find(qc5==4)';
% time_outliers = find(time_date==0&time_second<0);
% disp(length(time_outliers));
% if length(time_outliers)==4
%     qc5(1:length(lon)) = 3; 
% else
%     qc5(1:length(lon)) = 3; 
%     qc5(1+time_outliers) = 4; 
% end
%

cchdod1 = [lon;lat;depth;year';month';day';time_all;temp;salt;oxy;Si;NO3;NO2;PO4;CHLA];
CCHDO1(1:2,:) = [qc1',qc2']';
CCHDO1(5,:) = [qc5];
CCHDO1(8,:) = 3;
CCHDO1(9:23,:) = cchdod1;

%%
path = 'E:\y-cc\RODECS\DOC\';
filename = 'All_Basins_Data_Merged_Hansell_2022.xlsx';    
lond = xlsread([path,filename],'I:I');
latd = xlsread([path,filename],'H:H');
pressd = xlsread([path,filename],'K:K');
depthd = sw_dpth(pressd,latd);
timed = xlsread([path,filename],'G:G');
tempd = xlsread([path,filename],'L:L');
saltd = xlsread([path,filename],'M:M');
oxyd = xlsread([path,filename],'O:O');
Sid = xlsread([path,filename],'U:U');
NO3d = xlsread([path,filename],'W:W');
NO2d = xlsread([path,filename],'AA:AA');
PO4d = xlsread([path,filename],'Y:Y');
CHLAd = xlsread([path,filename],'Q:Q');
DICd = xlsread([path,filename],'AO:AO');
DOCd = xlsread([path,filename],'AW:AW');
POCd = xlsread([path,filename],'BA:BA');
% PONd = xlsread([path,filename],'BC:BC');
time1d = num2str(timed);
lond(lond>180) = lond(lond>180)-180;
for f=1:268324
    f
    if (time1d(f,1:4))=='    '
         yeard(f) = nan;
         monthd(f) = nan;
         dayd(f) = nan;
    else if str2num(time1d(f,1:4))<1500
            yeard(f) = str2num(time1d(f,2:5));
            monthd(f) = str2num(time1d(f,6:7));
            dayd(f) = str2num(time1d(f,8));
        else
            yeard(f) = str2num(time1d(f,1:4));
            monthd(f) = str2num(time1d(f,5:6));
            dayd(f) = str2num(time1d(f,7:8));
    end
    end  
end
timecd(1:length(lond)) = nan;
DOCalld = [lond,latd,depthd,yeard',monthd',dayd',timecd',tempd,...
    saltd,oxyd,Sid,NO3d,NO2d,PO4d,CHLAd,DICd,DOCd,POCd];

% -------------------- quality check ----------------------------
% ------------------------- Location check --------------------------------
% ---------------------- Depth positive check -----------------------------
locationd_index = find(lond<=135&lond>=116&latd<=42&latd>=20);
depthd_index = find(depthd>=0);
qc1d(1:length(lond)) = 4; 
qc2d(1:length(lond)) = 4;
qc1d(locationd_index) = 3; 
qc2d(depthd_index) = 3; 

CCHDOD(1:2,:) = [qc1d',qc2d']';
CCHDOD(5,:) = 1;
CCHDOD(8,:) = 3;
CCHDOD(9:26,:) = DOCalld';
CCHDO(1:23,:) = CCHDO1;
CCHDO(1:26,48868+1:48868+268324) = CCHDOD;
CCHDO(CCHDO<=-900) = nan;
%%
save (['E:\y-cc\RODECS\CCHDO\',['CCHDO.mat']],'CCHDO');