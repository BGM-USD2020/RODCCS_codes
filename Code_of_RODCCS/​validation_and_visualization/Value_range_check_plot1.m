%%                    ann 
%    work with mld_data_plot.m
%%  ------------------------------ temp -------------------------------------
clear
close
clc

filedir = dir('E:\y-cc\RODECS\final_data_v4\qc4_*');
cd E:\y-cc\RODECS\final_data_v4\;
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

value_name = {'Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC','DOC','POC','PP','NH4'};

value_sn = value2(qc_3==3);
value_so = value2(qc_3==4);
    
trans_n = ' ori data';
trans_o = ' ori data';

limx_s = [-150 150];

value_s_m = mean(value2,'omitnan');
value_s_std = std(value2,'omitnan');
value_s_num = length(find(~isnan(value2)));
P1_s = 1-1./(4.*value_s_num);
P2_s = 1./(4.*value_s_num);
value_s_criterion1 = norminv(P1_s,value_s_m,value_s_std);
value_s_criterion2 = norminv(P2_s,value_s_m,value_s_std);

subplot('Position', [0.05, 0.37, 0.21, 0.29]);
    binWidth = 0.3;

    %
    edges = min(value2):binWidth:max(value2);
    %
    h1 = histogram(value2, 'BinEdges', edges,'FaceColor','k');
    hold on;
    h3 = histogram(value_sn, 'BinEdges', edges,'FaceColor','b');
    hold on;

    h5 = histogram(value_so, 'BinEdges', edges,'FaceColor','r');
    counts = h1.Values;
    hold on;
    
        p2 = plot([lower_boundary lower_boundary],[0 max(counts)],'m--','LineWidth',2);
        hold on;
        plot([upper_boundary upper_boundary],[0 max(counts)],'m--','LineWidth',2); 
        hold on;
%     xlabel('\fontname{Times New Roman}Temperature (\circ C)');
    yt = yticks;
    yt_new = yt/1e4;
    yticks(yt);
    yticklabels(yt_new);
    ylabel('\fontname{Times New Roman}Number of data (x10^4)');

    xlim([-25 45]);
    
    set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold','LineWidth', 2);
%%  ------------------------------ o2 -------------------------------------
clear
filedir = dir('E:\y-cc\RODECS\final_data_v4\qc4_*');
value_name = {'Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC','DOC','POC','PP','NH4'};

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
    
    normal_s_index = find(value2>=lower_boundary_s&value2<=upper_boundary_s);
    qc_3(1:length(value2)) = 4;
    qc_3(normal_s_index) = 3;

    qc5(1:length(value1)) = 1;
    qc5(qc1_index) = qc_3;
    
    RODECS_value12345(1:16,:) = RODECS_value1234(1:16,:);
    RODECS_value12345(5,:) = qc5;

value_sn = value2(qc_3==3);
value_so = value2(qc_3==4);

value_sn1 = value2(qc_3==3);
    
trans_n = ' ori data';
trans_o = ' ori data';

limx_s = [0 30];
limx_d = [0 30];

value_s_m = mean(value2,'omitnan');
value_s_std = std(value2,'omitnan');
value_s_num = length(find(~isnan(value2)));
P1_s = 1-1./(4.*value_s_num);
P2_s = 1./(4.*value_s_num);
value_s_criterion1 = norminv(P1_s,value_s_m,value_s_std);
value_s_criterion2 = norminv(P2_s,value_s_m,value_s_std);


subplot('Position', [0.29, 0.37, 0.21, 0.29]);
binWidth = 3;

%
edges = min(value2):binWidth:max(value2);
%
h1 = histogram(value2, 'BinEdges', edges,'FaceColor','k');
hold on;

h3 = histogram(value_sn, 'BinEdges', edges,'FaceColor','b');
hold on;

h5 = histogram(value_so, 'BinEdges', edges,'FaceColor','r');

    counts = h1(1,1).Values;
    hold on;

    p2 = plot([lower_boundary_s lower_boundary_s],[0 max(counts)],'m--','LineWidth',2);
    hold on;
    plot([upper_boundary_s upper_boundary_s],[0 max(counts)],'m--','LineWidth',2); 
    hold on;
    
    xlim([-80 350]);
    xlabel('\fontname{Times New Roman}DO (umol/L)','FontSize',20);
    yt = yticks;
    yt_new = yt/1e4;
    yticks(yt);
    yticklabels(yt_new);
