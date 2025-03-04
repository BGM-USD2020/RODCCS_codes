clear
close
clc
filename = './叶绿素_渤海_2015年6月_表层.xlsx';
data = importdata(filename);
chladata = data.data;
year(1:size(chladata,1)) = 2015;
mon(1:size(chladata,1)) = 6;
depth(1:size(chladata,1)) = 0;
time(1:size(chladata,1)) = nan;
day(1:size(chladata,1)) = nan;

Bohai1(1,:) = chladata(:,3)';
Bohai1(2,:) = chladata(:,2)';
Bohai1(8,:) = chladata(:,4)';
Bohai1(3:7,:) = [depth;year;mon;day;time];
%%
clear
close
clc
filename = './叶绿素_渤海_2015年8月_表层.xlsx';
data = importdata(filename);
chladata = data.data;
year(1:size(chladata,1)) = 2015;
mon(1:size(chladata,1)) = 8;
depth(1:size(chladata,1)) = 0;
time(1:size(chladata,1)) = nan;
day(1:size(chladata,1)) = nan;

Bohai2(1,:) = chladata(:,3)';
Bohai2(2,:) = chladata(:,2)';
Bohai2(8,:) = chladata(:,4)';
Bohai2(3:7,:) = [depth;year;mon;day;time];
%%
clear
close
clc
filename = './叶绿素_渤海_2017年8月_表层.xlsx';
data = importdata(filename,'Sheet1');
chladata = data.data.Sheet1;
year(1:size(chladata,1)) = 2017;
mon(1:size(chladata,1)) = 8;
time(1:size(chladata,1)) = nan;
day(1:size(chladata,1)) = nan;

Bohai3(1,:) = chladata(:,2)';
Bohai3(2,:) = chladata(:,3)';
Bohai3(3,:) = chladata(:,4)';
Bohai3(8,:) = chladata(:,5)';
Bohai3(4:7,:) = [year;mon;day;time];
%%
clear
close
clc
filename = './叶绿素_渤海_2017年8月_底层.xlsx';
data = importdata(filename,'Sheet1');
chladata = data.data.Sheet1;
year(1:size(chladata,1)) = 2017;
mon(1:size(chladata,1)) = 8;
time(1:size(chladata,1)) = nan;
day(1:size(chladata,1)) = nan;

Bohai4(1,:) = chladata(:,2)';
Bohai4(2,:) = chladata(:,3)';
Bohai4(3,:) = chladata(:,4)';
Bohai4(8,:) = chladata(:,5)';
Bohai4(4:7,:) = [year;mon;day;time];
%%
clear
load Bohai1.mat;
load Bohai2.mat;
load Bohai3.mat;
load Bohai4.mat;
Bohai = [Bohai1,Bohai2,Bohai3,Bohai4];