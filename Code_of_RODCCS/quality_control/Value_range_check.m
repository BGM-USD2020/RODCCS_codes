%% ------------------------ Divided ann --------------------------
clear
close
clc

filedir = dir('E:\y-cc\RODECS\final_data_v4\qc4_*');
cd E:\y-cc\RODECS\final_data_v4\;
value_name = {'DOC','POC','NH4','Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC'};
h = [10 11 12 1 2 3 4 5 6 7 8 9];
% -------------------------- temp -----------------------------------------
    v = 4;
    filename = filedir(v).name;
    load (filename);
    

    value1 = RODECS_value1234(16,:);
    lon1 = RODECS_value1234(9,:);
    lat1 = RODECS_value1234(10,:);
    depth1 = RODECS_value1234(11,:);
    month1 = RODECS_value1234(13,:);
    qc1 = RODECS_value1234(1,:);
    qc2 = RODECS_value1234(2,:);
    qc3 = RODECS_value1234(3,:);
    qc4 = RODECS_value1234(4,:);


    qc1_index = find(qc1==3&qc3==3&qc4==3&~isnan(value1)&~isinf(value1));

    value2 = value1(qc1_index);
    lon2 = lon1(qc1_index);
    lat2 = lat1(qc1_index);
    depth2 = depth1(qc1_index);
    month2 = month1(qc1_index);
%     value2 = 1./(log10(value2));
    
    Q1 = prctile(value2,25); 
    Q2 = prctile(value2,50); 
    Q3 = prctile(value2,75); 
    IQR = Q3-Q1;
    lower_boundary = Q1-(2.*IQR);
    upper_boundary = Q3+(2.*IQR);
    boundary_q5 = quantile(value2,[0.0005,0.05,0.95,0.9995]);
    
%     normal_s_index = find(value_shallower>=value_s_m-3.*value_s_std&value_shallower<=value_s_m+3.*value_s_std);
    normal_index = find(value2>=lower_boundary&value2<=upper_boundary);
    qc_3(1:length(value2)) = 4;
    qc_3(normal_index) = 3;

%     qc_3(1:length(value2)) = nan;
%     qc_3(value_deeper_index) = qc_3_d;
%     qc_3(value_shallower_index) = qc_3_s;
qc5(1:length(value1)) = 1;
qc5(qc1_index) = qc_3;

RODECS_value12345(1:16,:) = RODECS_value1234(1:16,:);
RODECS_value12345(5,:) = qc5;

save(strcat('E:\y-cc\RODECS\final_data_v4\qc5_',string(h(v)),'RODECS12345_',string(value_name(v)),'.mat'),'RODECS_value12345');
%% -------------------------- salt -----------------------------------------
clear
close
clc

filedir = dir('E:\y-cc\RODECS\final_data_v4\qc4_*');
cd E:\y-cc\RODECS\final_data_v4\;
value_name = {'DOC','POC','NH4','Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC'};
h = [10 11 12 1 2 3 4 5 6 7 8 9];
v = 5;
filename = filedir(v).name;
load (filename);


value1 = RODECS_value1234(16,:);
lon1 = RODECS_value1234(9,:);
lat1 = RODECS_value1234(10,:);
depth1 = RODECS_value1234(11,:);
month1 = RODECS_value1234(13,:);
qc1 = RODECS_value1234(1,:);
qc2 = RODECS_value1234(2,:);
qc3 = RODECS_value1234(3,:);
qc4 = RODECS_value1234(4,:);
id = RODECS_value1234(8,:);

value1(value1<=0|value1>1e6) = nan;
qc1_index = find(qc1==3&qc3==3&qc4==3&~isnan(value1)&~isinf(value1));

    value2 = value1(qc1_index);
    lon2 = lon1(qc1_index);
    lat2 = lat1(qc1_index);
    depth2 = depth1(qc1_index);
    month2 = month1(qc1_index);