%     ylabel('\fontname{Times New Roman}Number of data (x10^4)','FontSize',20);
    set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold','LineWidth', 2);
%%  ------------------------------ Si -------------------------------------
clear
filedir = dir('E:\y-cc\RODECS\final_data_v4\qc4_*');
value_name = {'Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC','DOC','POC','PP','NH4'};

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

value_sn = value2(qc_3==3);
value_so = value2(qc_3==4);
    
trans_n = ' ori data';
trans_o = ' ori data';

limx_s = [-50 50];
limx_d = [-500 500];

value_s_m = mean(value2,'omitnan');
value_s_std = std(value2,'omitnan');
value_s_num = length(find(~isnan(value2)));
P1_s = 1-1./(4.*value_s_num);
P2_s = 1./(4.*value_s_num);
value_s_criterion1 = norminv(P1_s,value_s_m,value_s_std);
value_s_criterion2 = norminv(P2_s,value_s_m,value_s_std);

subplot('Position', [0.53, 0.37, 0.21, 0.29]);
       binWidth = 4;

%
edges = min(value2):binWidth:max(value2);
%
h1 = histogram(value2, 'BinEdges', edges,'FaceColor','k');
hold on;


h3 = histogram(value_sn, 'BinEdges', edges,'FaceColor','b');
hold on;


h5 = histogram(value_so, 'BinEdges', edges,'FaceColor','r');
    counts = h1(1,1).Values;
    hold on;

    p2 = plot([lower_boundary_s lower_boundary_s],[0 max(counts)],'m--','LineWidth',2);
    hold on;
    plot([upper_boundary_s upper_boundary_s],[0 max(counts)],'m--','LineWidth',2); 
    hold on;

    xlim([-250 380]);

%     xlabel('\fontname{Times New Roman}Silicate (umol/L)','FontSize',20);
ylim([0 8500]);
    yt = yticks;
    yt_new = yt/1e4;
    yticks(yt);
    yticklabels(yt_new);
%     ylabel('\fontname{Times New Roman}Number of data (x10^3)','FontSize',20);
    set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold','LineWidth', 2);
%%  ------------------------------ no3 -------------------------------------
clear
filedir = dir('E:\y-cc\RODECS\final_data_v4\qc4_*');
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
%     
    normal_s_index = find(value2>=lower_boundary&value2<=upper_boundary);
    qc_31(1:length(value21)) = 4;
    qc_31(normal_s_index) = 3;
    qc_3(~isnan(value2)&~isinf(value2)) = qc_31;
    
    qc5(1:length(value1)) = 1;
    qc5(qc1_index) = qc_3;
    
    RODECS_value12345(1:16,:) = RODECS_value1234(1:16,:);
    RODECS_value12345(5,:) = qc5;
value_name = {'Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC','DOC','POC','PP','NH4'};

value_sn = value2(qc_3==3);
value_so = value2(qc_3==4);
value_sn1 = value3(qc_3==3);
value_so1 = value3(qc_3==4);
    
trans_n = ' ori data';
trans_o = ' ori data';


value_s_m = mean(value21,'omitnan');
value_s_std = std(value21,'omitnan');
value_s_num = length(find(~isnan(value21)));
P1_s = 1-1./(4.*value_s_num);
P2_s = 1./(4.*value_s_num);
value_s_criterion1 = norminv(P1_s,value_s_m,value_s_std);
value_s_criterion2 = norminv(P2_s,value_s_m,value_s_std);

subplot('Position', [0.77, 0.37, 0.21, 0.29]);
binWidth = 2;

%
edges = min(value21):binWidth:max(value21);
%
h1 = histogram(value21, 'BinEdges', edges,'FaceColor','b');
hold on;

h3 = histogram(value_sn, 'BinEdges', edges,'FaceColor','b');
hold on;


