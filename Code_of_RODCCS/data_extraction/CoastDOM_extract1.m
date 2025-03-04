%%-------------------------------------------------------------------------
%  Written in 2024.5.10 CeceWang at IMST, SDU, in QD
%  The purpose is to read table data(CoastDOM)
%%-------------------------------------------------------------------------
clear all
close all
% path1 = 'E:\y-cc\COMD\CoastDOM\';
% filename = [path1,'New_CoastDOM_Version1-Lonberg_etal-2023.xlsx'];
load CoastDOM_ori.mat;
% --------- date ----------------
date = readmatrix('AAA.xls');
date = [date(:,1);date(2:5288,2)];
date1 = datetime(date*3600*24,'ConvertFrom','epochtime','Epoch','1899-12-30');
date2 = datestr(date1,'yyyy-mm-dd');
year1 = date2(:,1:4);
year1(year1 == 'NaN-') = '9';
year = str2num(year1);
mon1 = date2(:,6:7);
mon1(mon1 == 'aN') = '9';
mon = str2num(mon1);
day1 = date2(:,9:10);
day1(day1 == 'Na') = '9';
day = str2num(day1(1:70823,:));

% year_error1 = year(year>2500);
% year_error2 = year(year<1900);
% mon_error1 = mon(mon>12);
% mon_error2 = mon(mon<1);
%
% CoastDOM(:,26) = year;
% CoastDOM(:,27) = mon;
% CoastDOM(CoastDOM==0) = nan;
lon = CoastDOM(:,2);
lat = CoastDOM(:,1);
depth = CoastDOM(:,4);
temp = CoastDOM(:,5);
salt = CoastDOM(:,6);
chla = CoastDOM(:,8);
no3 = CoastDOM(:,10);
nh4 = CoastDOM(:,12);
doc = CoastDOM(:,16);
don = CoastDOM(:,17);
dop = CoastDOM(:,19);
poc = CoastDOM(:,21);
pn = CoastDOM(:,22);
pp = CoastDOM(:,23);
dic = CoastDOM(:,24);
% year = CoastDOM(:,26);
% mon = CoastDOM(:,27);
o2(1:70823) = nan;
Si(1:70823) = nan;
no2(1:70823) = nan;
po4(1:70823) = nan;
year(year>3000) = nan;
mon(mon==99) = nan;
day(day==99) = nan;
time(1:70823) = nan;
CoastDOM_data = [lon,lat,depth,year,mon,day,time',temp,salt,o2',Si',no3,no2',po4',chla,dic,doc,poc,nh4];
%%
temp1(:,1) = lon(temp~=0); 
temp1(:,2) = lat(temp~=0); 
temp1(:,3) = depth(temp~=0); 
temp1(:,4) = temp(temp~=0); 
temp1(:,5) = year(temp~=0);
temp1(:,6) = mon(temp~=0);
%
salt1(:,1) = lon(salt~=0); 
salt1(:,2) = lat(salt~=0); 
salt1(:,3) = depth(salt~=0); 
salt1(:,4) = salt(salt~=0); 
salt1(:,5) = year(salt~=0);
salt1(:,6) = mon(salt~=0);
%
chla1(:,1) = lon(chla~=0); 
chla1(:,2) = lat(chla~=0); 
chla1(:,3) = depth(chla~=0); 
chla1(:,4) = chla(chla~=0); 
chla1(:,5) = year(chla~=0);
chla1(:,6) = mon(chla~=0);
%
no31(:,1) = lon(no3~=0); 
no31(:,2) = lat(no3~=0); 
no31(:,3) = depth(no3~=0); 
no31(:,4) = no3(no3~=0); 
no31(:,5) = year(no3~=0);
no31(:,6) = mon(no3~=0);
%
nh41(:,1) = lon(nh4~=0); 
nh41(:,2) = lat(nh4~=0); 
nh41(:,3) = depth(nh4~=0); 
nh41(:,4) = nh4(nh4~=0); 
nh41(:,5) = year(nh4~=0);
nh41(:,6) = mon(nh4~=0);
%
doc1(:,1) = lon(doc~=0); 
doc1(:,2) = lat(doc~=0); 
doc1(:,3) = depth(doc~=0); 
doc1(:,4) = doc(doc~=0); 
doc1(:,5) = year(doc~=0);
doc1(:,6) = mon(doc~=0);
%
poc1(:,1) = lon(poc~=0); 
poc1(:,2) = lat(poc~=0); 
poc1(:,3) = depth(poc~=0); 
poc1(:,4) = poc(poc~=0); 
poc1(:,5) = year(poc~=0);
poc1(:,6) = mon(poc~=0);

%
dic1(:,1) = lon(dic~=0); 
dic1(:,2) = lat(dic~=0); 
dic1(:,3) = depth(dic~=0); 
dic1(:,4) = dic(dic~=0); 
dic1(:,5) = year(dic~=0);
dic1(:,6) = mon(dic~=0);
%