value_s_m = mean(value2,'omitnan');
value_s_std = std(value2,'omitnan');
value_s_num = length(find(~isnan(value2)));
P1_s = 1-1./(4.*value_s_num);
P2_s = 1./(4.*value_s_num);
value_s_criterion1 = norminv(P1_s,value_s_m,value_s_std);
value_s_criterion2 = norminv(P2_s,value_s_m,value_s_std);
    
    normal_s_index = find(value2>=value_s_criterion2&value2<=value_s_criterion1);
%     normal_s_index = find(value_shallower>=lower_boundary_s&value_shallower<=upper_boundary_s);
    qc_3(1:length(value2)) = 4;
    qc_3(normal_s_index) = 3;
    qc5(1:length(value1)) = 1;
    qc5(qc1_index) = qc_3;
    
    RODECS_value12345(1:16,:) = RODECS_value1234(1:16,:);
    RODECS_value12345(5,:) = qc5;

save(strcat('E:\y-cc\RODECS\final_data_v4\qc5_',string(h(v)),'RODECS12345_',string(value_name(v)),'.mat'),'RODECS_value12345');
%% -------------------------- o2 -----------------------------------------
clear
close
clc

filedir = dir('E:\y-cc\RODECS\final_data_v4\qc4_*');
cd E:\y-cc\RODECS\final_data_v4\;
value_name = {'DOC','POC','NH4','Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC'};
h = [10 11 12 1 2 3 4 5 6 7 8 9];
v = 6;
filename = filedir(v).name;
load (filename);


value1 = RODECS_value1234(16,:);
lon1 = RODECS_value1234(9,:);
lat1 = RODECS_value1234(10,:);
depth1 = RODECS_value1234(11,:);
month1 = RODECS_value1234(13,:);
qc1 = RODECS_value1234(1,:);
qc2 = RODECS_value1234(2,:);
qc3 = RODECS_value1234(3,:);
qc4 = RODECS_value1234(4,:);

value1(value1<=0|value1>1e6) = nan;
qc1_index = find(qc1==3&qc3==3&qc4==3&~isnan(value1)&~isinf(value1));
%     end
    value2 = value1(qc1_index);
    lon2 = lon1(qc1_index);
    lat2 = lat1(qc1_index);
    depth2 = depth1(qc1_index);
    month2 = month1(qc1_index);
 
value_s_m = mean(value2,'omitnan');
value_s_std = std(value2,'omitnan');
value_s_num = length(find(~isnan(value2)));
P1_s = 1-1./(4.*value_s_num);
P2_s = 1./(4.*value_s_num);
value_s_criterion1 = norminv(P1_s,value_s_m,value_s_std);
value_s_criterion2 = norminv(P2_s,value_s_m,value_s_std);
    
    Q1_s = prctile(value2,25); 
    Q2_s = prctile(value2,50); 
    Q3_s = prctile(value2,75); 
    IQR_s = Q3_s-Q1_s;
    lower_boundary_s = Q1_s-(2.*IQR_s);
    upper_boundary_s = Q3_s+(2.*IQR_s);
    boundary_q5 = quantile(value2,[0.005,0.05,0.95,0.995]);
    
%     normal_s_index = find(value2>=value_s_m-3.*value_s_std&value2<=value_s_m+3.*value_s_std);
    normal_s_index = find(value2>=lower_boundary_s&value2<=upper_boundary_s);
    qc_3(1:length(value2)) = 4;
    qc_3(normal_s_index) = 3;

    qc5(1:length(value1)) = 1;
    qc5(qc1_index) = qc_3;
    
    RODECS_value12345(1:16,:) = RODECS_value1234(1:16,:);
    RODECS_value12345(5,:) = qc5;
    
save(strcat('E:\y-cc\RODECS\final_data_v4\qc5_',string(h(v)),'RODECS12345_',string(value_name(v)),'.mat'),'RODECS_value12345');
%% -------------------------- Si -----------------------------------------
clear
close
clc

filedir = dir('E:\y-cc\RODECS\final_data_v4\qc4_*');
cd E:\y-cc\RODECS\final_data_v4\;
value_name = {'DOC','POC','NH4','Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC'};
h = [10 11 12 1 2 3 4 5 6 7 8 9];
v = 7;
filename = filedir(v).name;
load (filename);


