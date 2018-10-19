clc
clear all
%%
load ('test.mat')
%for testA
testA = testA(2:end,:);
data_test = table2array(testA);
time_charge = zeros(1);
for count = 1:size(data_test(:,2),1)
    time_s = data_test(count,2);
    time_e = data_test(count,3);
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
data_test(:,13) = time_charge(2:end)';
data_test(:,14) = time_charge(2:end)'; %完成充电时间计算（s），并存储于数组的第14列
for i=1:5
    if i==1
        row_index = data_test(:,1) == i;
        vehicle1 = data_test(row_index,:);
    elseif i==2
        row_index = data_test(:,1) == i;
        vehicle2 = data_test(row_index,:);
    elseif i==3
        row_index = data_test(:,1) == i;
        vehicle3 = data_test(row_index,:);
    elseif i==4
        row_index = data_test(:,1) == i;
        vehicle4 = data_test(row_index,:);
    else
        row_index = data_test(:,1) == i;
        vehicle5 = data_test(row_index,:);
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
        [row0,column0] = find(vehicle1==0);
        rowall = [rownan ; row0];
        rowall = unique(rowall);
        vehicle1_invalid = vehicle1(rowall,:);
        vehicle1(rowall,:)=[];
    elseif j==2
        vehicle2_all = vehicle2;
        [rownan,columnnan] = find(isnan(vehicle2)==1); 
        [row0,column0] = find(vehicle2==0);
        rowall = [rownan ; row0];
        rowall = unique(rowall);
        vehicle2_invalid = vehicle2(rowall,:);
        vehicle2(rowall,:)=[];
    elseif j==3
        vehicle3_all = vehicle3;
        [rownan,columnnan] = find(isnan(vehicle3)==1); 
        [row0,column0] = find(vehicle3==0);
        rowall = [rownan ; row0];
        rowall = unique(rowall);
        vehicle3_invalid = vehicle3(rowall,:);
        vehicle3(rowall,:)=[];
    elseif j==4
        vehicle4_all = vehicle4;
        [rownan,columnnan] = find(isnan(vehicle4)==1); 
        [row0,column0] = find(vehicle4==0);
        rowall = [rownan ; row0];
        rowall = unique(rowall);
        vehicle4_invalid = vehicle4(rowall,:);
        vehicle4(rowall,:)=[];
    else
        vehicle5_all = vehicle5;
        [rownan,columnnan] = find(isnan(vehicle5)==1); 
        [row0,column0] = find(vehicle5==0);
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
% 13=14
% 14-charge_time /s
%%
%vehicle2
% load('energy_veh2.mat')
% clear P T p1 minp maxp t1 mint maxt vehicle vehicle1 vehicle2 vehicle3 vehicle4
% clear vehicle5 vehicle1_all vehicle2_all vehicle3_all vehicle4_all vehicle5_all
% vehicle = data_test(5:7,:);
% %输入数据
% AA = [vehicle(:,4) vehicle(:,5) vehicle(:,6) vehicle(:,7) vehicle(:,8) vehicle(:,9) vehicle(:,10) vehicle(:,11) vehicle(:,12) vehicle(:,14)]';
% 
% %将输入数据归一化,PS1
% AA=mapminmax('apply',AA,PS1);
% %放入到网络输出数据
% % 当前模型为net
% load('net_vehicle2_003_best.mat')
% % load('net_vehicle2_006.mat')
% BB=sim(net,AA);
% %将得到的数据反归一化得到预测数据,PS2
% C_testA_veh2=mapminmax('reverse',BB,PS2);
% C_testA_veh2'
%%
%vehicle3
load('energy_veh3_tan1.mat')
clear P T p1 minp maxp t1 mint maxt vehicle vehicle1 vehicle2 vehicle3 vehicle4
clear vehicle5 vehicle1_all vehicle2_all vehicle3_all vehicle4_all vehicle5_all
vehicle = data_test(8:12,:);
%输入数据
AA = [vehicle(:,4) vehicle(:,5) vehicle(:,6) vehicle(:,7) vehicle(:,8) vehicle(:,9) vehicle(:,10) vehicle(:,11) vehicle(:,12) vehicle(:,14)]';

%将输入数据归一化,PS1
AA=mapminmax('apply',AA,PS1);
%放入到网络输出数据
% 当前模型为net
load('net_vehicle3_105.mat')
% load('net_vehicle2_006.mat')
BB=sim(net,AA);
%将得到的数据反归一化得到预测数据,PS2
C_testA_veh3=mapminmax('reverse',BB,PS2);
C_testA_veh3'
%%
% %vehicle4
% load('energy_veh4.mat')
% clear P T p1 minp maxp t1 mint maxt vehicle vehicle1 vehicle2 vehicle3 vehicle4
% clear vehicle5 vehicle1_all vehicle2_all vehicle3_all vehicle4_all vehicle5_all
% vehicle = data_test(13:19,:);
% %输入数据
% AA = [vehicle(:,4) vehicle(:,5) vehicle(:,6) vehicle(:,7) vehicle(:,8) vehicle(:,9) vehicle(:,10) vehicle(:,11) vehicle(:,12) vehicle(:,14)]';
% 
% %将输入数据归一化,PS1
% AA=mapminmax('apply',AA,PS1);
% %放入到网络输出数据
% % 当前模型为net
% load('net_vehicle4_002_best.mat')
% % load('net_vehicle2_006.mat')
% BB=sim(net,AA);
% %将得到的数据反归一化得到预测数据,PS2
% C_testA_veh4=mapminmax('reverse',BB,PS2);
% C_testA_veh4'
%%
%vehicle5
% load('energy_veh5.mat')
% clear P T p1 minp maxp t1 mint maxt vehicle vehicle1 vehicle2 vehicle3 vehicle4
% clear vehicle5 vehicle1_all vehicle2_all vehicle3_all vehicle4_all vehicle5_all
% vehicle = data_test(20:27,:);
% %输入数据
% AA = [vehicle(:,4) vehicle(:,5) vehicle(:,6) vehicle(:,7) vehicle(:,8) vehicle(:,9) vehicle(:,10) vehicle(:,11) vehicle(:,12) vehicle(:,14)]';
% 
% %将输入数据归一化,PS1
% AA=mapminmax('apply',AA,PS1);
% %放入到网络输出数据
% % 当前模型为net
% % load('net_vehicle5_005_best.mat')
% load('net_vehicle5_006.mat')
% BB=sim(net,AA);
% %将得到的数据反归一化得到预测数据,PS2
% C_testA_veh5=mapminmax('reverse',BB,PS2);
% C_testA_veh5'