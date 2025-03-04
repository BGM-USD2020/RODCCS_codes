%%                    vertical plot
clear
close
clc

lon_g0 = ncread('D:\y-cc\data\GEBCO\GEBCO_2023_sub_ice_topo.nc','lon');
lat_g0 = ncread('D:\y-cc\data\GEBCO\GEBCO_2023_sub_ice_topo.nc','lat');
depth_g0 = ncread('D:\y-cc\data\GEBCO\GEBCO_2023_sub_ice_topo.nc','elevation');
depth_g = depth_g0(116.*240+180.*240:135.*240+180.*240,20.*240+90.*240:42.*240+90.*240);
lon_g = lon_g0(116.*240+180.*240:135.*240+180.*240);
lat_g = lat_g0(20.*240+90.*240:42.*240+90.*240);
depth_g(depth_g>0) = nan;
for i=[1:10:length(lon_g)]
     lon_g1((i+9)/10) = mean(lon_g(i:min(i+9,end)),'omitnan');
end
for i=[1:10:length(lat_g)]
     lat_g1((i+9)/10) = mean(lat_g(i:min(i+9,end)),'omitnan');
end
for i=[1:10:length(lon_g)]
     depth_g3((i+9)/10,:) = mean(depth_g(i:min(i+9,end),:),1,'omitnan');
end
for j=[1:10:length(lat_g)]
     depth_g1(:,(j+9)/10) = mean(depth_g3(:,j:min(j+9,end)),2,'omitnan');
end
[lon_g2,lat_g2] = meshgrid(lon_g,lat_g);


filedir = dir('E:\y-cc\RODECS\final_data_v4\qc3_*');
value_name = {'DOC','POC','NH4','Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC'};
value_name1 = {'DOC','POC','Ammonium','Tempreature','Salinity','DO','Silicate','Nitrate','Nitrite','Phosphate','Chla','DIC'};
h = [10 11 12 1 2 3 4 5 6 7 8 9];
range_caxis1 = [30 20 0 0 30 0 0 0 0 0 0 1800];
range_caxis2 = [100 140 10 40 37 270 200 50 0.3 3 2 2200];
% ------------------------- lonsection --------------------------------------
figure('Units','centimeters',...
            'PaperType', 'A4',...
            'PaperOrientation','landscape',...
            'Position',[1 1 50 100],...
            'PaperPosition',[1 1 50 100],...
            'PaperUnits','centimeters');  
for v=1:12
    cd E:\y-cc\RODECS\final_data_v4\;
    disp(v);
    filename = filedir(v).name;
    load (filename);
    location_setting;
    qc1 = RODECS_value123(1,:)';
    qc2 = RODECS_value123(2,:)';
    qc3 = RODECS_value123(3,:)';
    value3 = RODECS_value123(16,:)';   
    lon3 = RODECS_value123(9,:)';
    lat3 = RODECS_value123(10,:)';
    depth3 = RODECS_value123(11,:)';
     
    if v==1|v==2|v==12
        latsection = 23.08
        lat_index = find(abs(lat_g-latsection)==min(abs(lat_g-latsection)));
        delta = 0.01;
       subplot('Position', location(:,1,v));
%         h0 = scatter([nan],[nan],150,[nan],'filled','s');
%         hold on;
        if ~isnan(lon3((qc3==3|qc3==4)&lat3<=latsection+delta&lat3>=latsection-delta))
            scatter(lon3((qc3==3|qc3==4)&lat3<=latsection+delta&lat3>=latsection-delta),...
                depth3((qc3==3|qc3==4)&lat3<=latsection+delta&lat3>=latsection-delta),...
                40,value3((qc3==3|qc3==4)&lat3<=latsection+delta&lat3>=latsection-delta),'ko');
        else
            scatter([nan],[nan],40,[nan],'ko');
        end
        hold on;
        h1 = plot(lon_g,-depth_g(:,lat_index),'k-','LineWidth',2);
        yt = yticks;
        yt_new = yt/1e3;
        yticks(yt);
        yticklabels(yt_new);
%         ylabel('Depth (km)','FontSize',19);
%         set(gcf, 'WindowState', 'maximized');
        if v==4|v==5|v==6
           yticks([0 2000 4000 6000]);
           yticklabels({'0','2','4','6'});
        else
           set(gca, 'YTicklabels',{}); 
        end
        set(gca,'XTicklabels',{}, 'YDir', 'reverse','LineWidth', 2);
        xticks([116 120 125 130 135]);
        ylim([-50 7000]);
        xlim([116 135]);
        caxis([range_caxis1(v),range_caxis2(v)]);
        set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold');
