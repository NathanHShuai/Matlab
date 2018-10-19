clc
clear all
%%
load ('data_after_preprocessing.mat')
clear P T p1 minp maxp t1 mint maxt
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
% 13-charge_energy
% 14-charge_time /s
%%
vehicle = vehicle2;
%��������
P=[vehicle(:,4) vehicle(:,5) vehicle(:,6) vehicle(:,7) vehicle(:,8) vehicle(:,9) vehicle(:,10) vehicle(:,11) vehicle(:,12) vehicle(:,14)]';
r=size(vehicle(:,13));

T = vehicle(:,13)';
[p1,PS1]=mapminmax(P);
[t1,PS2]=mapminmax(T);


%��������
net=newff(minmax(P),[10,6,1],{'tansig','tansig','purelin'},'trainlm');
%����ѵ������
net.trainParam.epochs = 7000;
%�����������
net.trainParam.goal=0.0000001;
% %ѵ������
[net,tr]=train(net,p1,t1);

load('net_vehicle2_003_best.mat') 
%��������
a=[vehicle(:,4) vehicle(:,5) vehicle(:,6) vehicle(:,7) vehicle(:,8) vehicle(:,9) vehicle(:,10) vehicle(:,11) vehicle(:,12) vehicle(:,14)]';
%���������ݹ�һ��
a=mapminmax('apply',a,PS1);
%���뵽�����������
b=sim(net,a);
%���õ������ݷ���һ���õ�Ԥ������
c=mapminmax('reverse',b,PS2);

for ii=1:size(c')
    de(ii) = (c(ii)-vehicle(ii,13))/vehicle(ii,13);
    ei(ii) = de(ii);
end
figure
plot(ei,'r','LineWidth',1.5);
title('Vehicle 2','FontWeight','bold','FontName','Times New Roman','FontSize',18)
set(gca,'linewidth',0.5,'FontWeight','bold','fontsize',15,'fontname','Times');
xlabel('ѵ���������','FontWeight','bold','FontName','΢���ź�','FontSize',18)
ylabel('���e','FontWeight','bold','FontName','΢���ź�','FontSize',18,'Rotation',90)
saveas(gcf,'v2','fig')
%%
save('net_vehicle2_006','net')
save energy_veh2