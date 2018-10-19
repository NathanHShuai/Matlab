clc
% clear 
% load('net.mat')
%设定当前预测车辆ID
vehicle = vehicle1;

%输入数据
A = [vehicle(:,4) vehicle(:,5) vehicle(:,6) vehicle(:,7) vehicle(:,8) vehicle(:,9) vehicle(:,10) vehicle(:,11) vehicle(:,12) vehicle(:,14)]';
%将输入数据归一化
A=premnmx(A);
%放入到网络输出数据
% 当前模型为net
B=sim(net,A);
%将得到的数据反归一化得到预测数据
C=postmnmx(B,mint,maxt);
ei=0;
for ii=1:size(C')
    de(ii) = (C(ii)-vehicle(ii,13))/vehicle(ii,13);
    ei = ei+de(ii)*de(ii);
end
e = sqrt(ei);
e
