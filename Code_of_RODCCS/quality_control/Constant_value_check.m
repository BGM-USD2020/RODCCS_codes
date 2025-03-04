clear
close
clc

filedir = dir('E:\y-cc\RODECS\final_data_v4\qc3_*');
cd E:\y-cc\RODECS\final_data_v4\;
value_name = {'DOC','POC','NH4','Temp','Salt','O2','Si','NO3','NO2','PO4','Chla','DIC'};
h = [10 11 12 1 2 3 4 5 6 7 8 9];
% ------------------------- constant --------------------------------------
for v=1:12
    disp(v);
    filename = filedir(v).name;
    load (filename);
    qc1 = RODECS_value123(1,:)';
    qc2 = RODECS_value123(2,:)';
    qc3 = RODECS_value123(3,:)';
    value3 = RODECS_value123(16,:)';   
    
    location_index = find(qc1==3&qc3==3);
    
    value2 = value3(location_index);
    if v>1
       value2(value2<=0) = nan; 
    end
    value1 = value2(~isnan(value2));
    
    for n = 2:length(value1)
        if value1(n) == value1(n-1)
            if n > 2 && value1(n-1) == value1(n-2)
                qc41(n-2) = 4;
                qc41(n-1) = 4;
                qc41(n) = 4;
            else
                qc41(n) = 3;
            end
        else
            qc41(n) = 3;
        end
    end

    if value1(1) == value1(2)&value1(1) == value1(3)
        qc41(1) = 4;
    else
        qc41(1) = 3;
    end
    qc42 = ones(length(value2),1);
    qc42(~isnan(value2)) = qc41;
    qc4 = ones(length(value3),1);
    qc4(location_index) = qc42;
    qc4_all(v,1:length(qc4)) = qc4;
    
    RODECS_value1234(1:16,:) = RODECS_value123(1:16,:);
    RODECS_value1234(4,:) = qc4;

    save(strcat('E:\y-cc\RODECS\final_data_v4\qc4_',string(h(v)),'RODECS1234_',string(value_name(v)),'.mat'),'RODECS_value1234');
 
    clear qc4;
    clear qc41;
    clear qc42;
    num_value(v) = length(value1);
end