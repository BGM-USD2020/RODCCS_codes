% =================================================================================
%
% argo_profile_read_matlab2008bplus
%                         reads some of the variables contained in an
%                         Argo NetCDF profile file. See
%                         reference:
%                         "Argo User's manual" available on
%                         http://www.argodatamgt.org/Documentation
%
% AUTHOR:                M. Scanderbeg
%
% REQUIRES:              Matlab2008b or higher which offers native NetCDF
%                        support
%            
%
% EXAMPLE:               file_name='D5900400_014.nc';
%
%                        [latitude,longitude,positioning_system,position_qc,juld_location,...
%                           juld,juldqc,pressure,pres_raw,pres_qc_raw,pres_qc,pressure_error,...
%                           pres_units, pres_fillvalue,temperature,temp_raw,temp_qc_raw,temp_qc,...
%                           temperature_error,temp_units,temp_fillvalue...
%                           salinity,psal_raw,psal_qc_raw,psal_qc,salinity_error,psal_units,psal_fillvalue...
%                           platform_number,cycle_number,data_type,format_version,project_name,...
%                           pi_name,direction,data_centre,data_state_indicator,data_mode,...
%                           dc_reference,platform_type,wmo_inst_type,station_parameters,...
%                           reference_date_time,vertical_sampling,config_mission_number]=...
%                           argo_profile_read_matlab2008bplus(file_name);
%
%
% SEE ALSO:              plot_latest_TS_profile.m, plot_contour.m.      
% 
clear
clc
close
path = 'D:\y-cc\y-cc\argo\kordi\';
namelist = dir([path,'*.nc']);
l = length(namelist);
for i=1:l
    file_name = namelist(i).name;
    p = num2str(file_name);
%     path1 = (['D:\y-cc\y-cc\OXY\argo_data\',p(1:7),'\']);
path1 = 'E:\y-cc\COMD\Argo\';
% ================================================================================

% function [latitude,longitude,reference_date_time,date_update,platform_number,project_name,pi_name,...
%     station_parameters,cycle_number,direction,data_centre,parameter_data_mode,platform_type,...
%     float_serial_no,firmware_version,wmo_inst_type,oxygen,doxy_dpres,doxy_raw,doxy_qc_raw,...
%     doxy_qc,doxy_error,juld,juld_qc,juld_location,...
%     positioning_system,config_mission_number,data_type,format_version,handbook_version,...
%     parameter,scientific_calib_coefficient,scientific_calib_comment,scientific_calib_date,profile_pres_qc,...
%     profile_temp_qc,profile_doxy_qc,pressure,pres_raw,pres_qc_raw,pres_qc,pres_error,...
%     temp,temp_qc,temp_dpres,temp_adjusted,temp_adjusted_qc,temp_adjusted_error,...
%     salinity,psal_raw,psal_dpres,psal_qc_raw,psal_qc,psal_error]=...
%     argo_profile_read_matlab2008bplus_oxy(file_name);

latitude=[];
longitude=[];
date_update=[];
parameter_data_mode=[];
platform_type=[];
float_serial_no=[];
firmware_version=[];
positioning_system=[];
parameter=[];
scientific_calib_coefficient=[];
scientific_calib_comment=[];
scientific_calib_date=[];
profile_pres_qc=[];
profile_temp_qc=[];
profile_doxy_qc=[];
juld_location=[];
juld=[];
juld_qc=[];
pressure=[];
pres_raw=[];
pres_qc_raw=[];
pres_qc=[];
pres_error = [];
oxygen=[];
doxy_dpres=[];
doxy_raw=[];
doxy_qc_raw=[];
doxy_qc=[];
doxy_error=[];
temp=[];
temp_adjusted=[];
temp_dpres=[];
temp_qc=[];
temp_adjusted_error=[];
temp_adjusted_qc=[];
salinity=[];
psal_raw=[];
psal_dpres=[];
psal_qc_raw=[];
psal_error=[];
psal_qc=[];
platform_number=[];
data_type=[];
format_version=[];
reference_date_time=[];
project_name=[];
pi_name=[];
cycle_number=[];
direction=[];
data_centre =[];
wmo_inst_type=[];
station_parameters = [];
config_mission_number = [];
handbook_version = [];




 fidh= netcdf.open(file_name, 'nowrite');  % Open NetCDF file
      

   
    thedim=netcdf.inqDimID(fidh,'N_PROF');
   [dimname,nprof] = netcdf.inqDim(fidh,thedim);



%Reads genaral informations
%============================
thevar = netcdf.inqVarID(fidh,'LATITUDE');
latitude   = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'LONGITUDE');
longitude   = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'PROFILE_PRES_QC');
profile_pres_qc = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'PROFILE_TEMP_QC');
profile_temp_qc = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'PROFILE_DOXY_QC');
profile_doxy_qc = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'POSITIONING_SYSTEM');
positioning_system = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'JULD_LOCATION');
juld_location = netcdf.getVar(fidh,thevar);

