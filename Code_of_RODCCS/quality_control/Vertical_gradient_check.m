clear
close
clc
filedir = dir('E:\y-cc\RODECS\final_data_v4\qc5*');
cd E:\y-cc\RODECS\final_data_v4\;
load MGV2.mat;
MM = MGV;
value_name = {'DOC','POC','NH4','Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC'};
h = [11,12,7,1,2,3,4,5,6,8,9,10];
o2_filename = 'E:\y-cc\WoaSodachla_data\WOA2013_crocoData\WOA2013\oxygen\woa13_all_o00_01.nc';
temp_filename = 'E:\y-cc\WoaSodachla_data\WOA2013_crocoData\WOA2013\temperature\woa13_decav_t00_01.nc';
salt_filename = 'E:\y-cc\WoaSodachla_data\WOA2013_crocoData\WOA2013\salinity\woa13_decav_s00_01.nc';
si_filename = 'E:\y-cc\WoaSodachla_data\WOA2013_crocoData\WOA2013\silicate\woa13_all_i00_01.nc';
no3_filename = 'E:\y-cc\WoaSodachla_data\WOA2013_crocoData\WOA2013\nitrate\woa13_all_n00_01.nc';
po4_filename = 'E:\y-cc\WoaSodachla_data\WOA2013_crocoData\WOA2013\phosphate\woa13_all_p00_01.nc';

for v=1:12
    disp(v);
    filename = filedir(v).name;
    load (filename);
    lon3 = RODECS_value12345(9,:)';
    lat3 = RODECS_value12345(10,:)';
    depth3 = RODECS_value12345(11,:)';
    month3 = RODECS_value12345(13,:)';
    id3 = RODECS_value12345(8,:)';
    qc1 = RODECS_value12345(1,:)';
    qc3 = RODECS_value12345(3,:)';
    qc5 = RODECS_value12345(5,:)';
    qc4 = RODECS_value12345(4,:)';
    value3 = RODECS_value12345(16,:)';
    qc73(1:length(value3)) = nan;
    
    location_index = find(qc1==3&qc3==3&qc4==3&qc5==3);
    lon2 = lon3(location_index);
    lat2 = lat3(location_index);
    depth2 = depth3(location_index);
    month2 = month3(location_index);  
    id2 = id3(location_index); 
    value2 = value3(location_index);
    qc72(1:length(value2)) = nan;
    if v~=4
       value2(value2<=0) = nan; %salt o2 Si no3 no2 po4 Chla
    end
    lon = lon2(~isnan(value2));
    lat = lat2(~isnan(value2));
    depth = depth2(~isnan(value2));
    value = value2(~isnan(value2));
    month = month2(~isnan(value2));
    id = id2(~isnan(value2));
    qc7(1:length(value),1) = 1;
    gradient_f(1:length(value),1) = nan;
    jvalue(1:length(value),1) = nan;
    outliers(1) = nan;
% -------------------------------------------------------------------------
    if v==4
        woafile = temp_filename;
        valuename1 = 't_an';
        valuename2 = 't_sd';
    end
    if v==5
        woafile = salt_filename;
        valuename1 = 's_an';
        valuename2 = 's_sd';
    end
    if v==6
        woafile = o2_filename;
        valuename1 = 'o_an';
        valuename2 = 'o_sd';
    end
    if v==7
        woafile = si_filename;
        valuename1 = 'i_an';
        valuename2 = 'i_sd';
    end
    if v==8
        woafile = no3_filename;
        valuename1 = 'n_an';
        valuename2 = 'n_sd';
    end
    if v==10
        woafile = po4_filename;
        valuename1 = 'p_an';
        valuename2 = 'p_sd';
    end