value1 = RODECS_value1234(16,:);
lon1 = RODECS_value1234(9,:);
lat1 = RODECS_value1234(10,:);
depth1 = RODECS_value1234(11,:);
month1 = RODECS_value1234(13,:);
qc1 = RODECS_value1234(1,:);
qc2 = RODECS_value1234(2,:);
qc3 = RODECS_value1234(3,:);
qc4 = RODECS_value1234(4,:);

value1(value1<=0|value1>1e6) = nan;
qc1_index = find(qc1==3&qc3==3&qc4==3&~isnan(value1)&~isinf(value1));

    value2 = value1(qc1_index);
    lon2 = lon1(qc1_index);
    lat2 = lat1(qc1_index);
    depth2 = depth1(qc1_index);
    month2 = month1(qc1_index);
    
    Q1_s = prctile(value2,25); 
    Q2_s = prctile(value2,50); 
    Q3_s = prctile(value2,75); 
    IQR_s = Q3_s-Q1_s;
    lower_boundary_s = Q1_s-(2.*IQR_s);
    upper_boundary_s = Q3_s+(2.*IQR_s);
    boundary_q5 = quantile(value2,[0.005,0.05,0.95,0.995]);
    
    
    normal_s_index = find(value2>=lower_boundary_s&value2<=upper_boundary_s);
    qc_3(1:length(value2)) = 4;
    qc_3(normal_s_index) = 3;

    qc5(1:length(value1)) = 1;
    qc5(qc1_index) = qc_3;
    
    RODECS_value12345(1:16,:) = RODECS_value1234(1:16,:);
    RODECS_value12345(5,:) = qc5;
    
save(strcat('E:\y-cc\RODECS\final_data_v4\qc5_',string(h(v)),'RODECS12345_',string(value_name(v)),'.mat'),'RODECS_value12345');    
%% -------------------------- no3 -----------------------------------------
clear
close
clc

filedir = dir('E:\y-cc\RODECS\final_data_v4\qc4_*');
cd E:\y-cc\RODECS\final_data_v4\;
value_name = {'DOC','POC','NH4','Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC'};
h = [10 11 12 1 2 3 4 5 6 7 8 9];
v = 8;
filename = filedir(v).name;
load (filename);


value1 = RODECS_value1234(16,:);
lon1 = RODECS_value1234(9,:);
lat1 = RODECS_value1234(10,:);
depth1 = RODECS_value1234(11,:);
month1 = RODECS_value1234(13,:);
qc1 = RODECS_value1234(1,:);
qc2 = RODECS_value1234(2,:);
qc3 = RODECS_value1234(3,:);
qc4 = RODECS_value1234(4,:);

value1(value1<=0|value1>1e6) = nan;
qc1_index = find(qc1==3&qc3==3&qc4==3&~isnan(value1)&~isinf(value1));

    value3 = value1(qc1_index);
    lon2 = lon1(qc1_index);
    lat2 = lat1(qc1_index);
    depth2 = depth1(qc1_index);
    month2 = month1(qc1_index);
    value2 = ((value3));
    value21 = value2(~isnan(value2)&~isinf(value2));
    value31 = value3(~isnan(value2)&~isinf(value2));
    
    Q1_s = prctile(value2,25); 
    Q2_s = prctile(value2,50); 
    Q3_s = prctile(value2,75); 
    IQR_s = Q3_s-Q1_s;
    lower_boundary = Q1_s-(2.*IQR_s);
    upper_boundary = Q3_s+(2.*IQR_s);
    boundary_q5 = quantile(value2,[0.025,0.05,0.95,0.975]);

    normal_s_index = find(value2>=lower_boundary&value2<=upper_boundary);
    qc_31(1:length(value21)) = 4;
    qc_31(normal_s_index) = 3;
    qc_3(~isnan(value2)&~isinf(value2)) = qc_31;
    
    qc5(1:length(value1)) = 1;
    qc5(qc1_index) = qc_3;
    
    RODECS_value12345(1:16,:) = RODECS_value1234(1:16,:);
    RODECS_value12345(5,:) = qc5;