thevar = netcdf.inqVarID(fidh,'REFERENCE_DATE_TIME');
reference_date_time = netcdf.getVar(fidh,thevar);

dayref=datenum(sscanf(reference_date_time(1:4),'%f'),...
	    sscanf(reference_date_time(5:6),'%f'),sscanf(reference_date_time(7:8),'%f'),0,0,0);

thevar = netcdf.inqVarID(fidh,'JULD');    
juld = netcdf.getVar(fidh,thevar)+dayref;
thevar = netcdf.inqVarID(fidh,'JULD_QC');
juld_qc = netcdf.getVar(fidh,thevar);

thevar = netcdf.inqVarID(fidh,'DATA_TYPE');    
data_type   = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'FORMAT_VERSION');
format_version = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'PROJECT_NAME');
project_name   = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'PI_NAME');
pi_name   = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'PLATFORM_NUMBER');
platform_number  = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'CYCLE_NUMBER');
cycle_number  = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'DIRECTION');
direction  = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'DATA_CENTRE');
data_centre  = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'PLATFORM_TYPE');
platform_type  = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'WMO_INST_TYPE');
wmo_inst_type  = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'STATION_PARAMETERS');
station_parameters = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'CONFIG_MISSION_NUMBER');
config_mission_number = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'DATE_UPDATE');
date_update = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'PARAMETER_DATA_MODE');
parameter_data_mode = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'FLOAT_SERIAL_NO');
float_serial_no = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'FIRMWARE_VERSION');
firmware_version = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'PARAMETER');
parameter = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'SCIENTIFIC_CALIB_COEFFICIENT');
scientific_calib_coefficient = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'SCIENTIFIC_CALIB_COMMENT');
scientific_calib_comment = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'SCIENTIFIC_CALIB_DATE');
scientific_calib_date = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'HANDBOOK_VERSION');
handbook_version = netcdf.getVar(fidh,thevar);

%Reads measurements
%======================

%PRESSURE
thevar = netcdf.inqVarID(fidh,'PRES');
pres_raw = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'PRES_QC');
pres_qc_raw = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'PRES_ADJUSTED');
pressure = netcdf.getVar(fidh,thevar);
pres_fillvalue = netcdf.getAtt(fidh,thevar,'_FillValue');
pres_units = netcdf.getAtt(fidh,thevar,'units');
thevar = netcdf.inqVarID(fidh,'PRES_ADJUSTED_QC');
pres_qc = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'PRES_ADJUSTED_ERROR');
pres_error = netcdf.getVar(fidh,thevar);
inok = find(pressure==pres_fillvalue);
% if the pressure hasn't been adjusted, use the raw pressure
if ~isempty(inok)
  %pressure(inok)=pres_raw;
  pressure(inok)=pres_raw(inok);
  pres_qc=pres_qc_raw;
end

%Selection of measurements with QC=1 or QC=2 or QC=5
inok =find(double(pres_qc)~= double('1') &...
	   double(pres_qc)~= double('2') & ...
	   double(pres_qc)~= double('5'));
if ~isempty(inok)
  oxygen(inok)=NaN;
end