h5 = histogram(value_so, 'BinEdges', edges,'FaceColor','r');
    counts = h1(1,1).Values;
    hold on;

    p2 = plot([lower_boundary lower_boundary],[0 max(counts)],'m--','LineWidth',2);
    hold on;
    plot([upper_boundary upper_boundary],[0 max(counts)],'m--','LineWidth',2); 
    hold on;

    xlim([-100 120]);
ylim([0 7000]);
%     xlabel('\fontname{Times New Roman}Nitrate (umol/L)','FontSize',20);
    yt = yticks;
    yt_new = yt/1e4;
    yticks(yt);
    yticklabels(yt_new);
%     ylabel('\fontname{Times New Roman}Number of data (x10^3)','FontSize',20);
    set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold','LineWidth', 2);    
%%  ------------------------------ no2 -------------------------------------
clear
filedir = dir('E:\y-cc\RODECS\final_data_v4\qc4_*');
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
value_name = {'Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC','DOC','POC','PP','NH4'};

value_dn = value2(qc_3==3);
value_do = value2(qc_3==4);
value_dn1 = value3(qc_3==3);
    
trans_n = ' log10 data';
trans_o = ' log10 data';
subplot('Position', [0.05, 0.04, 0.21, 0.29]);
binWidth = 0.1;
    %
    edges = min(value2):binWidth:max(value2);
    %
    h1 = histogram(value2, 'BinEdges', edges,'FaceColor','k');
    hold on;
    h3 = histogram(value_dn, 'BinEdges', edges,'FaceColor','b');
    hold on;

    h5 = histogram(value_do, 'BinEdges', edges,'FaceColor','r');
    counts = h1(1,1).Values;
    hold on;

    p2 = plot([lower_boundary lower_boundary],[0 max(counts)],'m--','LineWidth',2);
    hold on;
    plot([upper_boundary upper_boundary],[0 max(counts)],'m--','LineWidth',2); 
    hold on;
    
    ylim([0 1250]);
    yt = yticks;
    yt_new = yt/1e2;
    yticks(yt);
    yticklabels(yt_new);
%     xlabel('\fontname{Times New Roman}Log10 transformed Nitrite (umol/L)','FontSize',20);
    ylabel('\fontname{Times New Roman}Number of data (x10^2)','FontSize',20);
    set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold','LineWidth', 2);
%%  ------------------------------ po4 -------------------------------------
clear
filedir = dir('E:\y-cc\RODECS\final_data_v4\qc4_*');
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

    normal_index = find(value2>=lower_boundary_s&value2<=upper_boundary_s);
    qc_3(1:length(value2)) = 4;
    qc_3(normal_index) = 3;

    qc5(1:length(value1)) = 1;
    qc5(qc1_index) = qc_3;
    
    RODECS_value12345(1:16,:) = RODECS_value1234(1:16,:);
    RODECS_value12345(5,:) = qc5;
value_name = {'Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC','DOC','POC','PP','NH4'};

value_dn = value2(qc_3==3);
value_do = value2(qc_3==4);
    
trans_n = ' ori data';
trans_o = ' ori data';

limx_s = [-500 500];
limx_d = [-500 500];

value_s_m = mean(value2,'omitnan');
value_s_std = std(value2,'omitnan');
value_s_num = length(find(~isnan(value2)));
P1_s = 1-1./(4.*value_s_num);
P2_s = 1./(4.*value_s_num);
value_s_criterion1 = norminv(P1_s,value_s_m,value_s_std);
value_s_criterion2 = norminv(P2_s,value_s_m,value_s_std);

subplot('Position', [0.29, 0.04, 0.21, 0.29]);
binWidth = 0.2;
    %
    edges = min(value2):binWidth:max(value2);
    %
    h1 = histogram(value2, 'BinEdges', edges,'FaceColor','k');
    hold on;

    h3 = histogram(value_dn, 'BinEdges', edges,'FaceColor','b');
    hold on;

    h5 = histogram(value_do, 'BinEdges', edges,'FaceColor','r');

    counts = h1(1,1).Values;
    hold on;

    p2 = plot([lower_boundary_s lower_boundary_s],[0 max(counts)],'m--','LineWidth',2);
    hold on;
    plot([upper_boundary_s upper_boundary_s],[0 max(counts)],'m--','LineWidth',2); 
    hold on;

    xlim([-5 8]);