% -------------------------------------------------------------------------    
if v==4|v==5|v==6|v==7|v==8|v==10
    woa_lon = ncread(woafile,'lon');
    woa_lon = woa_lon(180+110:180+140);
    woa_lat = ncread(woafile,'lat');
    woa_lat = woa_lat(90+15:90+45);
    woa_depth = ncread(woafile,'depth');
    if v==6
       woa_value_m = ncread(woafile,valuename1).*44.66;
       woa_value_s = ncread(woafile,valuename2).*44.66;
    else
       woa_value_m = ncread(woafile,valuename1);
       woa_value_s = ncread(woafile,valuename2);
    end
    woa_value_s = woa_value_s(180+110:180+140,90+15:90+45,:);
    woa_value_m = woa_value_m(180+110:180+140,90+15:90+45,:);
    [woalon,woalat,woadepth] = meshgrid(woa_lon,woa_lat,woa_depth);
    woalon = permute(woalon,[2,1,3]);
    woalat = permute(woalat,[2,1,3]);
    woadepth = permute(woadepth,[2,1,3]);
    non_nan_indices = find(~isnan(woa_value_m));
    woalon_nonnan = woalon(non_nan_indices);
    woalat_nonnan = woalat(non_nan_indices);
    woadepth_nonnan = woadepth(non_nan_indices);
    woavalue_nonnan = woa_value_m(non_nan_indices);
    woavalue_new = griddata(double(woalon_nonnan),double(woalat_nonnan),double(woadepth_nonnan),woavalue_nonnan,...
        double(woalon),double(woalat),double(woadepth),'nearest');
    
    n = 1;
    ll = 1;
    while n<=length(value)
    disp(n)           
    % ------------------------------------------------------------   
    for k = n+1:length(value)
        if abs(lon(k)-lon(n))>0.001|abs(lat(k)-lat(n))>0.001
            break
        end
    end

        if depth(n)>depth(k-1)
            maxd = n;
            mind = k-1;
        else
            maxd = k-1;
            mind = n;
        end

        if maxd<mind
            deltai = -1;
        else
            deltai = 1;
        end


    if abs(maxd-mind)>=10
        for p=mind:deltai:maxd
            [~,indexlon] = min(abs(woa_lon-lon(p))); 
            [~,indexlat] = min(abs(woa_lat-lat(p)));
            if v==5
                woa_value_l = 0.8.*squeeze(woavalue_new(indexlon,indexlat,:));
                woa_bound_l = interp1(woa_depth,woa_value_l,depth(p),'pchip');
                woa_value_u = 1.2.*squeeze(woavalue_new(indexlon,indexlat,:));            
                woa_bound_u = interp1(woa_depth,woa_value_u,depth(p),'pchip');
            else if v==6
                woa_value_l = 0.6.*squeeze(woavalue_new(indexlon,indexlat,:));
                woa_bound_l = interp1(woa_depth,woa_value_l,depth(p),'pchip');
                woa_value_u = 1.4.*squeeze(woavalue_new(indexlon,indexlat,:));            
                woa_bound_u = interp1(woa_depth,woa_value_u,depth(p),'pchip');
            else
                woa_value_l = 0.*squeeze(woavalue_new(indexlon,indexlat,:));
                woa_bound_l = 0;
                woa_value_u = 2.*squeeze(woavalue_new(indexlon,indexlat,:));            
                woa_bound_u = interp1(woa_depth,woa_value_u,depth(p),'pchip');
                end
            end
            
            
            
            if value(p)>=woa_bound_l&value(p)<=woa_bound_u
                break
            end
        end
        if value(p)>=woa_bound_l&value(p)<=woa_bound_u
           qc7(p) = 3;
        else
           qc7(p) = 4;
        end
        if p~=mind
           qc7(mind:deltai:p-deltai) = 4; 
        end
        
        for b = p+deltai:deltai:maxd
            if abs(depth(b)-depth(p))>=10
                break
            end
        end
        
        for i=b:deltai:maxd
    % -----------------------------------------------------------
        for j = i-deltai:-deltai:p
            if qc7(j)==3&abs(depth(j)-depth(i))>=10
                break
            end
        end

                jvalue(i) = j;
                gradient_f(i,1) = (value(j)-value(i))./(depth(j)-depth(i));
           if depth(i)<=400
                % -------------------------------------------------------------------------  %calculate the bounds by different delta depth  
                bounds = MM(h(v),1);
                % -------------------------------------------------------------------------
                if abs((value(j)-value(i))./(depth(j)-depth(i)))<=bounds
                    qc7(i) = 3;
                else
                    qc7(i) = 4;
                end
           else
                % -------------------------------------------------------------------------  %calculate the bounds by different delta depth 
                bounds = MM(h(v),2);
                % -------------------------------------------------------------------------
                if abs((value(j)-value(i))./(depth(j)-depth(i)))<=bounds
                    qc7(i) = 3;
                else
                    qc7(i) = 4;
                end
           end

      clear j;


        end

     if deltai==-1
         if max(qc7(mind:maxd))==4
             olen = length(qc7(mind:maxd));
             outliers(ll:ll+olen-1,1) = lon(mind:maxd);
             outliers(ll:ll+olen-1,2) = lat(mind:maxd);
             outliers(ll:ll+olen-1,3) = depth(mind:maxd);
             outliers(ll:ll+olen-1,4) = value(mind:maxd);
             outliers(ll:ll+olen-1,5) = gradient_f(mind:maxd);
             outliers(ll:ll+olen-1,6) = qc7(mind:maxd);
             outliers(ll:ll+olen-1,7) = [mind:maxd];
             outliers(ll:ll+olen-1,8) = jvalue(mind:maxd);
             ll = olen+ll;
         end
     else
         if max(qc7(maxd:mind))==4
             olen = length(qc7(maxd:mind));
             outliers(ll:ll+olen-1,1) = lon(maxd:mind);
             outliers(ll:ll+olen-1,2) = lat(maxd:mind);
             outliers(ll:ll+olen-1,3) = depth(maxd:mind);
             outliers(ll:ll+olen-1,4) = value(maxd:mind);
             outliers(ll:ll+olen-1,5) = gradient_f(maxd:mind);
             outliers(ll:ll+olen-1,6) = qc7(maxd:mind);
             outliers(ll:ll+olen-1,7) = [maxd:mind];
             outliers(ll:ll+olen-1,8) = jvalue(maxd:mind);
             ll = ll+olen;
         end
     end
     
     end
        n = k;
    end    
end
 qc72(~isnan(value2)) = qc7;

 qc73(location_index) = qc72;

 num_qc7(1,h(v)) = length(value);
 num_qc7(2,h(v)) = length(value(qc7==3));
 num_qc7(3,h(v)) = length(value(qc7==4));
 num_qc7(4,h(v)) = length(value(qc7==1));
 
RODECS_value123457(1:16,:) = RODECS_value12345(1:16,:);
RODECS_value123457(7,:) = qc73;
%  qc7_all(v,1:length(qc73)) = qc73;
 clear qc7;
 clear gradient_b;
 clear gradient_f;
 clear qc71;
 clear qc72;
 clear qc73;
 save(strcat('E:\y-cc\RODECS\final_data_v4\qc7_',string(v),'RODECS123457_',string(value_name(v)),'.mat'),'RODECS_value123457');
 if ~isnan(outliers)
    save(strcat('E:\y-cc\RODECS\final_data_v4\qc7_',string(v),'_',string(value_name(v)),'outliers.mat'),'outliers');
 end
 clear outliers;
end