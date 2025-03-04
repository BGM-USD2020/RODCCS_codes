clear
close
clc
filedir = dir('E:\y-cc\RODECS\final_data_v4\qc7*');
value_name = {'Phosphate','Chla','DIC','DOC','POC','Ammonium','Temperature','Salinity','DO','Silicate','Nitrate','Nitrite'};
value_comment = {'Phosphate concentration of seawater','Chlorophyll a concentration of seawater',...
    'Dissolved Inorganic Carbon (DIC) concentration of seawater',...
    'Dissolved Organic Carbon (DOC) concentration of seawater',...
    'Particulate Organic Carbon (POC) concentration of seawater',...
    'Ammonium concentration of seawater',...
    'Temperature of seawater','Salinity of seawater','Dissolved Oxygen concentration of seawater',...
    'Silicate concentration of seawater','Nitrate concentration of seawater','Nitrite concentration of seawater'};
value_unit = {'umol/L','ug/L','umol/L','umol/L','umol/L','umol/L','℃','psu','umol/L','umol/L','umol/L','umol/L'};

for v=1:12
    cd E:\y-cc\RODECS\final_data_v4\;
    disp(v);
    filename = filedir(v).name;
    load (filename);
    lon = RODECS_value123457(9,:)';
    lat = RODECS_value123457(10,:)';
    depth = RODECS_value123457(11,:)';
    year = RODECS_value123457(12,:)';
    month = RODECS_value123457(13,:)';
    day = RODECS_value123457(14,:)';
    time = RODECS_value123457(15,:)';
    id = RODECS_value123457(8,:)';
    qc1 = RODECS_value123457(1,:)';
    qc2 = RODECS_value123457(2,:)';
    qc3 = RODECS_value123457(3,:)';
    qc4 = RODECS_value123457(4,:)';
    qc5 = RODECS_value123457(5,:)';
    qc7 = RODECS_value123457(7,:)';
    value = RODECS_value123457(16,:)';
    
    depth(depth==-9) = nan;
    year(year<1900) = nan;
    month(month>12) = nan;
    year(year==9999) = nan;
    qc3(qc3==0) = 1;
    
    qc1(qc1==4) = 2;
    qc2(qc2==4) = 2;
    qc3(qc3==4) = 2;
    qc4(qc4==4) = 2;
    qc5(qc5==4) = 2;
    qc7(qc7==4) = 2;
    
    qc1(isnan(qc1)) = 1;
    qc2(isnan(qc2)) = 1;
    qc3(isnan(qc3)) = 1;
    qc4(isnan(qc4)) = 1;
    qc5(isnan(qc5)) = 1;
    qc7(isnan(qc7)) = 1;

    qc = qc1.*100000+qc3.*10000+qc4.*1000+qc5.*100+qc7.*10+qc2;
    
    if v~=7
        value(value<=0) = nan;
%     else
%         value(value==99) = nan;
    end
    lon_nc = lon(~isnan(value));
    lat_nc = lat(~isnan(value));
    depth_nc = depth(~isnan(value));
    year_nc = year(~isnan(value));
    month_nc = month(~isnan(value));
    day_nc = day(~isnan(value));
    time_nc = time(~isnan(value));
    id_nc = id(~isnan(value));
    qc_nc = qc(~isnan(value));
    value_nc = value(~isnan(value));

%
cd 'E:\y-cc\RODECS\final_data_v4\final_ncfile\';
ncid=netcdf.create(strcat('RODCCS_',string(value_name(v)),'.nc'),'netcdf4'); 
%define GLOBAL attributes

netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'),'title','Regional Ocean Database of East China Sea');
netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'),'Data_Source_ID','id1-Argo;id2-CCHDO;id3-Chlorophyll a in-situ data from NESSDC;id4-CoastDOM;id5-GLODAPv2;id6-R2R');
netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'),'Data_ID','The position id of data point');
netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'),'Quality_control_location','The quality control of sampling point location, and the result is represented by the digit in the hundred-thousands place of the QC variable');
netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'),'Quality_control_depth','The quality control of sampling point depth, and the result is represented by the digit in the ten-thousands place of the QC variable');
netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'),'Quality_control_constant','The quality control to detect the presence of outlier constant points, and the result is represented by the digit in the thousands place of the QC variable');
netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'),'Quality_control_value','The quality control of sampling point values, and the result is represented by the digit in the hundreds place of the QC variable');
netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'),'Quality_control_gradient','The quality control of sampling point depth gradient, and the result is represented by the digit in the tens place of the QC variable');
netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'),'Quality_control_time','The quality control of sampling point sampling time, and the result is represented by the digit in the ones place of the QC variable');
netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'),'latitude_units','degrees_north');
netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'),'longitude_units','degrees_east');

netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'),'geospatial_lat_min','20N');
netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'),'geospatial_lat_max','42N');
netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'),'geospatial_lon_min','116E');
netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'),'geospatial_lon_max','135E');
netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'),'geospatial_vertical_min','0');
netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'),'geospatial_vertical_max','7510');

%
% define the variable dimension
% dimid=netcdf.defDim(ncid,'data_source_id',6);

max_lon = max(lon_nc);
min_lon = min(lon_nc);
max_lat = max(lat_nc);
min_lat = min(lat_nc);
max_depth = max(depth_nc);
min_depth = min(depth_nc);
max_year = max(year_nc);
min_year = min(year_nc);
max_month = max(month_nc);
min_month = min(month_nc);
max_qc = max(qc_nc);
min_qc = min(qc_nc);
max_value = max(value_nc);
min_value = min(value_nc);
dimdatanumber=netcdf.defDim(ncid,'data_number',length(value_nc));
%     dimlat=netcdf.defDim(ncid,'latitude',2160);
%     dimtime=netcdf.defDim(ncid,'time',filenumber);
% end define the dimension
%
% define the variable and their attributes


varid1=netcdf.defVar(ncid,'Longitude','NC_DOUBLE',[dimdatanumber]);
netcdf.putAtt(ncid,varid1,'standard_name','longitude');
netcdf.putAtt(ncid,varid1,'units','degrees_east');
netcdf.putAtt(ncid,varid1,'_FillValue',nan);
netcdf.putAtt(ncid,varid1,'valid_min',min_lon);
netcdf.putAtt(ncid,varid1,'valid_max',max_lon);
netcdf.putAtt(ncid,varid1,'variable properties','common foundational information variable');


varid2=netcdf.defVar(ncid,'Latitude','NC_DOUBLE',[dimdatanumber]);
netcdf.putAtt(ncid,varid2,'standard_name','latitude');
netcdf.putAtt(ncid,varid2,'units','degrees_north');
netcdf.putAtt(ncid,varid2,'_FillValue',nan);
netcdf.putAtt(ncid,varid2,'valid_min',min_lat);
netcdf.putAtt(ncid,varid2,'valid_max',max_lat);
netcdf.putAtt(ncid,varid2,'variable properties','common foundational information variable');

varid3=netcdf.defVar(ncid,'Depth','NC_DOUBLE',[dimdatanumber]);
netcdf.putAtt(ncid,varid3,'standard_name','depth');
netcdf.putAtt(ncid,varid3,'units','m');
netcdf.putAtt(ncid,varid3,'_FillValue',nan);
netcdf.putAtt(ncid,varid3,'valid_min',min_depth);
netcdf.putAtt(ncid,varid3,'valid_max',max_depth);
netcdf.putAtt(ncid,varid3,'variable properties','common foundational information variable');

varid4=netcdf.defVar(ncid,'Year','NC_DOUBLE',[dimdatanumber]);
netcdf.putAtt(ncid,varid4,'standard_name','year');
netcdf.putAtt(ncid,varid4,'units','years');
netcdf.putAtt(ncid,varid4,'_FillValue',nan);
netcdf.putAtt(ncid,varid4,'valid_min',min_year);
netcdf.putAtt(ncid,varid4,'valid_max',max_year);%wcc
netcdf.putAtt(ncid,varid4,'variable properties','common foundational information variable');