%     xlabel('\fontname{Times New Roman}Phosphate (umol/L)','FontSize',20);
    yt = yticks;
    yt_new = yt/1e2;
    yticks(yt);
    yticklabels(yt_new);
%     ylabel('\fontname{Times New Roman}Number of data (x10^3)','FontSize',20);
%     ylabel('\fontname{Times New Roman}Number of data','FontSize',20);
    set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold','LineWidth', 2);   
%%  ------------------------------ dic -------------------------------------
clear
filedir = dir('E:\y-cc\RODECS\final_data_v4\qc4_*');
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
    
    normal_s_index = find(value2>=lower_boundary_s&value2<=upper_boundary_s);
    qc_3(1:length(value2)) = 4;
    qc_3(normal_s_index) = 3;

    qc5(1:length(value1)) = 1;
    qc5(qc1_index) = qc_3;
    
    RODECS_value12345(1:16,:) = RODECS_value1234(1:16,:);
    RODECS_value12345(5,:) = qc5;
value_name = {'Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC','DOC','POC','PP','NH4'};

value_sn = value2(qc_3==3);
value_so = value2(qc_3==4);
value_sn1 = value2(qc_3==3);

    
trans_n = ' ori data';
trans_o = ' ori data';

limx_s = [3 3.6];
limx_d = [3 3.6];

value_s_m = mean(value2,'omitnan');
value_s_std = std(value2,'omitnan');
value_s_num = length(find(~isnan(value2)));
P1_s = 1-1./(4.*value_s_num);
P2_s = 1./(4.*value_s_num);
value_s_criterion1 = norminv(P1_s,value_s_m,value_s_std);
value_s_criterion2 = norminv(P2_s,value_s_m,value_s_std);
    
subplot('Position', [0.53, 0.04, 0.21, 0.29]);
binWidth = 10;
%
edges = min(value2):binWidth:max(value2);
%
h1 = histogram(value2, 'BinEdges', edges,'FaceColor','k');
hold on;

h3 = histogram(value_sn, 'BinEdges', edges,'FaceColor','b');
hold on;

h5 = histogram(value_so, 'BinEdges', edges,'FaceColor','r');
    counts = h1(1,1).Values;
    hold on;

    p2 = plot([lower_boundary_s lower_boundary_s],[0 max(counts)],'m--','LineWidth',2);
    hold on;
    plot([upper_boundary_s upper_boundary_s],[0 max(counts)],'m--','LineWidth',2); 
    hold on;

    xlim([1200 3100]);
    yt = yticks;
    yt_new = yt/1e2;
    yticks(yt);
    yticklabels(yt_new);
%     xlabel('\fontname{Times New Roman}DIC (umol/L)','FontSize',20);
%     ylabel('\fontname{Times New Roman}Number of data','FontSize',20);  
    set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold','LineWidth', 2);  
%%  ------------------------------ poc -------------------------------------
clear
filedir = dir('E:\y-cc\RODECS\final_data_v4\qc4_*');
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
    
    normal_s_index = find(value2>=lower_boundary_s&value2<=upper_boundary_s);
    qc_3(1:length(value2)) = 4;
    qc_3(normal_s_index) = 3;

    qc5(1:length(value1)) = 1;
    qc5(qc1_index) = qc_3;
    
    RODECS_value12345(1:16,:) = RODECS_value1234(1:16,:);
    RODECS_value12345(5,:) = qc5;
value_name = {'Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC','DOC','POC','PP','NH4'};

value_sn = value2(qc_3==3);
value_so = value2(qc_3==4);
value_sn1 = value2(qc_3==3);
    
trans_n = ' ori data';
trans_o = ' ori data';

limx_s = [-10 10];
limx_d = [-10 10];

subplot('Position', [0.77, 0.04, 0.21, 0.29]);
binWidth = 20;

%
edges = min(value2):binWidth:max(value2);
%
h1 = histogram(value2, 'BinEdges', edges,'FaceColor','k');
hold on;
% 

h3 = histogram(value_sn, 'BinEdges', edges,'FaceColor','b');
% hold on;

hold on;