%         colormap('jet');
        set(gca, 'YDir', 'reverse','LineWidth', 2);
        
        subplot('Position', location(:,2,v));
%         h0 = scatter([nan],[nan],150,[nan],'filled','o');
%         hold on;
        if ~isnan(lon3(qc3==3&lat3<=latsection+delta&lat3>=latsection-delta))
            scatter(lon3(qc3==3&lat3<=latsection+delta&lat3>=latsection-delta),...
                depth3(qc3==3&lat3<=latsection+delta&lat3>=latsection-delta),...
                40,value3(qc3==3&lat3<=latsection+delta&lat3>=latsection-delta),'bo');
        else
            scatter([nan],[nan],40,[nan],'bo');
        end
        hold on;
        h1 = plot(lon_g,-depth_g(:,lat_index),'k-','LineWidth',2);
        yt = yticks;
        yt_new = yt/1e3;
        yticks(yt);
        yticklabels(yt_new);
%         xlabel('Latitude (\circN)','FontSize',19);
%         ylabel('Depth (km)','FontSize',19);
%         set(gcf, 'WindowState', 'maximized');
        if v==4|v==5|v==6
           yticks([0 2000 4000 6000]);
           yticklabels({'0','2','4','6'});
        else
           set(gca, 'YTicklabels',{}); 
        end
        xticks([116 120 125 130 135]);
        set(gca,'XTicklabels',{}, 'YDir', 'reverse','LineWidth', 2);
        ylim([-50 7000]);
        xlim([116 135]);
        caxis([range_caxis1(v),range_caxis2(v)]);
        set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold');
%         colormap('jet');
        set(gca, 'YDir', 'reverse','LineWidth', 2);
        
        subplot('Position', location(:,3,v));
%         h2 = scatter([nan],[nan],150,[nan],'filled','p');
%         hold on;
        if ~isempty(value3(qc3==4&lat3<=latsection+delta&lat3>=latsection-delta&depth3>0))
            scatter(lon3(qc3==4&lat3<=latsection+delta&lat3>=latsection-delta&depth3>0),...
            depth3(qc3==4&lat3<=latsection+delta&lat3>=latsection-delta&depth3>0),...
            40,value3(qc3==4&lat3<=latsection+delta&lat3>=latsection-delta&depth3>0),'ro');
        else
            h2 = scatter([nan],[nan],40,[nan],'ro');
        end
        hold on;
        scatter(lon3(qc3==4&lat3<=latsection+delta&lat3>=latsection-delta&depth3<0),...
            depth3(qc3==4&lat3<=latsection+delta&lat3>=latsection-delta&depth3<0),...
            40,value3(qc3==4&lat3<=latsection+delta&lat3>=latsection-delta&depth3<0),'ro');
        hold on;
        h1 = plot(lon_g,-depth_g(:,lat_index),'k-','LineWidth',2);
        yt = yticks;
        yt_new = yt/1e3;
        yticks(yt);
        yticklabels(yt_new);
        xticks([116 120 125 130 135]);
        if v==4|v==5|v==6
           yticks([0 2000 4000 6000]);
           yticklabels({'0','2','4','6'});
        else
           set(gca, 'YTicklabels',{}); 
        end
        if v==6|v==9|v==11|v==2
            pos=axis;
            xlabel('Longitude (\circE)','position',[pos(2)-9 1.5.*pos(4)],'FontSize',19);
            xticks([116 120 125 130 135]);
            xticklabels({'116','120','125','130','135'});
        else
            set(gca, 'XTicklabels',{}); 
        end
%         ylabel('Depth (km)','FontSize',19);
%         set(gcf, 'WindowState', 'maximized');
        set(gca, 'YDir', 'reverse','LineWidth', 2);
        ylim([-50 7000]);
        xlim([116 135]);
        caxis([range_caxis1(v),range_caxis2(v)]);
        set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold');
%         colormap('jet');
%         colorbar;
        set(gca, 'YDir', 'reverse','LineWidth', 2);      
        

        set(gca,'FontName','Times New Roman','FontSize',20,'FontWeight','bold');
    else
     lonsection = 123
        lon_index = find(abs(lon_g-lonsection)==min(abs(lon_g-lonsection)));
        delta = 0.01;

        subplot('Position', location(:,1,v));