save(strcat('E:\y-cc\RODECS\final_data_v4\qc5_',string(h(v)),'RODECS12345_',string(value_name(v)),'.mat'),'RODECS_value12345');
%% -------------------------- no2 -----------------------------------------
clear
close
clc

filedir = dir('E:\y-cc\RODECS\final_data_v4\qc4_*');
cd E:\y-cc\RODECS\final_data_v4\;
value_name = {'DOC','POC','NH4','Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC'};
h = [10 11 12 1 2 3 4 5 6 7 8 9];
v = 9;
filename = filedir(v).name;
load (filename);


value1 = RODECS_value1234(16,:);
lon1 = RODECS_value1234(9,:);
lat1 = RODECS_value1234(10,:);
depth1 = RODECS_value1234(11,:);
month1 = RODECS_value1234(13,:);
qc1 = RODECS_value1234(1,:);
qc2 = RODECS_value1234(2,:);
qc3 = RODECS_value1234(3,:);
qc4 = RODECS_value1234(4,:);

value1(value1<=0|value1>1e6) = nan;
qc1_index = find(qc1==3&qc3==3&qc4==3&~isnan(value1)&~isinf(value1));

    value3 = value1(qc1_index);
    lon2 = lon1(qc1_index);
    lat2 = lat1(qc1_index);
    depth2 = depth1(qc1_index);
    month2 = month1(qc1_index);
    value2 = (log10(value3));
%     value2 = value3;
    
    Q1 = prctile(value2,25); 
    Q2 = prctile(value2,50); 
    Q3 = prctile(value2,75); 
    IQR = Q3-Q1;
    lower_boundary = Q1-(2.*IQR);
    upper_boundary = Q3+(2.*IQR);
    boundary_q5 = quantile(value2,[0.005,0.05,0.95,0.995]);
    
    
    normal_index = find(value2>=lower_boundary&value2<=upper_boundary);
%     normal_index = find(value2>=boundary_q5(1)&value2<=boundary_q5(4));
    qc_3(1:length(value2)) = 4;
    qc_3(normal_index) = 3;
    
    qc5(1:length(value1)) = 1;
    qc5(qc1_index) = qc_3;
    
    RODECS_value12345(1:16,:) = RODECS_value1234(1:16,:);
    RODECS_value12345(5,:) = qc5;

save(strcat('E:\y-cc\RODECS\final_data_v4\qc5_',string(h(v)),'RODECS12345_',string(value_name(v)),'.mat'),'RODECS_value12345');
%% -------------------------- po4 -----------------------------------------
clear
close
clc

filedir = dir('E:\y-cc\RODECS\final_data_v4\qc4_*');
cd E:\y-cc\RODECS\final_data_v4\;
value_name = {'DOC','POC','NH4','Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC'};
h = [10 11 12 1 2 3 4 5 6 7 8 9];
v = 10;
filename = filedir(v).name;
load (filename);


value1 = RODECS_value1234(16,:);
lon1 = RODECS_value1234(9,:);
lat1 = RODECS_value1234(10,:);
depth1 = RODECS_value1234(11,:);
month1 = RODECS_value1234(13,:);
qc1 = RODECS_value1234(1,:);
qc2 = RODECS_value1234(2,:);
qc3 = RODECS_value1234(3,:);
qc4 = RODECS_value1234(4,:);

value1(value1<=0|value1>1e6) = nan;
qc1_index = find(qc1==3&qc3==3&qc4==3&~isnan(value1)&~isinf(value1));

    value2 = value1(qc1_index);
    lon2 = lon1(qc1_index);
    lat2 = lat1(qc1_index);
    depth2 = depth1(qc1_index);
    month2 = month1(qc1_index);
%     value2 = 1./((value3));
    value21 = value2(~isnan(value2)&~isinf(value2));
    value_s_m = mean(value2,'omitnan');
    value_s_std = std(value2,'omitnan');
    value_d_m = mean(value2,'omitnan');
    value_d_std = std(value2,'omitnan');
    
    Q1_s = prctile(value2,25); 
    Q2_s = prctile(value2,50); 
    Q3_s = prctile(value2,75); 
    IQR_s = Q3_s-Q1_s;
    lower_boundary_s = Q1_s-(2.*IQR_s);
    upper_boundary_s = Q3_s+(2.*IQR_s);
