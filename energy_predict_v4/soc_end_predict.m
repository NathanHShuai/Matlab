clc
clear all
%%
load ('data_after_preprocessing.mat')
clear P T a
P=[vehicle1(:,4) vehicle1(:,5) vehicle1(:,7) vehicle1(:,8) vehicle1(:,9) vehicle1(:,10) vehicle1(:,11) vehicle1(:,12) vehicle1(:,14)]';
T = vehicle1(:,6)';
% [p1,minp,maxp,t1,mint,maxt]=premnmx(P,T);
[p1,PS1]=mapminmax(P);
[t1,PS2]=mapminmax(T);
% % 固定随机种子
% setdemorandstream(1);
%创建网络
net=newff(minmax(P),[9,6,1],{'tansig','tansig','purelin'},'trainlm');
%设置训练次数
net.trainParam.epochs = 7000;
%设置收敛误差
net.trainParam.goal=0.0000001;
%训练网络
[net,tr]=train(net,p1,t1);

% load('net_soc_003_best.mat')
%输入数据
a=[vehicle1(:,4) vehicle1(:,5) vehicle1(:,7) vehicle1(:,8) vehicle1(:,9) vehicle1(:,10) vehicle1(:,11) vehicle1(:,12) vehicle1(:,14)]';
% a=[vehicle1(1:40,4) vehicle1(1:40,5) vehicle1(1:40,7) vehicle1(1:40,8) vehicle1(1:40,9) vehicle1(1:40,10) vehicle1(1:40,11) vehicle1(1:40,12) vehicle1(1:40,14)]';

%将输入数据归一化
a=premnmx(a);
%放入到网络输出数据
b=sim(net,a);
%将得到的数据反归一化得到预测数据
% c=postmnmx(b,mint,maxt);
c=mapminmax('reverse',b,PS2);
for ii=1:size(c')
    de(ii) = (c(ii)-vehicle1(ii,6))/vehicle1(ii,6);
    ei(ii) = de(ii);
end
figure
plot(ei,'r');

mint,maxt
save('net_soc_007','net')
% load('testAdata')
% vehicle = vehicle1;
% % vehicle = data_test;
% %输入数据
% A = [vehicle(:,4) vehicle(:,5) vehicle(:,7) vehicle(:,8) vehicle(:,9) vehicle(:,10) vehicle(:,11) vehicle(:,12) vehicle(:,14)]';
% % A = [vehicle(1,4) vehicle(1,5) vehicle(1,7) vehicle(1,8) vehicle(1,9) vehicle(1,10) vehicle(1,11) vehicle(1,12) vehicle(1,14)]';
% %将输入数据归一化
% A=premnmx(A);
% %放入到网络输出数据
% % 当前模型为net
% % load('net_soc.mat')
% load('net_soc_003_best.mat');
% % load('net_soc_004.mat')
% B=sim(net,A);
% %将得到的数据反归一化得到预测数据
% % % C=postmnmx(B,mint,maxt);
% C=postmnmx(B,mint,maxt); %预测的soc
save soc_veh1