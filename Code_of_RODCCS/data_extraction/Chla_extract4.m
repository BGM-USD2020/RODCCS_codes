clear
close
clc
filename = './2013叶绿素提交.xlsx';
data = importdata(filename,'叶绿素采样测定');
data2 = importdata(filename,'站位信息');
site1 = string(data2.textdata.x0x7AD90x4F4D0x4FE10x606F(2:end,1));
chladata1 = data.data.x0x53F60x7EFF0x7D200x91C70x68370x6D4B0x5B9A;
stationtime1 = data.textdata.x0x53F60x7EFF0x7D200x91C70x68370x6D4B0x5B9A(2:end,1:2);
cite1 = data.data.x0x7AD90x4F4D0x4FE10x606F;
% stationtime1(335:338,1:2) = {' '};
n = 1;
for f=1:size(chladata1,1)
    if ~isnan(chladata1(f,1))
        lastNonNaN1 = chladata1(f,1);
        lastNonNaN2 = string(stationtime1(f,2));
        datePart = strsplit(lastNonNaN2, '.');
        A = find(strcmpi(site1,string(stationtime1(f,1))));
        if isempty(A)
            prefixLength = length(string(stationtime1(f,1)));
            B = find(cellfun(@(x) strncmpi(x, string(stationtime1(f,1)), prefixLength), site1));
            cite = cite1(B(1),:);
        else
            cite = cite1(A,:);
        end
        n = n+1;
    end
    if isnan(chladata1(f,1))
        % If the current element is NaN, replace it with lastNonNaN
        chladata(f,7) = floor(lastNonNaN1.*24).*100+(lastNonNaN1.*24-floor(lastNonNaN1.*24)).*60;
        chladata(f,4) = str2num(datePart(1));
        chladata(f,5) = str2num(datePart(2));
        chladata(f,6) = str2num(datePart(3));
        chladata(f,1) = cite(1);
        chladata(f,2) = cite(2);
        chladata(f,3) = chladata1(f,2);
        chladata(f,8) = chladata1(f,3);
    else
        chladata(f,7) = floor(chladata1(f,1).*24).*100+(chladata1(f,1).*24-floor(chladata1(f,1).*24)).*60;
        chladata(f,4) = str2num(datePart(1));
        chladata(f,5) = str2num(datePart(2));
        chladata(f,6) = str2num(datePart(3));
        chladata(f,1) = cite(1);
        chladata(f,2) = cite(2);
        chladata(f,3) = chladata1(f,2);
        chladata(f,8) = chladata1(f,3);
    end
end
YE103 = chladata';