%         h0 = scatter([nan],[nan],100,[nan],'filled','s');
%         hold on;
        if ~isnan(lat3((qc3==3|qc3==4)&lon3<=lonsection+delta&lon3>=lonsection-delta))
            scatter(lat3((qc3==3|qc3==4)&lon3<=lonsection+delta&lon3>=lonsection-delta),...
                depth3((qc3==3|qc3==4)&lon3<=lonsection+delta&lon3>=lonsection-delta),...
                40,value3((qc3==3|qc3==4)&lon3<=lonsection+delta&lon3>=lonsection-delta),'ko');
        else
            scatter([nan],[nan],40,[nan],'ko');
        end
        hold on;
        h1 = plot(lat_g,-depth_g(lon_index,:),'k-','LineWidth',2);
        yt = yticks;
        yt_new = yt/1e3;
        yticks(yt);
        yticklabels(yt_new);
        if v==4|v==5|v==6
           yticks([0 2000 4000 6000]);
           yticklabels({'0','2','4','6'});
        else
           set(gca, 'YTicklabels',{}); 
        end

        set(gca, 'YDir', 'reverse','LineWidth', 2);
        ylim([-50 6500]);
        xlim([20 42]);
        caxis([range_caxis1(v),range_caxis2(v)]);
        set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold');
%         colormap('jet');
        set(gca, 'XTicklabels',{},'YDir', 'reverse','LineWidth', 2);
        
        subplot('Position', location(:,2,v));

        if ~isnan(lat3(qc3==3&lon3<=lonsection+delta&lon3>=lonsection-delta))
            scatter(lat3(qc3==3&lon3<=lonsection+delta&lon3>=lonsection-delta),...
                depth3(qc3==3&lon3<=lonsection+delta&lon3>=lonsection-delta),...
                40,value3(qc3==3&lon3<=lonsection+delta&lon3>=lonsection-delta),'bo');
        else
            scatter([nan],[nan],40,[nan],'bo');
        end
        hold on;
        h1 = plot(lat_g,-depth_g(lon_index,:),'k-','LineWidth',2);
        yt = yticks;
        yt_new = yt/1e3;
        yticks(yt);
        yticklabels(yt_new);
%         xlabel('Latitude (\circN)','FontSize',19);
        if v==4|v==5|v==6
           yticks([0 2000 4000 6000]);
           yticklabels({'0','2','4','6'});
           ylabel('Depth (km)','FontSize',19);
        else
           set(gca, 'YTicklabels',{}); 
        end
%         set(gcf, 'WindowState', 'maximized');
        set(gca, 'YDir', 'reverse','LineWidth', 2);
        ylim([-50 6500]);
        xlim([20 42]);
        caxis([range_caxis1(v),range_caxis2(v)]);
        set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold');
%         colormap('jet');
        set(gca, 'XTicklabels',{},'YDir', 'reverse','LineWidth', 2);
        
        subplot('Position', location(:,3,v));

        if ~isempty(value3(qc3==4&lon3<=lonsection+delta&lon3>=lonsection-delta&depth3>0))
            scatter(lat3(qc3==4&lon3<=lonsection+delta&lon3>=lonsection-delta&depth3>0),...
            depth3(qc3==4&lon3<=lonsection+delta&lon3>=lonsection-delta&depth3>0),...
            40,value3(qc3==4&lon3<=lonsection+delta&lon3>=lonsection-delta&depth3>0),'ro');
        else
            h2 = scatter([nan],[nan],40,[nan],'ro');
        end
        hold on;
        scatter(lat3(qc3==4&lon3<=lonsection+delta&lon3>=lonsection-delta&depth3<0),...
            depth3(qc3==4&lon3<=lonsection+delta&lon3>=lonsection-delta&depth3<0),...
            40,value3(qc3==4&lon3<=lonsection+delta&lon3>=lonsection-delta&depth3<0),'ro');
        hold on;
        plot(lat_g,-depth_g(lon_index,:),'k-','LineWidth',2);
        yt = yticks;
        yt_new = yt/1e3;
        yticks(yt);
        yticklabels(yt_new);
        if v==4|v==5|v==6
           yticks([0 2000 4000 6000]);
           yticklabels({'0','2','4','6'});
        else
           set(gca, 'YTicklabels',{}); 
        end
        if v==6|v==9|v==11|v==2
            pos=axis;
            xlabel('Latitude (\circN)','position',[pos(2)-14 1.4.*pos(4)],'FontSize',19);
        else
            set(gca, 'XTicklabels',{});
        end

        set(gca, 'YDir', 'reverse','LineWidth', 2);
        ylim([-50 6500]);
        xlim([20 42]);
        caxis([range_caxis1(v),range_caxis2(v)]);
        set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold');
