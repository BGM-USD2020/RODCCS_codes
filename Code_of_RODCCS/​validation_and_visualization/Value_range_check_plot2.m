%%                    ann 
%    work with mld_data_plot.m
%%  ------------------------------ temp -------------------------------------
value_name = {'Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC','DOC','POC','PP','NH4'};

% value_shallower1 = real(value_shallower(value_shallower>-150&value_shallower<150));
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


%     subplot(2,1,1);
    figure('Units','centimeters',...
            'PaperType', 'A4',...
            'PaperOrientation','landscape',...
            'Position',[5 5 38 20],...
            'PaperPosition',[5 5 28 20],...
            'PaperUnits','centimeters')
    binWidth = 0.1;


    edges = min(value2):binWidth:max(value2);
    h1 = histogram(value2, 'BinEdges', edges,'FaceColor','b');
    hold on;

    h3 = histogram(value_sn, 'BinEdges', edges,'FaceColor','g');
    hold on;



    h5 = histogram(value_so, 'BinEdges', edges,'FaceColor','r');
    counts = h1.Values;
    hold on;

        p2 = plot([lower_boundary lower_boundary],[0 max(counts)],'r--','LineWidth',1);
        hold on;
        plot([upper_boundary upper_boundary],[0 max(counts)],'r--','LineWidth',1); 
        hold on;
    xlabel('\fontname{Times New Roman}Temperature (\circ C)');
    yt = yticks;
    yt_new = yt/1e4;
    yticks(yt);
    yticklabels(yt_new);
    ylabel('\fontname{Times New Roman}Number of data (x10^4)');
%     ylabel('\fontname{Times New Roman}Number of data');
    %title(string(strcat(value_name(v),trans_n)),'FontSize',20);
    xlim([-20 35]);
    
    set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold','LineWidth', 2);
%     set(gcf, 'WindowState', 'maximized');
    cd 'E:\y-cc\RODECS\final_data_v4\qc5_value_range_figure\';
    print(string(strcat(value_name(v-3),' pass and outiers')),'-dtiff','-r300');
%     print(string(strcat(value_name(v-3),' pass and outiers_s')),'-dtiff','-r300');
    close;
    
    h5 = histogram(value_so, 20,'FaceColor','r');
%     xlabel('\fontname{Times New Roman}Temperature (\circ C)');
%     ylabel('\fontname{Times New Roman}Number of data');
    set(gca,'FontName','Times New Roman','FontSize',40,'FontWeight','bold','LineWidth', 2);
    print(string(strcat(value_name(v-3),' pass and outiers_s')),'-dtiff','-r300');
    close;
%%  ------------------------------ salt -------------------------------------
value_name = {'Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC','DOC','POC','PP','NH4'};

% value_shallower1 = (value_shallower(value_shallower>-150&value_shallower<150));
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

    figure('Units','centimeters',...
            'PaperType', 'A4',...
            'PaperOrientation','landscape',...
            'Position',[5 5 38 20],...
            'PaperPosition',[5 5 28 20],...
            'PaperUnits','centimeters')

    binWidth = 0.1;

edges = min(value2):binWidth:max(value2);
%
h1 = histogram(value2, 'BinEdges', edges,'FaceColor','b');
hold on;