%     

    normal_index = find(value2>=lower_boundary_s&value2<=upper_boundary_s);
    qc_3(1:length(value2)) = 4;
    qc_3(normal_index) = 3;

    qc5(1:length(value1)) = 1;
    qc5(qc1_index) = qc_3;
    
    RODECS_value12345(1:16,:) = RODECS_value1234(1:16,:);
    RODECS_value12345(5,:) = qc5;

save(strcat('E:\y-cc\RODECS\final_data_v4\qc5_',string(h(v)),'RODECS12345_',string(value_name(v)),'.mat'),'RODECS_value12345');
%% -------------------------- chla -----------------------------------------
clear
close
clc

filedir = dir('E:\y-cc\RODECS\final_data_v4\qc4_*');
cd E:\y-cc\RODECS\final_data_v4\;
value_name = {'DOC','POC','NH4','Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC'};
h = [10 11 12 1 2 3 4 5 6 7 8 9];
v = 11;
filename = filedir(v).name;
load (filename);


value1 = RODECS_value1234(16,:);
lon1 = RODECS_value1234(9,:);
lat1 = RODECS_value1234(10,:);
depth1 = RODECS_value1234(11,:);
month1 = RODECS_value1234(13,:);
qc1 = RODECS_value1234(1,:);
qc2 = RODECS_value1234(2,:);
qc3 = RODECS_value1234(3,:);
qc4 = RODECS_value1234(4,:);

value1(value1<=0|value1>1e6) = nan;
qc1_index = find(qc1==3&qc3==3&qc4==3&~isnan(value1)&~isinf(value1));

    value3 = value1(qc1_index);
    lon2 = lon1(qc1_index);
    lat2 = lat1(qc1_index);
    depth2 = depth1(qc1_index);
    month2 = month1(qc1_index);
    value2 = (log10(value3));

    value_s_m = mean(value2,'omitnan');
    value_s_std = std(value2,'omitnan');
value_s_num = length(find(~isnan(value2)));
P1_s = 1-1./(4.*value_s_num);
P2_s = 1./(4.*value_s_num);
value_s_criterion1 = norminv(P1_s,value_s_m,value_s_std);
value_s_criterion2 = norminv(P2_s,value_s_m,value_s_std);
    qc_3(1:length(value2)) = 4;
    qc_3(normal_s_index) = 3;
    
    qc5(1:length(value1)) = 1;
    qc5(qc1_index) = qc_3;
    
    RODECS_value12345(1:16,:) = RODECS_value1234(1:16,:);
    RODECS_value12345(5,:) = qc5;

save(strcat('E:\y-cc\RODECS\final_data_v4\qc5_',string(h(v)),'RODECS12345_',string(value_name(v)),'.mat'),'RODECS_value12345');
%% -------------------------- dic -----------------------------------------
clear
close
clc

filedir = dir('E:\y-cc\RODECS\final_data_v4\qc4_*');
cd E:\y-cc\RODECS\final_data_v4\;
value_name = {'DOC','POC','NH4','Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC'};
h = [10 11 12 1 2 3 4 5 6 7 8 9];
v = 12;
filename = filedir(v).name;
load (filename);


value1 = RODECS_value1234(16,:);
lon1 = RODECS_value1234(9,:);
lat1 = RODECS_value1234(10,:);
depth1 = RODECS_value1234(11,:);
month1 = RODECS_value1234(13,:);
qc1 = RODECS_value1234(1,:);
qc2 = RODECS_value1234(2,:);
qc3 = RODECS_value1234(3,:);
qc4 = RODECS_value1234(4,:);

value1(value1<=0|value1>1e6) = nan;
qc1_index = find(qc1==3&qc3==3&qc4==3&~isnan(value1)&~isinf(value1));

    value2 = value1(qc1_index);
    lon2 = lon1(qc1_index);
    lat2 = lat1(qc1_index);
    depth2 = depth1(qc1_index);
    month2 = month1(qc1_index);

    
    Q1_s = prctile(value2,25); 
    Q2_s = prctile(value2,50); 
    Q3_s = prctile(value2,75); 
    IQR_s = Q3_s-Q1_s;
    lower_boundary_s = Q1_s-(2.*IQR_s);
    upper_boundary_s = Q3_s+(2.*IQR_s);
    boundary_q5 = quantile(value2,[0.025,0.05,0.95,0.975]);
    
