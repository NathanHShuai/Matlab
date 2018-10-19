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
    timestring_s = num2str(time_s); %���ֱ���ַ���
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
data_test(:,14) = time_charge(2:end)'; %��ɳ��ʱ����㣨s�������洢������ĵ�14��
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
% ����˵��
% vehicle1_all-��1�������ݣ�vehicle5_invalid-�޳���0��NAN��Ч���ݣ�vehicle1-��1������Ч����
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
vehicle = vehicle1;
% vehicle = data_test;
%��������
A = [vehicle(:,4) vehicle(:,5) vehicle(:,7) vehicle(:,8) vehicle(:,9) vehicle(:,10) vehicle(:,11) vehicle(:,12) vehicle(:,14)]';
% A = [vehicle(1,4) vehicle(1,5) vehicle(1,7) vehicle(1,8) vehicle(1,9) vehicle(1,10) vehicle(1,11) vehicle(1,12) vehicle(1,14)]';
load('soc_veh1.mat')
%���������ݹ�һ��
A=mapminmax('apply',A,PS1);
%���뵽�����������
% ��ǰģ��Ϊnet
% load('net_soc.mat')
load('net_soc_003_best.mat');
% load('net_soc_007.mat')
B=sim(net,A);

%���õ������ݷ���һ���õ�Ԥ������
% % C=postmnmx(B,mint,maxt);
C=postmnmx(B,0,100); %Ԥ���soc
C(4)%soc=99.826

soc=vehicle(1:3,6);
figure
plot(soc, 'k-o')
hold on;
plot(C, 'b-');
legend('ʵ��ֵSOC','Ԥ��ֵSOC','northeast');
%%
% vehicle1_all(4,6) = 99.826;
% data_test(4,6) = 99.826;
data_test(4,6) = 92;
%%
vehicle = data_test(1:4,:);
%��������
AA = [vehicle(:,4) vehicle(:,5) vehicle(:,6) vehicle(:,7) vehicle(:,8) vehicle(:,9) vehicle(:,10) vehicle(:,11) vehicle(:,12) vehicle(:,14)]';
load('energy_veh1.mat')
%���������ݹ�һ��
AA=mapminmax('apply',AA,PS1);
%���뵽�����������
load('net_vehicle1_004_best.mat')

BB=sim(net,AA);
%���õ������ݷ���һ���õ�Ԥ������
C_testA_veh1=postmnmx(BB,mint,maxt);
C_testA_veh1'
% % ei=0;
% % for ii=1:size(C')
% %     de(ii) = (C(ii)-vehicle(ii,13))/vehicle(ii,13);
% %     ei = ei+de(ii)*de(ii);
% % end
% % e = sqrt(ei);
% % e
%%
% delt = data(1:4,:) - vehicle
%%
% %vehicle1
% % vehicle = vehicle3_all;
% vehicle = data_test;
% %��������
% AA = [vehicle(:,4) vehicle(:,5) vehicle(:,6) vehicle(:,7) vehicle(:,8) vehicle(:,9) vehicle(:,10) vehicle(:,11) vehicle(:,12) vehicle(:,14)]';
% %���������ݹ�һ��
% AA=premnmx(AA);
% %���뵽�����������
% % ��ǰģ��Ϊnet
% load('net_vehicle1_004_best.mat')
% BB=sim(net,AA);
% %���õ������ݷ���һ���õ�Ԥ������
% % C=postmnmx(B,mint,maxt);
% C_testA_veh3=postmnmx(BB,0.0390,25.1750);
% C_testA_veh3(1,1:4)'

% save testAdata