%OXYGEN
thevar = netcdf.inqVarID(fidh,'DOXY');
doxy_raw = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'DOXY_QC');
doxy_qc_raw = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'DOXY_ADJUSTED');
oxygen = netcdf.getVar(fidh,thevar);
doxy_fillvalue = netcdf.getAtt(fidh,thevar,'_FillValue');
doxy_units = netcdf.getAtt(fidh,thevar,'units');
thevar = netcdf.inqVarID(fidh,'DOXY_ADJUSTED_QC');
doxy_qc = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'DOXY_ADJUSTED_ERROR');
doxy_error = netcdf.getVar(fidh,thevar);
inok = find(oxygen==doxy_fillvalue);
% if the oxy hasn't been adjusted, use the raw oxy
if ~isempty(inok)
  oxygen(inok)=doxy_raw;
  doxy_qc=doxy_qc_raw;
end

%Selection of measurements with QC=1 or QC=2 or QC=5
inok =find(double(doxy_qc)~= double('1') &...
	   double(doxy_qc)~= double('2') & ...
	   double(doxy_qc)~= double('5'));
if ~isempty(inok)
  oxygen(inok)=NaN;
end

%TEMP
thevar = netcdf.inqVarID(fidh,'TEMP');
temp_raw = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'TEMP_QC');
temp_qc_raw = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'TEMP_ADJUSTED');
temp = netcdf.getVar(fidh,thevar);
temp_fillvalue = netcdf.getAtt(fidh,thevar,'_FillValue');
temp_units = netcdf.getAtt(fidh,thevar,'units');
thevar = netcdf.inqVarID(fidh,'TEMP_ADJUSTED_QC');
temp_qc = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'TEMP_ADJUSTED_ERROR');
temp_error = netcdf.getVar(fidh,thevar);
inok = find(oxygen==doxy_fillvalue);
% if the oxy hasn't been adjusted, use the raw oxy
if ~isempty(inok)
  temp(inok)=temp_raw;
  temp_qc=temp_qc_raw;
end

%Selection of measurements with QC=1 or QC=2 or QC=5
inok =find(double(temp_qc)~= double('1') &...
	   double(temp_qc)~= double('2') & ...
	   double(temp_qc)~= double('5'));
if ~isempty(inok)
  temp(inok)=NaN;
end


%SALINITY
thevar = netcdf.inqVarID(fidh,'PSAL');
psal_raw = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'PSAL_QC');
psal_qc_raw = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'PSAL_ADJUSTED');
salinity = netcdf.getVar(fidh,thevar);
psal_fillvalue = netcdf.getAtt(fidh,thevar,'_FillValue');
psal_units = netcdf.getAtt(fidh,thevar,'units');
thevar = netcdf.inqVarID(fidh,'PSAL_ADJUSTED_QC');
psal_qc = netcdf.getVar(fidh,thevar);
thevar = netcdf.inqVarID(fidh,'PSAL_ADJUSTED_ERROR');
psal_error = netcdf.getVar(fidh,thevar);
inok = find(salinity==psal_fillvalue);
% if the psal hasn't been adjusted, use the raw psal
if ~isempty(inok)
  salinity(inok)=psal_raw(inok);
  psal_qc=psal_qc_raw;
end

%Selection of measurements with QC=1 or QC=2 or QC=5
inok =find(double(psal_qc)~= double('1') &...
	   double(psal_qc)~= double('2') & ...
	   double(psal_qc)~= double('5'));
if ~isempty(inok)
  salinity(inok)=NaN;
end

 

   netcdf.close(fidh);



%if T not defined => P and S not defined
inok = find(~isfinite(oxygen));
if ~isempty(inok)
  pressure(inok)=NaN;
  if ~isempty(salinity)
    salinity(inok)=NaN;
  end
end


iok=find(isfinite(oxygen));
if isempty(iok)
  fprintf('%s\n',...
	  [' no validated (with QC=1 or QC=2 or QC=5) oxygen measurements in this file']);
end

iok=find(isfinite(salinity));
if isempty(iok)
  fprintf('%s\n',...
	    [' no validated (existing or with QC=1 or QC=2 or QC=5) salinity measurements in this file ']);
end
% end
save ([path1,[p(1:7),'temp.mat']],'temp');
save ([path1,[p(1:7),'juld.mat']],'juld');
save ([path1,[p(1:7),'lon.mat']],'longitude');
save ([path1,[p(1:7),'lat.mat']],'latitude');
save ([path1,[p(1:7),'salt.mat']],'salinity');
save ([path1,[p(1:7),'oxy.mat']],'oxygen');
save ([path1,[p(1:7),'pre.mat']],'pressure');
end