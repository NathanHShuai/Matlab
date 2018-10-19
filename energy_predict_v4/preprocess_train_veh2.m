clc
clear all
%%
load ('data_after_preprocessing.mat')
clear P T p1 minp maxp t1 mint maxt
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
vehicle = vehicle2;
%输入数据
P=[vehicle(:,4) vehicle(:,5) vehicle(:,6) vehicle(:,7) vehicle(:,8) vehicle(:,9) vehicle(:,10) vehicle(:,11) vehicle(:,12) vehicle(:,14)]';
r=size(vehicle(:,13));

T = vehicle(:,13)';
[p1,PS1]=mapminmax(P);
[t1,PS2]=mapminmax(T);


%创建网络
net=newff(minmax(P),[10,6,1],{'tansig','tansig','purelin'},'trainlm');
%设置训练次数
net.trainParam.epochs = 7000;
%设置收敛误差
net.trainParam.goal=0.0000001;
% %训练网络
[net,tr]=train(net,p1,t1);

load('net_vehicle2_003_best.mat') 
%输入数据
a=[vehicle(:,4) vehicle(:,5) vehicle(:,6) vehicle(:,7) vehicle(:,8) vehicle(:,9) vehicle(:,10) vehicle(:,11) vehicle(:,12) vehicle(:,14)]';
%将输入数据归一化
a=mapminmax('apply',a,PS1);
%放入到网络输出数据
b=sim(net,a);
%将得到的数据反归一化得到预测数据
c=mapminmax('reverse',b,PS2);

for ii=1:size(c')
    de(ii) = (c(ii)-vehicle(ii,13))/vehicle(ii,13);
    ei(ii) = de(ii);
end
figure
plot(ei,'r','LineWidth',1.5);
title('Vehicle 2','FontWeight','bold','FontName','Times New Roman','FontSize',18)
set(gca,'linewidth',0.5,'FontWeight','bold','fontsize',15,'fontname','Times');
xlabel('训练数据序号','FontWeight','bold','FontName','微软雅黑','FontSize',18)
ylabel('误差e','FontWeight','bold','FontName','微软雅黑','FontSize',18,'Rotation',90)
saveas(gcf,'v2','fig')
%%
save('net_vehicle2_006','net')
save energy_veh2