%     
%     normal_s_index = find(value_shallower>=value_s_m-3.*value_s_std&value_shallower<=value_s_m+3.*value_s_std);
    normal_s_index = find(value2>=lower_boundary_s&value2<=upper_boundary_s);
    qc_3(1:length(value2)) = 4;
    qc_3(normal_s_index) = 3;

    qc5(1:length(value1)) = 1;
    qc5(qc1_index) = qc_3;
    
    RODECS_value12345(1:16,:) = RODECS_value1234(1:16,:);
    RODECS_value12345(5,:) = qc5;

%     RODECS_value1234_value1 = RODECS_value12345(:,find(value1>0&~isnan(value1)));
save(strcat('E:\y-cc\RODECS\final_data_v4\qc5_',string(h(v)),'RODECS12345_',string(value_name(v)),'.mat'),'RODECS_value12345');
%% -------------------------- doc -----------------------------------------
clear
close
clc

filedir = dir('E:\y-cc\RODECS\final_data_v4\qc4_*');
cd E:\y-cc\RODECS\final_data_v4\;
value_name = {'DOC','POC','NH4','Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC'};
h = [10 11 12 1 2 3 4 5 6 7 8 9];
v = 1;
filename = filedir(v).name;
load (filename);


value1 = RODECS_value1234(16,:);
lon1 = RODECS_value1234(9,:);
lat1 = RODECS_value1234(10,:);
depth1 = RODECS_value1234(11,:);
month1 = RODECS_value1234(13,:);
qc1 = RODECS_value1234(1,:);
qc2 = RODECS_value1234(2,:);
qc3 = RODECS_value1234(3,:);
qc4 = RODECS_value1234(4,:);

value1(value1<=0|value1>1e6) = nan;
qc1_index = find(qc1==3&qc3==3&qc4==3&~isnan(value1)&~isinf(value1));
%     end
    value3 = value1(qc1_index);
    lon2 = lon1(qc1_index);
    lat2 = lat1(qc1_index);
    depth2 = depth1(qc1_index);
    month2 = month1(qc1_index);
    value2 = (log10(value3));

    value_s_m = mean(value2,'omitnan');
value_s_std = std(value2,'omitnan');
value_s_num = length(find(~isnan(value2)));
P1_s = 1-1./(4.*value_s_num);
P2_s = 1./(4.*value_s_num);
value_s_criterion1 = norminv(P1_s,value_s_m,value_s_std);
value_s_criterion2 = norminv(P2_s,value_s_m,value_s_std);
    
%     
normal_s_index = find(value2<=value_s_criterion1);
    qc_3(1:length(value2)) = 4;
    qc_3(normal_s_index) = 3;

    qc5(1:length(value1)) = 1;
    qc5(qc1_index) = qc_3;
    
    RODECS_value12345(1:16,:) = RODECS_value1234(1:16,:);
    RODECS_value12345(5,:) = qc5;

save(strcat('E:\y-cc\RODECS\final_data_v4\qc5_',string(h(v)),'RODECS12345_',string(value_name(v)),'.mat'),'RODECS_value12345');
%% -------------------------- poc -----------------------------------------
clear
close
clc

filedir = dir('E:\y-cc\RODECS\final_data_v4\qc4_*');
cd E:\y-cc\RODECS\final_data_v4\;
value_name = {'DOC','POC','NH4','Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC'};
h = [10 11 12 1 2 3 4 5 6 7 8 9];
v = 2;
filename = filedir(v).name;
load (filename);


value1 = RODECS_value1234(16,:);
lon1 = RODECS_value1234(9,:);
lat1 = RODECS_value1234(10,:);
depth1 = RODECS_value1234(11,:);
month1 = RODECS_value1234(13,:);
qc1 = RODECS_value1234(1,:);
qc2 = RODECS_value1234(2,:);
qc3 = RODECS_value1234(3,:);
qc4 = RODECS_value1234(4,:);