varid5=netcdf.defVar(ncid,'Month','NC_DOUBLE',[dimdatanumber]);
netcdf.putAtt(ncid,varid5,'standard_name','month');
netcdf.putAtt(ncid,varid5,'units','months');
netcdf.putAtt(ncid,varid5,'_FillValue',nan);
netcdf.putAtt(ncid,varid5,'valid_min',min_month);
netcdf.putAtt(ncid,varid5,'valid_max',max_month);%wcc
netcdf.putAtt(ncid,varid5,'variable properties','common foundational information variable');

varid6=netcdf.defVar(ncid,'Day','NC_DOUBLE',[dimdatanumber]);
netcdf.putAtt(ncid,varid6,'standard_name','day');
netcdf.putAtt(ncid,varid6,'units','days');
netcdf.putAtt(ncid,varid6,'_FillValue',nan);
netcdf.putAtt(ncid,varid6,'valid_min',1);
netcdf.putAtt(ncid,varid6,'valid_max',31);%wcc
netcdf.putAtt(ncid,varid6,'variable properties','common foundational information variable');

varid7=netcdf.defVar(ncid,'Time','NC_DOUBLE',[dimdatanumber]);
netcdf.putAtt(ncid,varid7,'standard_name','sampling time');
netcdf.putAtt(ncid,varid7,'units','minute');
netcdf.putAtt(ncid,varid7,'_FillValue',nan);
netcdf.putAtt(ncid,varid7,'valid_min',0);
netcdf.putAtt(ncid,varid7,'valid_max',2400);%wcc
netcdf.putAtt(ncid,varid7,'variable properties','common foundational information variable');

varid8=netcdf.defVar(ncid,'QC flag','NC_DOUBLE',[dimdatanumber]);
netcdf.putAtt(ncid,varid8,'standard_name','quality control of sampling data point');
netcdf.putAtt(ncid,varid8,'units','xxxxxx, x equals 1 or 2 or 3');
netcdf.putAtt(ncid,varid8,'_FillValue',nan);
netcdf.putAtt(ncid,varid8,'valid_min',min_qc);
netcdf.putAtt(ncid,varid8,'valid_max',max_qc);
netcdf.putAtt(ncid,varid8,'variable properties','common foundational information variable');

varid9=netcdf.defVar(ncid,'Data Source ID','NC_DOUBLE',[dimdatanumber]);
netcdf.putAtt(ncid,varid9,'standard_name','Source of data point');
netcdf.putAtt(ncid,varid9,'units','constant');
netcdf.putAtt(ncid,varid9,'_FillValue',nan);
netcdf.putAtt(ncid,varid9,'valid_min',1);
netcdf.putAtt(ncid,varid9,'valid_max',6);
netcdf.putAtt(ncid,varid9,'variable properties','common foundational information variable');

varid10=netcdf.defVar(ncid,string(value_name(v)),'NC_DOUBLE',[dimdatanumber]);
netcdf.putAtt(ncid,varid10,'standard_name',string(value_comment(v)));
netcdf.putAtt(ncid,varid10,'units',string(value_unit(v)));
netcdf.putAtt(ncid,varid10,'_FillValue',nan);
netcdf.putAtt(ncid,varid10,'valid_min',min_value);
netcdf.putAtt(ncid,varid10,'valid_max',max_value);%wcc  
netcdf.putAtt(ncid,varid10,'variable properties','unique variable');

netcdf.endDef(ncid);


% write variables value to merged netcdf file

netcdf.putVar(ncid,varid1,lon_nc);
netcdf.putVar(ncid,varid2,lat_nc);
netcdf.putVar(ncid,varid3,depth_nc);
netcdf.putVar(ncid,varid4,year_nc);
netcdf.putVar(ncid,varid5,month_nc);
netcdf.putVar(ncid,varid6,day_nc);
netcdf.putVar(ncid,varid7,time_nc);
netcdf.putVar(ncid,varid9,id_nc);
netcdf.putVar(ncid,varid8,qc_nc);
netcdf.putVar(ncid,varid10,value_nc);

disp('well done');
netcdf.close(ncid);
end
