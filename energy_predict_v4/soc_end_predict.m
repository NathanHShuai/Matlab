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
% % �̶��������
% setdemorandstream(1);
%��������
net=newff(minmax(P),[9,6,1],{'tansig','tansig','purelin'},'trainlm');
%����ѵ������
net.trainParam.epochs = 7000;
%�����������
net.trainParam.goal=0.0000001;
%ѵ������
[net,tr]=train(net,p1,t1);

% load('net_soc_003_best.mat')
%��������
a=[vehicle1(:,4) vehicle1(:,5) vehicle1(:,7) vehicle1(:,8) vehicle1(:,9) vehicle1(:,10) vehicle1(:,11) vehicle1(:,12) vehicle1(:,14)]';
% a=[vehicle1(1:40,4) vehicle1(1:40,5) vehicle1(1:40,7) vehicle1(1:40,8) vehicle1(1:40,9) vehicle1(1:40,10) vehicle1(1:40,11) vehicle1(1:40,12) vehicle1(1:40,14)]';

%���������ݹ�һ��
a=premnmx(a);
%���뵽�����������
b=sim(net,a);
%���õ������ݷ���һ���õ�Ԥ������
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
% %��������
% A = [vehicle(:,4) vehicle(:,5) vehicle(:,7) vehicle(:,8) vehicle(:,9) vehicle(:,10) vehicle(:,11) vehicle(:,12) vehicle(:,14)]';
% % A = [vehicle(1,4) vehicle(1,5) vehicle(1,7) vehicle(1,8) vehicle(1,9) vehicle(1,10) vehicle(1,11) vehicle(1,12) vehicle(1,14)]';
% %���������ݹ�һ��
% A=premnmx(A);
% %���뵽�����������
% % ��ǰģ��Ϊnet
% % load('net_soc.mat')
% load('net_soc_003_best.mat');
% % load('net_soc_004.mat')
% B=sim(net,A);
% %���õ������ݷ���һ���õ�Ԥ������
% % % C=postmnmx(B,mint,maxt);
% C=postmnmx(B,mint,maxt); %Ԥ���soc
save soc_veh1