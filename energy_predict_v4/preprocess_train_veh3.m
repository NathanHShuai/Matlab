clc
clear all
%%
load ('veh3_tan1.mat')
% load ('veh3_tan2.mat')
veh3_tan1 = table2array(veh3tan1(:,1:11));
% veh3_tan2 = table2array(veh3tan2);
% 数据说明

% 1-mileage
% 2-charge_start_soc
% 3-charge_end_soc
% 4-charge_start_U
% 5-charge_end_U
% 6-charge_start_I
% 7-charge_end_I
% 8-charge_max_temp
% 9-charge_min_temp
% 10-charge_energy
% 11-charge_time /s
%%
vehicle = veh3_tan1;
%输入数据
% veh3_tan1
P=[vehicle(:,1) vehicle(:,2) vehicle(:,3) vehicle(:,4) vehicle(:,5) vehicle(:,6) vehicle(:,7) vehicle(:,8) vehicle(:,9) vehicle(:,11)]';
T = vehicle(:,10)';
[p1,PS1]=mapminmax(P);
[t1,PS2]=mapminmax(T);

%veh3_tan2
% P=[vehicle(:,4) vehicle(:,5) vehicle(:,6) vehicle(:,7) vehicle(:,8) vehicle(:,9) vehicle(:,10) vehicle(:,11) vehicle(:,12) vehicle(:,14)]';
% T = vehicle(:,13)';
% [p1,PS1]=mapminmax(P);
% [t1,PS2]=mapminmax(T);


%创建网络
net=newff(minmax(P),[10,6,1],{'tansig','tansig','purelin'},'trainlm');
%设置训练次数
net.trainParam.epochs = 7000;
%设置收敛误差
net.trainParam.goal=0.0000001;
% %训练网络
[net,tr]=train(net,p1,t1);

% load('net_vehicle3_004_best.mat') 
%输入数据
a=[vehicle(:,1) vehicle(:,2) vehicle(:,3) vehicle(:,4) vehicle(:,5) vehicle(:,6) vehicle(:,7) vehicle(:,8) vehicle(:,9) vehicle(:,11)]';
% a = [vehicle(:,4) vehicle(:,5) vehicle(:,6) vehicle(:,7) vehicle(:,8) vehicle(:,9) vehicle(:,10) vehicle(:,11) vehicle(:,12) vehicle(:,14)]';
%将输入数据归一化
a=mapminmax('apply',a,PS1);
%放入到网络输出数据
b=sim(net,a);
%将得到的数据反归一化得到预测数据
c=mapminmax('reverse',b,PS2);

for ii=1:size(c')
    de(ii) = (c(ii)-vehicle(ii,10))/vehicle(ii,10);
    ei(ii) = de(ii);
end
% for ii=1:size(c')
%     de(ii) = (c(ii)-vehicle(ii,13))/vehicle(ii,13);
%     ei(ii) = de(ii);
% end
figure
plot(ei,'r','LineWidth',1.5);
title('Vehicle 3','FontWeight','bold','FontName','Times New Roman','FontSize',18)
set(gca,'linewidth',0.5,'FontWeight','bold','fontsize',15,'fontname','Times');
xlabel('训练数据序号','FontWeight','bold','FontName','微软雅黑','FontSize',18)
ylabel('误差e','FontWeight','bold','FontName','微软雅黑','FontSize',18,'Rotation',90)
saveas(gcf,'v3','fig')
%%
save('net_vehicle3_105','net')
save energy_veh3_tan1