%
pd1 = fitdist(value2', 'Normal');
x1 = linspace(min(value2), max(value2), 10000);
y1 = pdf(pd1, x1);
scaleFactor = max(h1(1,1).Values) / max(y1);
y1_scaled = y1 * scaleFactor;
h2 = plot(x1, y1_scaled, 'b-', 'LineWidth', 1);
hold on;
h3 = histogram(value_sn, 'BinEdges', edges,'FaceColor','g');
hold on;

%
pd2 = fitdist(value_sn', 'Normal');
x2 = linspace(min(value_sn), max(value_sn), 10000);
y2 = pdf(pd2, x2);
scaleFactor = max(h3(1,1).Values) / max(y2);
y2_scaled = y2 * scaleFactor;
h4 = plot(x2, y2_scaled, 'g-', 'LineWidth', 1);
hold on;

h5 = histogram(value_so, 'BinEdges', edges,'FaceColor','r');
% h5 = histogram(value_so,200,'FaceColor','r');
% legend([h5],'\fontname{Times New Roman}Outliers');
    counts = h1(1,1).Values;
    hold on;
    p1 = plot([value_s_criterion1 value_s_criterion1],[0 max(counts)],'r--','LineWidth',1);
    hold on;
    plot([value_s_criterion2 value_s_criterion2],[0 max(counts)],'r--','LineWidth',1);  
    hold on;
    xlim([25 40]);
    xlabel('\fontname{Times New Roman}Salinity (psu)','FontSize',20);

    yt = yticks;
    yt_new = yt/1e5;
    yticks(yt);
    yticklabels(yt_new);
    ylabel('\fontname{Times New Roman}Number of data (x10^4)','FontSize',20);
%     ylabel('\fontname{Times New Roman}Number of data','FontSize',20);
    set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold','LineWidth', 2);
    

%     set(gcf, 'WindowState', 'maximized');
    cd 'E:\y-cc\RODECS\final_data_v4\qc5_value_range_figure\';
    print(string(strcat(value_name(v-3),' pass and outiers')),'-dtiff','-r300');
%     print(string(strcat(value_name(v-3),' pass and outiers_s')),'-dtiff','-r300');
    close;
    
    h5 = histogram(value_so(value_so<1500),100,'FaceColor','r');
    xlim([0 25]);
%     xlabel('\fontname{Times New Roman}Salinity (psu)','FontSize',20);
%     ylabel('\fontname{Times New Roman}Number of data','FontSize',20);
    set(gca,'FontName','Times New Roman','FontSize',40,'FontWeight','bold','LineWidth', 2);
    print(string(strcat(value_name(v-3),' pass and outiers_s')),'-dtiff','-r300');
    close;
%%  ------------------------------ o2 -------------------------------------
value_name = {'Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC','DOC','POC','PP','NH4'};

% value_shallower1 = (value_shallower(value_shallower>-150&value_shallower<150));
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

    figure('Units','centimeters',...
            'PaperType', 'A4',...
            'PaperOrientation','landscape',...
            'Position',[5 5 38 20],...
            'PaperPosition',[5 5 28 20],...
            'PaperUnits','centimeters')
%     subplot(2,1,1);
    binWidth = 1.5;

%
edges = min(value2):binWidth:max(value2);
%
h1 = histogram(value2, 'BinEdges', edges,'FaceColor','b');
hold on;

h3 = histogram(value_sn, 'BinEdges', edges,'FaceColor','g');
hold on;

h5 = histogram(value_so, 'BinEdges', edges,'FaceColor','r');

    counts = h1(1,1).Values;
    hold on;


    p2 = plot([lower_boundary_s lower_boundary_s],[0 max(counts)],'r--','LineWidth',1);
    hold on;
    plot([upper_boundary_s upper_boundary_s],[0 max(counts)],'r--','LineWidth',1); 
    hold on;
    
    xlim([-80 350]);
    xlabel('\fontname{Times New Roman}DO (umol/L)','FontSize',20);
    yt = yticks;
    yt_new = yt/1e4;
    yticks(yt);
    yticklabels(yt_new);
    ylabel('\fontname{Times New Roman}Number of data (x10^4)','FontSize',20);
%      ylabel('\fontname{Times New Roman}Number of data','FontSize',20);
    set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold','LineWidth', 2);

%     set(gcf, 'WindowState', 'maximized');
    cd 'E:\y-cc\RODECS\final_data_v4\qc5_value_range_figure\';
    print(string(strcat(value_name(v-3),' pass and outiers')),'-dtiff','-r300');
%     print(string(strcat(value_name(v-3),' pass and outiers_s')),'-dtiff','-r300');
    close;
    
    h5 = histogram(value_so, 50,'FaceColor','r');
%     xlabel('\fontname{Times New Roman}DO (umol/L)','FontSize',20);
%     ylabel('\fontname{Times New Roman}Number of data','FontSize',20);
    set(gca,'FontName','Times New Roman','FontSize',40,'FontWeight','bold','LineWidth', 2);
    print(string(strcat(value_name(v-3),' pass and outiers_s')),'-dtiff','-r300');
    close;
%%  ------------------------------ Si -------------------------------------
value_name = {'Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC','DOC','POC','PP','NH4'};

% value_shallower1 = (value_shallower(value_shallower>-150&value_shallower<150));
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

    figure('Units','centimeters',...
            'PaperType', 'A4',...
            'PaperOrientation','landscape',...
            'Position',[5 5 38 20],...
            'PaperPosition',[5 5 28 20],...
            'PaperUnits','centimeters')
%     subplot(2,1,1);
       binWidth = 1;

%
edges = min(value2):binWidth:max(value2);
%
h1 = histogram(value2, 'BinEdges', edges,'FaceColor','b');
hold on;

%
h3 = histogram(value_sn, 'BinEdges', edges,'FaceColor','g');
hold on;

h5 = histogram(value_so, 'BinEdges', edges,'FaceColor','r');
    counts = h1(1,1).Values;
    hold on;

    p2 = plot([lower_boundary_s lower_boundary_s],[0 max(counts)],'r--','LineWidth',1);
    hold on;
    plot([upper_boundary_s upper_boundary_s],[0 max(counts)],'r--','LineWidth',1); 
    hold on;

    xlim([-250 380]);

    xlabel('\fontname{Times New Roman}Silicate (umol/L)','FontSize',20);
    yt = yticks;
    yt_new = yt/1e3;
    yticks(yt);
    yticklabels(yt_new);
    ylabel('\fontname{Times New Roman}Number of data (x10^3)','FontSize',20);
    set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold','LineWidth', 2);

%     set(gcf, 'WindowState', 'maximized');
    cd 'E:\y-cc\RODECS\final_data_v4\qc5_value_range_figure\';
    print(string(strcat(value_name(v-3),' pass and outiers')),'-dtiff','-r300');
    close;
%%  ------------------------------ no3 -------------------------------------
value_name = {'Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC','DOC','POC','PP','NH4'};

% value_shallower1 = (value_shallower(value_shallower>-150&value_shallower<150));
value_sn = value2(qc_3==3);
value_so = value2(qc_3==4);
% value_shallower1 = value3(value_shallower_index);
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
    figure('Units','centimeters',...
            'PaperType', 'A4',...
            'PaperOrientation','landscape',...
            'Position',[5 5 38 20],...
            'PaperPosition',[5 5 28 20],...
            'PaperUnits','centimeters')
%     subplot(2,1,1);
binWidth = 1;

%
edges = min(value21):binWidth:max(value21);
%
h1 = histogram(value21, 'BinEdges', edges,'FaceColor','b');
hold on;

h3 = histogram(value_sn, 'BinEdges', edges,'FaceColor','g');
hold on;

%

h5 = histogram(value_so, 'BinEdges', edges,'FaceColor','r');
    counts = h1(1,1).Values;
    hold on;


    p2 = plot([lower_boundary lower_boundary],[0 max(counts)],'r--','LineWidth',1);
    hold on;
    plot([upper_boundary upper_boundary],[0 max(counts)],'r--','LineWidth',1); 
    hold on;
    
    
    xlim([-100 120]);

    xlabel('\fontname{Times New Roman}Nitrate (umol/L)','FontSize',20);
    yt = yticks;
    yt_new = yt/1e3;
    yticks(yt);
    yticklabels(yt_new);
    ylabel('\fontname{Times New Roman}Number of data (x10^3)','FontSize',20);
    set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold','LineWidth', 2);

%     set(gcf, 'WindowState', 'maximized');
    cd 'E:\y-cc\RODECS\final_data_v4\qc5_value_range_figure\';
    print(string(strcat(value_name(v-3),' pass and outiers')),'-dtiff','-r300');
    close;
%%  ------------------------------ no2 -------------------------------------
value_name = {'Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC','DOC','POC','PP','NH4'};

value_dn = value2(qc_3==3);
value_do = value2(qc_3==4);
value_dn1 = value3(qc_3==3);
    
trans_n = ' log10 data';
trans_o = ' log10 data';
    figure('Units','centimeters',...
            'PaperType', 'A4',...
            'PaperOrientation','landscape',...
            'Position',[5 5 38 20],...
            'PaperPosition',[5 5 28 20],...
            'PaperUnits','centimeters')
binWidth = 0.15;

    %
    edges = min(value2):binWidth:max(value2);
    %
    h1 = histogram(value2, 'BinEdges', edges,'FaceColor','b');
    hold on;
    %

    h3 = histogram(value_dn, 'BinEdges', edges,'FaceColor','g');
    hold on;

    %


    h5 = histogram(value_do, 'BinEdges', edges,'FaceColor','r');
    counts = h1(1,1).Values;
    hold on;


    p2 = plot([lower_boundary lower_boundary],[0 max(counts)],'r--','LineWidth',1);
    hold on;
    plot([upper_boundary upper_boundary],[0 max(counts)],'r--','LineWidth',1); 
    hold on;
    

    ylim([0 950]);
    xlabel('\fontname{Times New Roman}Log10 transformed Nitrite (umol/L)','FontSize',20);
    ylabel('\fontname{Times New Roman}Number of data','FontSize',20);
    set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold','LineWidth', 2);

%     set(gcf, 'WindowState', 'maximized');
    cd 'E:\y-cc\RODECS\final_data_v4\qc5_value_range_figure\';
    print(string(strcat(value_name(v-3),' pass and outiers')),'-dtiff','-r300');
    close;
%%  ------------------------------ po4 -------------------------------------
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
    figure('Units','centimeters',...
            'PaperType', 'A4',...
            'PaperOrientation','landscape',...
            'Position',[5 5 38 20],...
            'PaperPosition',[5 5 28 20],...
            'PaperUnits','centimeters')    
binWidth = 0.2;

    %
    edges = min(value2):binWidth:max(value2);
    %
    h1 = histogram(value2, 'BinEdges', edges,'FaceColor','b');
    hold on;
    %
    h3 = histogram(value_dn, 'BinEdges', edges,'FaceColor','g');
    hold on;


    h5 = histogram(value_do, 'BinEdges', edges,'FaceColor','r');

    counts = h1(1,1).Values;
    hold on;
    p2 = plot([lower_boundary_s lower_boundary_s],[0 max(counts)],'r--','LineWidth',1);
    hold on;
    plot([upper_boundary_s upper_boundary_s],[0 max(counts)],'r--','LineWidth',1); 
    hold on;

    xlim([-5 8]);

    xlabel('\fontname{Times New Roman}Phosphate (umol/L)','FontSize',20);
    yt = yticks;
    yt_new = yt/1e3;
    yticks(yt);
    yticklabels(yt_new);
    ylabel('\fontname{Times New Roman}Number of data (x10^3)','FontSize',20);
%     ylabel('\fontname{Times New Roman}Number of data','FontSize',20);
    set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold','LineWidth', 2);

%     set(gcf, 'WindowState', 'maximized');
    cd 'E:\y-cc\RODECS\final_data_v4\qc5_value_range_figure\';
    print(string(strcat(value_name(v-3),' pass and outiers')),'-dtiff','-r300');
%     print(string(strcat(value_name(v-3),' pass and outiers_s')),'-dtiff','-r300');
    close;
    
    h5 = histogram(value_do,10,'FaceColor','r');
%     xlabel('\fontname{Times New Roman}Phosphate (umol/L)','FontSize',20);
%     ylabel('\fontname{Times New Roman}Number of data','FontSize',20);
    set(gca,'FontName','Times New Roman','FontSize',40,'FontWeight','bold','LineWidth', 2);
    print(string(strcat(value_name(v-3),' pass and outiers_s')),'-dtiff','-r300');
    close;
%%  ------------------------------ chla -------------------------------------
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

    figure('Units','centimeters',...
            'PaperType', 'A4',...
            'PaperOrientation','landscape',...
            'Position',[5 5 38 20],...
            'PaperPosition',[5 5 28 20],...
            'PaperUnits','centimeters')
%     subplot(2,1,1);
    binWidth = 0.05;

%
edges = min(value2):binWidth:max(value2);
%
h1 = histogram(value2, 'BinEdges', edges,'FaceColor','b');
hold on;

%
pd1 = fitdist(value2', 'Normal');
x1 = linspace(min(value2), max(value2), 10000);
y1 = pdf(pd1, x1);
scaleFactor = max(h1(1,1).Values) / max(y1);
y1_scaled = y1 * scaleFactor;
h2 = plot(x1, y1_scaled, 'b-', 'LineWidth', 2);
hold on;
h3 = histogram(value_sn, 'BinEdges', edges,'FaceColor','g');
hold on;

%
pd2 = fitdist(value_sn', 'Normal');
x2 = linspace(min(value_sn), max(value_sn), 100);
y2 = pdf(pd2, x2);
scaleFactor = max(h3(1,1).Values) / max(y2);
y2_scaled = y2 * scaleFactor;
h4 = plot(x2, y2_scaled, 'g-', 'LineWidth', 2);
hold on;

h5 = histogram(value_so, 'BinEdges', edges,'FaceColor','r');
    counts = h1(1,1).Values;
    hold on;
    p1 = plot([value_s_criterion1 value_s_criterion1],[0 max(counts)],'r--','LineWidth',1);
    hold on;

    xlabel('\fontname{Times New Roman}Log10 transformed Chla (ug/L)','FontSize',20);
    ylabel('\fontname{Times New Roman}Number of data','FontSize',20);
    set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold','LineWidth', 2);

%     set(gcf, 'WindowState', 'maximized');
    cd 'E:\y-cc\RODECS\final_data_v4\qc5_value_range_figure\';
    print(string(strcat(value_name(v-3),' pass and outiers')),'-dtiff','-r300');
    close;
%%  ------------------------------ dic -------------------------------------
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
    figure('Units','centimeters',...
            'PaperType', 'A4',...
            'PaperOrientation','landscape',...
            'Position',[5 5 38 20],...
            'PaperPosition',[5 5 28 20],...
            'PaperUnits','centimeters')
   binWidth = 5;

%
edges = min(value2):binWidth:max(value2);
%
h1 = histogram(value2, 'BinEdges', edges,'FaceColor','b');
hold on;

%
h3 = histogram(value_sn, 'BinEdges', edges,'FaceColor','g');
hold on;

%

h5 = histogram(value_so, 'BinEdges', edges,'FaceColor','r');
    counts = h1(1,1).Values;
    hold on;

    p2 = plot([lower_boundary_s lower_boundary_s],[0 max(counts)],'r--','LineWidth',1);
    hold on;
    plot([upper_boundary_s upper_boundary_s],[0 max(counts)],'r--','LineWidth',1); 
    hold on;

    xlim([1200 3100]);
    xlabel('\fontname{Times New Roman}DIC (umol/L)','FontSize',20);
    ylabel('\fontname{Times New Roman}Number of data','FontSize',20);  
    set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold','LineWidth', 2);
    
%     set(gcf, 'WindowState', 'maximized');
    cd 'E:\y-cc\RODECS\final_data_v4\qc5_value_range_figure\';
    print(string(strcat(value_name(v-3),' pass and outiers')),'-dtiff','-r300');
    close;
%%  ------------------------------ doc -------------------------------------
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

    figure('Units','centimeters',...
            'PaperType', 'A4',...
            'PaperOrientation','landscape',...
            'Position',[5 5 38 20],...
            'PaperPosition',[5 5 28 20],...
            'PaperUnits','centimeters')
   binWidth = 0.01;

%
edges = min(value2):binWidth:max(value2);
%
h1 = histogram(value2, 'BinEdges', edges,'FaceColor','b');
hold on;

%
pd1 = fitdist(value2', 'Normal');
x1 = linspace(1, max(value2), 10000);
y1 = pdf(pd1, x1);
scaleFactor = max(h1(1,1).Values) / max(y1);
y1_scaled = y1 * scaleFactor;
h2 = plot(x1, y1_scaled, 'b-', 'LineWidth', 2);
hold on;
h3 = histogram(value_sn, 'BinEdges', edges,'FaceColor','g');
hold on;

%
pd2 = fitdist(value_sn', 'Normal');
x2 = linspace(1, max(value_sn), 10000);
y2 = pdf(pd2, x2);
scaleFactor = max(h3(1,1).Values) / max(y2);
y2_scaled = y2 * scaleFactor;
h4 = plot(x2, y2_scaled, 'g-', 'LineWidth', 2);
hold on;

h5 = histogram(value_so, 'BinEdges', edges,'FaceColor','r');
    counts = h1(1,1).Values;
    hold on;
    p1 = plot([value_s_criterion1 value_s_criterion1],[0 max(counts)],'r--','LineWidth',1);
xlabel('\fontname{Times New Roman}Log10 transformed DOC (umol/L)','FontSize',20);
    ylabel('\fontname{Times New Roman}Number of data','FontSize',20);
    set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold','LineWidth', 2);
    
%     set(gcf, 'WindowState', 'maximized');
    cd 'E:\y-cc\RODECS\final_data_v4\qc5_value_range_figure\';
    print(string(strcat(value_name(v+9),' pass and outiers')),'-dtiff','-r300');
    close;
%%  ------------------------------ poc -------------------------------------
value_name = {'Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC','DOC','POC','PP','NH4'};

% value_shallower1 = real(value_shallower(value_shallower>-150&value_shallower<150));
value_sn = value2(qc_3==3);
value_so = value2(qc_3==4);
value_sn1 = value2(qc_3==3);
    
trans_n = ' ori data';
trans_o = ' ori data';

limx_s = [-10 10];
limx_d = [-10 10];
    figure('Units','centimeters',...
            'PaperType', 'A4',...
            'PaperOrientation','landscape',...
            'Position',[5 5 38 20],...
            'PaperPosition',[5 5 28 20],...
            'PaperUnits','centimeters')
   binWidth = 8;

%
edges = min(value2):binWidth:max(value2);
%
h1 = histogram(value2, 'BinEdges', edges,'FaceColor','b');
hold on;
% 

h3 = histogram(value_sn, 'BinEdges', edges,'FaceColor','g');
% hold on;
% 

hold on;

h5 = histogram(value_so, 'BinEdges', edges,'FaceColor','r');
counts = h1(1,1).Values;
hold on;

    p2 = plot([lower_boundary_s lower_boundary_s],[0 max(counts)],'r--','LineWidth',1);
    hold on;
    plot([upper_boundary_s upper_boundary_s],[0 max(counts)],'r--','LineWidth',1); 
    hold on;

xlabel('\fontname{Times New Roman}POC (umol/L)','FontSize',20);
    ylabel('\fontname{Times New Roman}Number of data','FontSize',20);    
    set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold','LineWidth', 2);
%     set(gcf, 'WindowState', 'maximized');
    
    cd 'E:\y-cc\RODECS\final_data_v4\qc5_value_range_figure\';
    print(string(strcat(value_name(v+9),' pass and outiers')),'-dtiff','-r300');
    close;
%%  ------------------------------ nh4 -------------------------------------
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

    figure('Units','centimeters',...
            'PaperType', 'A4',...
            'PaperOrientation','landscape',...
            'Position',[5 5 38 20],...
            'PaperPosition',[5 5 28 20],...
            'PaperUnits','centimeters')
% subplot(2,1,1);
%
binWidth = 0.1;

%
edges = min(value2):binWidth:max(value2);
%
h1 = histogram(value2, 'BinEdges', edges,'FaceColor','b');
hold on;

%
pd1 = fitdist(value2', 'Normal');
x1 = linspace(min(value2), 3, 10000);
y1 = pdf(pd1, x1);
scaleFactor = max(h1(1,1).Values) / max(y1);
y1_scaled = y1 * scaleFactor;
h2 = plot(x1, y1_scaled, 'b-', 'LineWidth', 2);
hold on;
h3 = histogram(value_sn, 'BinEdges', edges,'FaceColor','g');
hold on;

%
pd2 = fitdist(value_sn', 'Normal');
x2 = linspace(min(value_sn), 2, 10000);
y2 = pdf(pd2, x2);
scaleFactor = max(h3(1,1).Values) / max(y2);
    y2_scaled = y2 * scaleFactor;
h4 = plot(x2, y2_scaled, 'g-', 'LineWidth', 2);
hold on;

h5 = histogram(value_so, 'BinEdges', edges,'FaceColor','r');
counts = h1.Values;
hold on;
p1 = plot([value_s_criterion1 value_s_criterion1],[0 max(counts)],'r--','LineWidth',1);
hold on;

xlabel('\fontname{Times New Roman}Log10 transformed Ammonium (umol/L)','FontSize',20);
ylabel('\fontname{Times New Roman}Number of data','FontSize',20);
    
    cd 'E:\y-cc\RODECS\final_data_v4\qc5_value_range_figure\';
    print(string(strcat(value_name(v+10),' pass and outiers')),'-dtiff','-r300');
    close;
%%
 figure('Units','centimeters',...
            'PaperType', 'A4',...
            'PaperOrientation','landscape',...
            'Position',[5 5 45 20],...
            'PaperPosition',[5 5 28 20],...
            'PaperUnits','centimeters')
h1 = histogram([nan],'FaceColor','b');
hold on;
h2 = plot([nan], [nan], 'b-', 'LineWidth', 2);
hold on;
h3 = histogram([nan],'FaceColor','g');
hold on;
h4 = plot([nan], [nan], 'g-', 'LineWidth', 2);
hold on;
h5 = histogram([nan],'FaceColor','r');
hold on;
p1 = plot([nan nan],[nan nan],'r--','LineWidth',1);
hold on;
p2 = plot([nan nan],[nan nan],'g--','LineWidth',1);
legend([h1,h2,h3,h5,h4,p1],'Original data','Original fitting-line','Passed data',...
    'Passed fitting-line','Failed data','Chauvenet criterion thresholds','Box', 'off','NumColumns',4);
set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold');
axis off;
cd 'E:\y-cc\RODECS\final_data_v4\qc5_value_range_figure';
print('legend2.png','-dtiff','-r300');
close