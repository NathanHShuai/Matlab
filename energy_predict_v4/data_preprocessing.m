clc
clear all
%%
load ('predictdata.mat')
predictdata = predictdataetrain(2:end,:);
data = table2array(predictdata);
time_charge = zeros(1);
for count = 1:size(data(:,2),1)
    time_s = data(count,2);
    time_e = data(count,3);
    timestring_s = num2str(time_s); %数字变成字符串
    timestring_e = num2str(time_e);
    
    year_s = str2double(timestring_s(1:4));
    month_s = str2double(timestring_s(5:6));
    day_s = str2double(timestring_s(7:8));
    hour_s = str2double(timestring_s(9:10));
    minute_s = str2double(timestring_s(11:12));
    second_s = str2double(timestring_s(13:14));
    
    year_e = str2double(timestring_e(1:4));
    month_e = str2double(timestring_e(5:6));
    day_e = str2double(timestring_e(7:8));
    hour_e = str2double(timestring_e(9:10));
    minute_e = str2double(timestring_e(11:12));
    second_e = str2double(timestring_e(13:14));
    
    tt_s = datenum(year_s,month_s,day_s,hour_s,minute_s,second_s)*24*3600;
    tt_e = datenum(year_e,month_e,day_e,hour_e,minute_e,second_e)*24*3600;
    t_charge = tt_e-tt_s;
    time_charge = [time_charge t_charge];
end
data(:,14) = time_charge(2:end)'; %完成充电时间计算（s），并存储于数组的第14列
for i=1:5
    if i==1
        row_index = data(:,1) == i;
        vehicle1 = data(row_index,:);
    elseif i==2
        row_index = data(:,1) == i;
        vehicle2 = data(row_index,:);
    elseif i==3
        row_index = data(:,1) == i;
        vehicle3 = data(row_index,:);
    elseif i==4
        row_index = data(:,1) == i;
        vehicle4 = data(row_index,:);
    else
        row_index = data(:,1) == i;
        vehicle5 = data(row_index,:);
    end
end
% 测试
% s1=size(data(:,1));
% s2=size(vehicle5(:,1))+size(vehicle4(:,1))+size(vehicle3(:,1))+size(vehicle2(:,1))+size(vehicle1(:,1));
% s1-s2
for j=1:5
    if j == 1
        vehicle1_all = vehicle1;
        [rownan,columnnan] = find(isnan(vehicle1)==1); %52
        [row0,column0] = find(vehicle1==-9999);
        rowall = [rownan ; row0];
        rowall = unique(rowall);
        vehicle1_invalid = vehicle1(rowall,:);
        vehicle1(rowall,:)=[];
    elseif j==2
        vehicle2_all = vehicle2;
        [rownan,columnnan] = find(isnan(vehicle2)==1); 
        [row0,column0] = find(vehicle2==-9999);
        rowall = [rownan ; row0];
        rowall = unique(rowall);
        vehicle2_invalid = vehicle2(rowall,:);
        vehicle2(rowall,:)=[];
    elseif j==3
        vehicle3_all = vehicle3;
        [rownan,columnnan] = find(isnan(vehicle3)==1); 
        [row0,column0] = find(vehicle3==-9999);
        rowall = [rownan ; row0];
        rowall = unique(rowall);
        vehicle3_invalid = vehicle3(rowall,:);
        vehicle3(rowall,:)=[];
    elseif j==4
        vehicle4_all = vehicle4;
        [rownan,columnnan] = find(isnan(vehicle4)==1); 
        [row0,column0] = find(vehicle4==-9999);
        rowall = [rownan ; row0];
        rowall = unique(rowall);
        vehicle4_invalid = vehicle4(rowall,:);
        vehicle4(rowall,:)=[];
    else
        vehicle5_all = vehicle5;
        [rownan,columnnan] = find(isnan(vehicle5)==1); 
        [row0,column0] = find(vehicle5==-9999);
        rowall = [rownan ; row0];
        rowall = unique(rowall);
        vehicle5_invalid = vehicle5(rowall,:);
        vehicle5(rowall,:)=[];
    end
end
% 数据说明
% vehicle1_all-车1所有数据；vehicle5_invalid-剔除的0和NAN无效数据；vehicle1-车1所有有效数据
% 1-vehicle_id
% 2-charge_start_time
% 3-charge_end_time
% 4-mileage
% 5-charge_start_soc
% 6-charge_end_soc
% 7-charge_start_U
% 8-charge_end_U
% 9-charge_start_I
% 10-charge_end_I
% 11-charge_max_temp
% 12-charge_min_temp
% 13-charge_energy
% 14-charge_time /s
%%
P=[vehicle1(:,4) vehicle1(:,5) vehicle1(:,6) vehicle1(:,7) vehicle1(:,8) vehicle1(:,9) vehicle1(:,10) vehicle1(:,11) vehicle1(:,12) vehicle1(:,14)]';
% P=P(:,2:164);
T = vehicle1(:,13)';
[p1,minp,maxp,t1,mint,maxt]=premnmx(P,T);
%创建网络
net=newff(minmax(P),[10,6,1],{'tansig','tansig','purelin'},'trainlm');
%设置训练次数
net.trainParam.epochs = 5000;
%设置收敛误差
net.trainParam.goal=0.0000001;
%训练网络
[net,tr]=train(net,p1,t1);

 
%输入数据
a=[vehicle1(:,4) vehicle1(:,5) vehicle1(:,6) vehicle1(:,7) vehicle1(:,8) vehicle1(:,9) vehicle1(:,10) vehicle1(:,11) vehicle1(:,12) vehicle1(:,14)]';
%将输入数据归一化
a=premnmx(a);
%放入到网络输出数据
b=sim(net,a);
%将得到的数据反归一化得到预测数据
c=postmnmx(b,mint,maxt);

for ii=1:size(c')
    de(ii) = (c(ii)-vehicle1(ii,13))/vehicle1(ii,13);
    ei(ii) = de(ii);
end
plot(ei,'r');
%%
% testtimecharge = time_charge(2:end)';
% z=find(testtimecharge==0);
% find(vehicle2(:,14)==0)
% find(time_charge==max(vehicle2(:,14)))
%%
save data_after_preprocessing