h5 = histogram(value_so, 'BinEdges', edges,'FaceColor','r');
counts = h1(1,1).Values;
hold on;
    p2 = plot([lower_boundary_s lower_boundary_s],[0 max(counts)],'m--','LineWidth',2);
    hold on;
    plot([upper_boundary_s upper_boundary_s],[0 max(counts)],'m--','LineWidth',2); 
    hold on;
  yt = yticks;
    yt_new = yt/1e2;
    yticks(yt);
    yticklabels(yt_new);
% xlabel('\fontname{Times New Roman}POC (umol/L)','FontSize',20);
%     ylabel('\fontname{Times New Roman}Number of data','FontSize',20);    
    set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold','LineWidth', 2);    
%%  ------------------------------ salt -------------------------------------
clear all
filedir = dir('E:\y-cc\RODECS\final_data_v4\qc4_*');
value_name = {'Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC','DOC','POC','PP','NH4'};
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
    qc_3(1:length(value2)) = 4;
    qc_3(normal_s_index) = 3;
    qc5(1:length(value1)) = 1;
    qc5(qc1_index) = qc_3;
    
    RODECS_value12345(1:16,:) = RODECS_value1234(1:16,:);
    RODECS_value12345(5,:) = qc5;

value_sn = value2(qc_3==3);
value_so = value2(qc_3==4);
    
trans_n = ' ori data';
trans_o = ' ori data';


limx_s = [25 45];
limx_d = [0 120];

value_s_m = mean(value2,'omitnan');
value_s_std = std(value2,'omitnan');
value_s_num = length(find(~isnan(value2)));
P1_s = 1-1./(4.*value_s_num);
P2_s = 1./(4.*value_s_num);
value_s_criterion1 = norminv(P1_s,value_s_m,value_s_std);
value_s_criterion2 = norminv(P2_s,value_s_m,value_s_std);

subplot('Position', [0.05, 0.7, 0.21, 0.29]);

    binWidth = 0.1;

%
edges = min(value2):binWidth:max(value2);
%
h1 = histogram(value2, 'BinEdges', edges,'FaceColor','k');
hold on;