%         colormap('jet');
        set(gca, 'YDir', 'reverse','LineWidth', 2);
        
        set(gca,'FontName','Times New Roman','FontWeight','bold','FontSize',20);
%         title(string(strcat(value_name(v),' at ',string(lonsection),'°E ')),'FontSize',19);
        cd 'E:\y-cc\RODECS\final_data_v4\qc3_depth_figure\vertical_figure';
        
    end
end
set(gcf, 'WindowState', 'maximized');

% ------------------------- latsection --------------------------------------
for v=1:12
    cd E:\y-cc\RODECS\final_data_v4\;
    disp(v);
    filename = filedir(v).name;
    load (filename);
    qc1 = RODECS_value123(1,:)';
    qc2 = RODECS_value123(2,:)';
    qc3 = RODECS_value123(3,:)';
    value3 = RODECS_value123(14,:)';   
    lon3 = RODECS_value123(9,:)';
    lat3 = RODECS_value123(10,:)';
    depth3 = RODECS_value123(11,:)';
% 
    for latsection = 23.08
        lat_index = find(abs(lat_g-latsection)==min(abs(lat_g-latsection)));
        delta = 0.01;
%         figure('Units','centimeters',...
%             'PaperType', 'A4',...
%             'PaperOrientation','landscape',...
%             'Position',[5 5 35 20],...
%             'PaperPosition',[5 5 28 20],...
%             'PaperUnits','centimeters')
       subplot('Position', [0.16, 0.75, 0.68, 0.24]);
        h0 = scatter([nan],[nan],150,[nan],'filled','s');
        hold on;
        if ~isnan(lon3((qc3==3|qc3==4)&lat3<=latsection+delta&lat3>=latsection-delta))
            scatter(lon3((qc3==3|qc3==4)&lat3<=latsection+delta&lat3>=latsection-delta),...
                depth3((qc3==3|qc3==4)&lat3<=latsection+delta&lat3>=latsection-delta),...
                150,value3((qc3==3|qc3==4)&lat3<=latsection+delta&lat3>=latsection-delta),'filled','s');
        else
            scatter([nan],[nan],150,[nan],'filled','s');
        end
        hold on;
        h1 = plot(lon_g,-depth_g(:,lat_index),'k-','LineWidth',2);
        yt = yticks;
        yt_new = yt/1e3;
        yticks(yt);
        yticklabels(yt_new);
%         xlabel('Latitude (\circN)','FontSize',19);
        ylabel('Depth (km)','FontSize',19);
        set(gcf, 'WindowState', 'maximized');
        set(gca, 'YDir', 'reverse','LineWidth', 2);
        ylim([-50 7000]);
        xlim([116 135]);
        caxis([range_caxis1(v),range_caxis2(v)]);
        set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold');
        colormap('jet');
        set(gca, 'YDir', 'reverse','LineWidth', 2);
        
        subplot('Position', [0.16, 0.44, 0.68, 0.24]);
        h0 = scatter([nan],[nan],150,[nan],'filled','o');
        hold on;
        if ~isnan(lon3(qc3==3&lat3<=latsection+delta&lat3>=latsection-delta))
            scatter(lon3(qc3==3&lat3<=latsection+delta&lat3>=latsection-delta),...
                depth3(qc3==3&lat3<=latsection+delta&lat3>=latsection-delta),...
                150,value3(qc3==3&lat3<=latsection+delta&lat3>=latsection-delta),'filled','o');
        else
            scatter([nan],[nan],150,[nan],'filled','o');
        end
        hold on;
        h1 = plot(lon_g,-depth_g(:,lat_index),'k-','LineWidth',2);
        yt = yticks;
        yt_new = yt/1e3;
        yticks(yt);
        yticklabels(yt_new);
