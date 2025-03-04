clear
close
clc
filename = './CHOICE-C 2009年 冬季航次CTD叶绿素.xls';
data = importdata(filename,'chla data');
chladata = data.data.chlaData;
time1 = data.textdata.chlaData(2:end,4);
time = string(time1);

for f=1:length(time)
    if time(f) == "";
        year(f) = nan;
        month(f) = nan;
        day(f) = nan;
        hour(f) = nan;
        minute(f) = nan;
    else
    % Use spaces to split date time and time parts
    datePart = strsplit(time(f), ' ');
    % Use slashes to split the date section
    datePart1 = strsplit(datePart(1), '/');
    % Use colons to split time parts
    if length(datePart)>1
       timePart1 = strsplit(datePart(2), ':');
       hour(f) = str2num(timePart1(1));
       minute(f) = str2num(timePart1(2));
    else
       hour(f) = nan;
       minute(f) = nan;
    end
    if str2num(datePart1(1))>20
        year(f) = str2num(datePart1(1));
        month(f) = str2num(datePart1(2));
        day(f) = str2num(datePart1(3));
    else
        year(f) = str2num(datePart1(3));
        month(f) = str2num(datePart1(1));
        day(f) = str2num(datePart1(2));
    end
    end
end
CHOICE1(1:2,:) = chladata(:,1:2)';
CHOICE1(3,:) = chladata(:,5)';
CHOICE1(4:8,:) = [year;month;day;100.*hour+minute;chladata(:,end)'];
%%
clear
close
clc
filename = './CHOICE-C 2009年 夏季航次CTD叶绿素.xls';
data = importdata(filename,'Chla data');
chladata = data.data.ChlaData;
time1 = data.textdata.ChlaData(2:end,4);
time = string(time1);

for f=1:length(time)
    if time(f) == "";
        year(f) = nan;
        month(f) = nan;
        day(f) = nan;
        hour(f) = nan;
        minute(f) = nan;
    else
    % Use spaces to split date time and time parts
    datePart = strsplit(time(f), ' ');
    % Use slashes to split the date section
    datePart1 = strsplit(datePart(1), '/');
    % Use colons to split time parts
    if length(datePart)>1
       timePart1 = strsplit(datePart(2), ':');
       hour(f) = str2num(timePart1(1));
       minute(f) = str2num(timePart1(2));
    else
       hour(f) = nan;
       minute(f) = nan;
    end
    if str2num(datePart1(1))>20
        year(f) = str2num(datePart1(1));
        month(f) = str2num(datePart1(2));
        day(f) = str2num(datePart1(3));
    else
        year(f) = str2num(datePart1(3));
        month(f) = str2num(datePart1(1));
        day(f) = str2num(datePart1(2));
    end
    end
end
CHOICE2(1:2,:) = chladata(:,1:2)';
CHOICE2(3,:) = chladata(:,5)';
CHOICE2(4:8,:) = [year;month;day;100.*hour+minute;chladata(:,end)'];
%%
clear
close
clc
filename = './CHOICE-C 2010年 秋季航次CTD叶绿素.xlsx';
data = importdata(filename,'data');
chladata = data.data.data;
time1 = data.textdata.data(2:end,4);
time = string(time1);

for f=1:length(time)
    if time(f) == "";
        year(f) = nan;
        month(f) = nan;
        day(f) = nan;
        hour(f) = nan;
        minute(f) = nan;
    else
    % Use spaces to split date time and time parts
    datePart = strsplit(time(f), ' ');
    % Use slashes to split the date section
    datePart1 = strsplit(datePart(1), '/');
    if length(datePart1)==1
       datePart1 = strsplit(datePart(1), '-');
    end
    % Use colons to split time parts
    if length(datePart)>1
       timePart1 = strsplit(datePart(2), ':');
       hour(f) = str2num(timePart1(1));
       minute(f) = str2num(timePart1(2));
    else
       hour(f) = nan;
       minute(f) = nan;
    end
    if str2num(datePart1(1))>20
        year(f) = str2num(datePart1(1));
        month(f) = str2num(datePart1(2));
        day(f) = str2num(datePart1(3));
    else
        year(f) = str2num(datePart1(3));
        month(f) = str2num(datePart1(1));
        day(f) = str2num(datePart1(2));
    end
    end
end
CHOICE3(1:2,:) = chladata(:,1:2)';
CHOICE3(3,:) = chladata(:,5)';
CHOICE3(4:8,:) = [year;month;day;100.*hour+minute;chladata(:,end)'];
%%
clear
close
clc
filename = './CHOICE-C 2011年 春季航次CTD叶绿素.xlsx';
data = importdata(filename,'data');
chladata = data.data.data;
time1 = data.textdata.data(2:end,4);
time = string(time1);

for f=1:length(time)
    if time(f) == "";
        year(f) = nan;
        month(f) = nan;
        day(f) = nan;
        hour(f) = nan;
        minute(f) = nan;
    else
    % Use spaces to split date time and time parts
    datePart = strsplit(time(f), ' ');      
    % Use slashes to split the date section
    datePart1 = strsplit(datePart(1), '/');
    if length(datePart1)==1
       datePart1 = strsplit(datePart(1), '-');
    end
    % Use colons to split time parts
    if length(datePart)==2
       timePart1 = strsplit(datePart(2), ':');
       hour(f) = str2num(timePart1(1));
       minute(f) = str2num(timePart1(2));
    else if length(datePart)==3
       timePart1 = strsplit(datePart(3), ':');
       hour(f) = str2num(timePart1(1));
       minute(f) = str2num(timePart1(2));
    else
       hour(f) = nan;
       minute(f) = nan;
        end
    end
    if str2num(datePart1(1))>20
        year(f) = str2num(datePart1(1));
        month(f) = str2num(datePart1(2));
        day(f) = str2num(datePart1(3));
    else
        year(f) = str2num(datePart1(3));
        month(f) = str2num(datePart1(1));
        day(f) = str2num(datePart1(2));
    end
    end
end
CHOICE4(1:2,:) = chladata(:,1:2)';
CHOICE4(3,:) = chladata(:,5)';
day(day==58) = 28;
CHOICE4(4:8,:) = [year;month;day;100.*hour+minute;chladata(:,end)'];
%%
clear
load CHOICE1.mat;
load CHOICE2.mat;
load CHOICE3.mat;
load CHOICE4.mat;
CHOICE = [CHOICE1,CHOICE2,CHOICE3,CHOICE4];