%
pd1 = fitdist(value2', 'Normal');
x1 = linspace(min(value2), max(value2), 10000);
y1 = pdf(pd1, x1);
scaleFactor = max(h1(1,1).Values) / max(y1);
y1_scaled = y1 * scaleFactor;
h2 = plot(x1, y1_scaled, 'k--', 'LineWidth', 3);
hold on;
h3 = histogram(value_sn, 'BinEdges', edges,'FaceColor','b');
hold on;

%
pd2 = fitdist(value_sn', 'Normal');
x2 = linspace(min(value_sn), max(value_sn), 10000);
y2 = pdf(pd2, x2);
scaleFactor = max(h3(1,1).Values) / max(y2);
y2_scaled = y2 * scaleFactor;
h4 = plot(x2, y2_scaled, 'b-', 'LineWidth', 1);
hold on;

h5 = histogram(value_so, 'BinEdges', edges,'FaceColor','r');

    counts = h1(1,1).Values;
    hold on;
    p1 = plot([value_s_criterion1 value_s_criterion1],[0 max(counts)],'r--','LineWidth',2);
    hold on;
    plot([value_s_criterion2 value_s_criterion2],[0 max(counts)],'r--','LineWidth',2);  
    hold on;

    xlim([23 46]);
%     ylim([0 550000]);
%     xlabel('\fontname{Times New Roman}Salinity (psu)','FontSize',20);

    yt = yticks;
    yt_new = yt/1e3;
    yticks(yt);
%     yt_new2(1:length(yt_new)) = {'^e5'};
    yticklabels(yt_new);
    ylabel('\fontname{Times New Roman}Number of data (x10^3)','FontSize',20);
% ylabel('\fontname{Times New Roman}Number of data','FontSize',20);
    set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold','LineWidth', 2);
%%  ------------------------------ chla -------------------------------------
clear
filedir = dir('E:\y-cc\RODECS\final_data_v4\qc4_*');
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

%    
      normal_s_index = find(value2<=value_s_criterion1);

    qc_3(1:length(value2)) = 4;
    qc_3(normal_s_index) = 3;
    
    qc5(1:length(value1)) = 1;
    qc5(qc1_index) = qc_3;
    
    RODECS_value12345(1:16,:) = RODECS_value1234(1:16,:);
    RODECS_value12345(5,:) = qc5;

value_name = {'Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC','DOC','POC','PP','NH4'};

% value_shallower1 = real(value_shallower(value_shallower>-150&value_shallower<150));
value_sn = value2(qc_3==3);
value_so = value2(qc_3==4);
value_sn1 = value3(qc_3==3);
    
trans_n = ' log10 data';
trans_o = ' log10 data';

limx_s = [-4 4];
limx_d = [-4 4];

value_s_m = mean(value2,'omitnan');
value_s_std = std(value2,'omitnan');
value_s_num = length(find(~isnan(value2)));
P1_s = 1-1./(4.*value_s_num);
P2_s = 1./(4.*value_s_num);
value_s_criterion1 = norminv(P1_s,value_s_m,value_s_std);
value_s_criterion2 = norminv(P2_s,value_s_m,value_s_std);
   
subplot('Position', [0.29, 0.7, 0.21, 0.29]);
    binWidth = 0.05;

%
edges = min(value2):binWidth:max(value2);
%
h1 = histogram(value2, 'BinEdges', edges,'FaceColor','k');
hold on;

%
pd1 = fitdist(value2', 'Normal');
x1 = linspace(min(value2), max(value2), 10000);
y1 = pdf(pd1, x1);
scaleFactor = max(h1(1,1).Values) / max(y1);
y1_scaled = y1 * scaleFactor;
h2 = plot(x1, y1_scaled, 'k--', 'LineWidth', 3);
hold on;
h3 = histogram(value_sn, 'BinEdges', edges,'FaceColor','b');
hold on;

%
pd2 = fitdist(value_sn', 'Normal');
x2 = linspace(min(value_sn), max(value_sn), 100);
y2 = pdf(pd2, x2);
scaleFactor = max(h3(1,1).Values) / max(y2);
y2_scaled = y2 * scaleFactor;
h4 = plot(x2, y2_scaled, 'b-', 'LineWidth', 1);
hold on;

h5 = histogram(value_so, 'BinEdges', edges,'FaceColor','r');
    counts = h1(1,1).Values;
    hold on;
    p1 = plot([value_s_criterion1 value_s_criterion1],[0 max(counts)],'r--','LineWidth',2);
    hold on;
yt = yticks;
yt_new = yt/1e3;
yticks(yt);
yticklabels(yt_new);
%     xlabel('\fontname{Times New Roman}Log10 transformed Chla (ug/L)','FontSize',20);
%     ylabel('\fontname{Times New Roman}Number of data','FontSize',20);
    set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold','LineWidth', 2);

%%  ------------------------------ doc -------------------------------------
clear
filedir = dir('E:\y-cc\RODECS\final_data_v4\qc4_*');
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
value_name = {'Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC','DOC','POC','PP','NH4'};

% value_shallower1 = real(value_shallower(value_shallower>-150&value_shallower<150));
value_sn = value2(qc_3==3);
value_so = value2(qc_3==4);
value_sn1 = value3(qc_3==3);

    
trans_n = ' log10 data';
trans_o = ' log10 data';

limx_s = [0 4];
limx_d = [0 4];

value_s_m = mean(value2,'omitnan');
value_s_std = std(value2,'omitnan');
value_s_num = length(find(~isnan(value2)));
P1_s = 1-1./(4.*value_s_num);
P2_s = 1./(4.*value_s_num);
value_s_criterion1 = norminv(P1_s,value_s_m,value_s_std);
value_s_criterion2 = norminv(P2_s,value_s_m,value_s_std);

subplot('Position', [0.53, 0.7, 0.21, 0.29]);
   binWidth = 0.02;

%
edges = min(value2):binWidth:max(value2);
%
h1 = histogram(value2, 'BinEdges', edges,'FaceColor','k');
hold on;

%
pd1 = fitdist(value2', 'Normal');
x1 = linspace(1, max(value2), 10000);
y1 = pdf(pd1, x1);
scaleFactor = max(h1(1,1).Values) / max(y1);
y1_scaled = y1 * scaleFactor;
h2 = plot(x1, y1_scaled, 'k--', 'LineWidth', 3);
hold on;
h3 = histogram(value_sn, 'BinEdges', edges,'FaceColor','b');
hold on;

%
pd2 = fitdist(value_sn', 'Normal');
x2 = linspace(1, max(value_sn), 10000);
y2 = pdf(pd2, x2);
scaleFactor = max(h3(1,1).Values) / max(y2);
y2_scaled = y2 * scaleFactor;
h4 = plot(x2, y2_scaled, 'b-', 'LineWidth', 1);
hold on;

h5 = histogram(value_so, 'BinEdges', edges,'FaceColor','r');
    counts = h1(1,1).Values;
    hold on;
    p1 = plot([value_s_criterion1 value_s_criterion1],[0 max(counts)],'r--','LineWidth',2);

yt = yticks;
yt_new = yt/1e3;
yticks(yt);
yticklabels(yt_new);
% xlabel('\fontname{Times New Roman}Log10 transformed DOC (umol/L)','FontSize',20);
%     ylabel('\fontname{Times New Roman}Number of data','FontSize',20);
    set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold','LineWidth', 2);

%%  ------------------------------ nh4 -------------------------------------
clear
filedir = dir('E:\y-cc\RODECS\final_data_v4\qc4_*');
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

    qc_3(1:length(value2)) = 4;
    qc_3(normal_s_index) = 3;

    qc5(1:length(value1)) = 1;
    qc5(qc1_index) = qc_3;
    
    RODECS_value12345(1:16,:) = RODECS_value1234(1:16,:);
    RODECS_value12345(5,:) = qc5;
value_name = {'Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC','DOC','POC','PP','NH4'};

% value_shallower1 = real(value_shallower(value_shallower>-150&value_shallower<150));
value_sn = value2(qc_3==3);
value_so = value2(qc_3==4);
value_sn1 = value3(qc_3==3);
    
trans_n = ' log10 data';
trans_o = ' log10 data';

limx_s = [-10 10];
limx_d = [-10 10];

value_s_m = mean(value2,'omitnan');
value_s_std = std(value2,'omitnan');
value_s_num = length(find(~isnan(value2)));
P1_s = 1-1./(4.*value_s_num);
P2_s = 1./(4.*value_s_num);
value_s_criterion1 = norminv(P1_s,value_s_m,value_s_std);
value_s_criterion2 = norminv(P2_s,value_s_m,value_s_std);

subplot('Position', [0.77, 0.7, 0.21, 0.29]);

%
binWidth = 0.2;

%
edges = min(value2):binWidth:max(value2);
%
h1 = histogram(value2, 'BinEdges', edges,'FaceColor','k');
hold on;

%
pd1 = fitdist(value2', 'Normal');
x1 = linspace(min(value2), 3, 10000);
y1 = pdf(pd1, x1);
scaleFactor = max(h1(1,1).Values) / max(y1);
y1_scaled = y1 * scaleFactor;
h2 = plot(x1, y1_scaled, 'k--', 'LineWidth', 3);
hold on;
h3 = histogram(value_sn, 'BinEdges', edges,'FaceColor','b');
hold on;

%
pd2 = fitdist(value_sn', 'Normal');
x2 = linspace(min(value_sn), 2, 10000);
y2 = pdf(pd2, x2);
scaleFactor = max(h3(1,1).Values) / max(y2);
    y2_scaled = y2 * scaleFactor;
h4 = plot(x2, y2_scaled, 'b-', 'LineWidth', 1);
hold on;

h5 = histogram(value_so, 'BinEdges', edges,'FaceColor','r');
counts = h1.Values;
hold on;
p1 = plot([value_s_criterion1 value_s_criterion1],[0 max(counts)],'r--','LineWidth',2);
hold on;
yt = yticks;
yt_new = yt/1e3;
yticks(yt);
yticklabels(yt_new);
% xlabel('\fontname{Times New Roman}Log10 transformed Ammonium (umol/L)','FontSize',20);
% ylabel('\fontname{Times New Roman}Number of data','FontSize',20);
set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold','LineWidth', 2);
set(gcf, 'WindowState', 'maximized');
cd 'E:\y-cc\RODECS\final_data_v4\qc5_value_range_figure'; 
print('All.tif','-dtiff','-r300');
close;