%         xlabel('Latitude (\circN)','FontSize',19);
        ylabel('Depth (km)','FontSize',19);
        set(gcf, 'WindowState', 'maximized');
        set(gca, 'YDir', 'reverse','LineWidth', 2);
        ylim([-50 7000]);
        xlim([116 135]);
        caxis([range_caxis1(v),range_caxis2(v)]);
        set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold');
        colormap('jet');
        set(gca, 'YDir', 'reverse','LineWidth', 2);
        
        subplot('Position', [0.16, 0.15, 0.68, 0.24]);
        h2 = scatter([nan],[nan],150,[nan],'filled','p');
        hold on;
        if ~isempty(value3(qc3==4&lat3<=latsection+delta&lat3>=latsection-delta&depth3>0))
            scatter(lon3(qc3==4&lat3<=latsection+delta&lat3>=latsection-delta&depth3>0),...
            depth3(qc3==4&lat3<=latsection+delta&lat3>=latsection-delta&depth3>0),...
            150,value3(qc3==4&lat3<=latsection+delta&lat3>=latsection-delta&depth3>0),'filled','^');
        else
            h2 = scatter([nan],[nan],150,[nan],'filled','p');
        end
        hold on;
        scatter(lon3(qc3==4&lat3<=latsection+delta&lat3>=latsection-delta&depth3<0),...
            depth3(qc3==4&lat3<=latsection+delta&lat3>=latsection-delta&depth3<0),...
            150,value3(qc3==4&lat3<=latsection+delta&lat3>=latsection-delta&depth3<0),'filled','p');
        hold on;
        h1 = plot(lon_g,-depth_g(:,lat_index),'k-','LineWidth',2);
        yt = yticks;
        yt_new = yt/1e3;
        yticks(yt);
        yticklabels(yt_new);
        xlabel('Longitude (\circE)','FontSize',19);
        ylabel('Depth (km)','FontSize',19);
        set(gcf, 'WindowState', 'maximized');
        set(gca, 'YDir', 'reverse','LineWidth', 2);
        ylim([-50 7000]);
        xlim([116 135]);
        caxis([range_caxis1(v),range_caxis2(v)]);
        set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold');
        colormap('jet');
        set(gca, 'YDir', 'reverse','LineWidth', 2);
        
        
        c = colorbar('horiz'); % 
        set(c,'position',[0.2 0.035 0.6 0.03]);
        if v==4 
            str = sprintf(string(strcat(value_name1(v),'\n\')));
            set(get(c,'title'),'string',strcat(str,'(\circC)'),'position',[925 -24],'FontSize',19);
        else if v==5
                str = sprintf(string(strcat(value_name1(v),'\n(psu)')));
                set(get(c,'title'),'string',str,'position',[918.8 -24],'FontSize',19);
            else if v==11
                    str = sprintf(string(strcat(value_name1(v),'\n(μg/L)')));
                    set(get(c,'title'),'string',str,'position',[918.8 -24],'FontSize',19);
                else
                    str = sprintf(string(strcat(value_name1(v),'\n(μmol/L)')));
                    set(get(c,'title'),'string',str,'position',[918.8 -24],'FontSize',19);
                end
            end
        end
        set(gca,'FontName','Times New Roman','FontSize',19,'FontWeight','bold');
%         title(string(strcat(value_name(v),' at ',string(latsection),'°N ')),'FontSize',19);
    %
        cd 'E:\y-cc\RODECS\final_data_v4\qc3_depth_figure\vertical_figure';
        print(string(strcat(value_name(v),' at ',string(latsection),'°N.tif ')),'-dtiff','-r300');
        close
    end
end
%%
figure('Units','centimeters',...
        'PaperType', 'A4',...
        'PaperOrientation','landscape',...
        'Position',[1 5 38 18],...
        'PaperPosition',[5 5 12 8],...
        'PaperUnits','centimeters');
h0 = scatter([nan],[nan],150,[nan],'ko');
hold on;
h1 = plot([nan],[nan],'k-','LineWidth',2);
hold on;
h2 = scatter([nan],[nan],150,[nan],'bo');
hold on;
h3 = scatter([nan],[nan],150,[nan],'ro');
hold on;
h4 = scatter([nan],[nan],150,[nan],'filled','p');
% legend([h0,h1,h2,h3,h4],'original data','Bathymetry (GEBCO)','Pass value','Outliers below the seabed','Outliers above the sea surface',...
%     'Location','South','Box','off','NumColumns',2);   
legend([h0,h1,h2,h3,h4],'Original data','Bathymetry (GEBCO)','Passed data','Failed data',...
    'Location','South','Box','off','NumColumns',4);   
axis off;
colormap(jet);
set(gca,'FontName','Times New Roman','FontSize',10,'FontWeight','bold');
cd 'E:\y-cc\RODECS\final_data_v4\qc3_depth_figure\vertical_figure';
print('legend.tif','-dtiff','-r300');
close