clear all
close all
clc

rootDir = 'D:\y-cc\y-cc\R2R_2022..4.9\R2R_useful\'; 
cnvFiles = dir(fullfile(rootDir, '**', '*.cnv'));
cnvFilePaths = {cnvFiles.name}; 
for k = 1:length(cnvFiles)
    cnvFilePaths{k} = fullfile(cnvFiles(k).folder, cnvFiles(k).name);
end
%% notes for location in source-data file 
%%%%%%%%% end of user modification %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = 0;
for f=1:986
    f
    
fid = fopen(string(cnvFilePaths(f))); 
fseek(fid,0,-1); 
while strcmp(fgetl(fid),'*END*') == 0 end 
nextLine = fgetl(fid);
if isempty(nextLine) || all(isspace(nextLine)) 
   
    nextLine = fgetl(fid); 
end

n = 1;

while ischar(nextLine)  
%     data = [data; sscanf(nextLine,'%f')]; 
    data(:,n) = sscanf(nextLine,'%f'); 
    if f==951
        n = n+1
    else
        n = n + 1;
    end
    nextLine = fgetl(fid); 
end
fclose(fid); 

fid = fopen(string(cnvFilePaths(f))); 
while ~feof(fid)
    line = fgetl(fid);
    
    if contains(line, '* NMEA UTC (Time) =')
        
        timeStr1 = line(strfind(line, '=') + 1:end);
        
        month = timeStr1(2:4);
        mon = monthAbbrevToNum(month);
        day = timeStr1(6:7);
        year = timeStr1(9:12);
        hour = timeStr1(14:15);
        minute = timeStr1(17:18);
        break; 
    end   
end
fclose(fid);

fid = fopen(string(cnvFilePaths(f))); 
while ~feof(fid)
    line = fgetl(fid);
   
    if contains(line, 'latitude: Latitude')
        
        latStr1 = line(strfind(line, '=') + 1:end);
        latid = str2num(line(8:9))+1;
        
        break; 
    end   
end
fclose(fid); 

fid = fopen(string(cnvFilePaths(f))); 
while ~feof(fid)
    line = fgetl(fid);
    
    if contains(line, 'longitude: Longitude')
      
        lonStr1 = line(strfind(line, '=') + 1:end);
        lonid = str2num(line(8:9))+1;
        break; 
    end   
end
fclose(fid); 

fid = fopen(string(cnvFilePaths(f)));
while ~feof(fid)
    line = fgetl(fid);
    if contains(line, 't090C: Temperature')
        tempStr1 = line(strfind(line, '=') + 1:end);
        tempid = str2num(line(8:9))+1;
        break; 
    end   
end
fclose(fid); 

fid = fopen(string(cnvFilePaths(f))); 
while ~feof(fid)
    line = fgetl(fid);
    if contains(line, 'sal00: Salinity')
        saltStr1 = line(strfind(line, '=') + 1:end);
        saltid = str2num(line(8:9))+1;
        break; 
    end   
end
fclose(fid);

fid = fopen(string(cnvFilePaths(f))); 
while ~feof(fid)
    line = fgetl(fid);
    if contains(line, 'depSM: Depth')
        depthStr1 = line(strfind(line, '=') + 1:end);
        depthid = str2num(line(8:9))+1;
        break; 
    end   
end
fclose(fid); 

if f>=952&f<=977
    fid = fopen(string(cnvFilePaths(f))); 
    while ~feof(fid)
        line = fgetl(fid);
            if contains(line, 'Oxygen, SBE 43 [umol/kg]')
            o2Str1 = line(strfind(line, '=') + 1:end);
            o2id = str2num(line(8:9))+1;
            break; 
        end   
    end
    fclose(fid); 
else
    fid = fopen(string(cnvFilePaths(f))); 
    while ~feof(fid)
        line = fgetl(fid);
            if contains(line, 'Oxygen, SBE 43 [umol/kg]')
            o2Str1 = line(strfind(line, '=') + 1:end);
            o2id = str2num(line(8:9))+1;
            break; 
        end   
    end
    fclose(fid); 
end

% scatter3(data(lonid,:),data(latid,:),-data(depthid,:),10,data(o2id,:),'filled');
% caxis([100 250]);
% colormap(jet);
% colorbar;
% scatter(R2R_ori(:,10),-R2R_ori(:,3),'filled');
scatter(data(saltid,:),-data(depthid,:),'filled');
xlim([0 50]);
ylim([-7000 0]);
title(strcat(cnvFiles(f).name));
print(['R2RDO',num2str(f),'.tif'],'-dtiff');
close;


year1(1:size(data,2)) = str2num(year);
mon1(1:size(data,2)) = mon;
day1(1:size(data,2)) = str2num(day);
time(1:size(data,2)) = mon.*100+str2num(day);
R2R_ori(k+1:k+size(data,2),:) = [data(lonid,:)',data(latid,:)',...
    data(depthid,:)',year1',mon1',day1',time',data(tempid,:)',data(saltid,:)',data(o2id,:)'];
clear data
clear mon1
clear day1
clear year1
clear time
clear o2id
clear lonid
clear latid
clear depthid
clear tempid
clear saltid
k = size(R2R_ori,1);
end