value1(value1<=0|value1>1e6) = nan;
qc1_index = find(qc1==3&qc3==3&qc4==3&~isnan(value1)&~isinf(value1));
%     end
    value2 = value1(qc1_index);
    lon2 = lon1(qc1_index);
    lat2 = lat1(qc1_index);
    depth2 = depth1(qc1_index);
    month2 = month1(qc1_index);
%     value2 = (log10(value3));

%     
    Q1_s = prctile(value2,25); 
    Q2_s = prctile(value2,50); 
    Q3_s = prctile(value2,75); 
    IQR_s = Q3_s-Q1_s;
    lower_boundary_s = Q1_s-(2.*IQR_s);
    upper_boundary_s = Q3_s+(2.*IQR_s);
    boundary_q5 = quantile(value2,[0.025,0.05,0.95,0.975]);
    
    
%     normal_s_index = find(value2>=value_s_m-3.*value_s_std&value2<=value_s_m+3.*value_s_std);
    normal_s_index = find(value2>=lower_boundary_s&value2<=upper_boundary_s);
    qc_3(1:length(value2)) = 4;
    qc_3(normal_s_index) = 3;

    qc5(1:length(value1)) = 1;
    qc5(qc1_index) = qc_3;
    
    RODECS_value12345(1:16,:) = RODECS_value1234(1:16,:);
    RODECS_value12345(5,:) = qc5;

%     RODECS_value1234_value1 = RODECS_value12345(:,find(value1>0&~isnan(value1)));
save(strcat('E:\y-cc\RODECS\final_data_v4\qc5_',string(h(v)),'RODECS12345_',string(value_name(v)),'.mat'),'RODECS_value12345');
%% -------------------------- nh4 -----------------------------------------
clear
close
clc

filedir = dir('E:\y-cc\RODECS\final_data_v4\qc4_*');
cd E:\y-cc\RODECS\final_data_v4\;
value_name = {'DOC','POC','NH4','Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC'};
h = [10 11 12 1 2 3 4 5 6 7 8 9];
v = 3;
filename = filedir(v).name;
load (filename);


value1 = RODECS_value1234(16,:);
lon1 = RODECS_value1234(9,:);
lat1 = RODECS_value1234(10,:);
depth1 = RODECS_value1234(11,:);
month1 = RODECS_value1234(13,:);
qc1 = RODECS_value1234(1,:);
qc2 = RODECS_value1234(2,:);
qc3 = RODECS_value1234(3,:);
qc4 = RODECS_value1234(4,:);

value1(value1<=0|value1>1e6) = nan;
qc1_index = find(qc1==3&qc3==3&qc4==3&~isnan(value1)&~isinf(value1));
%     end
    value3 = value1(qc1_index);
    lon2 = lon1(qc1_index);
    lat2 = lat1(qc1_index);
    depth2 = depth1(qc1_index);
    month2 = month1(qc1_index);
    value2 = (log10(value3));
% 

    value_s_m = mean(value2,'omitnan');
    value_s_std = std(value2,'omitnan');
    value_s_num = length(find(~isnan(value2)));
P1_s = 1-1./(4.*value_s_num);
P2_s = 1./(4.*value_s_num);
value_s_criterion1 = norminv(P1_s,value_s_m,value_s_std);
value_s_criterion2 = norminv(P2_s,value_s_m,value_s_std);

normal_s_index = find(value2<=value_s_criterion1);
%     normal_s_index = find(value_shallower>=lower_boundary_s&value_shallower<=upper_boundary_s);
    qc_3(1:length(value2)) = 4;
    qc_3(normal_s_index) = 3;


    qc5(1:length(value1)) = 1;
    qc5(qc1_index) = qc_3;
    
    RODECS_value12345(1:16,:) = RODECS_value1234(1:16,:);
    RODECS_value12345(5,:) = qc5;

save(strcat('E:\y-cc\RODECS\final_data_v4\qc5_',string(h(v)),'RODECS12345_',string(value_name(v)),'.mat'),'RODECS_value12345');    