clc
% clear 
% load('net.mat')
%�趨��ǰԤ�⳵��ID
vehicle = vehicle1;

%��������
A = [vehicle(:,4) vehicle(:,5) vehicle(:,6) vehicle(:,7) vehicle(:,8) vehicle(:,9) vehicle(:,10) vehicle(:,11) vehicle(:,12) vehicle(:,14)]';
%���������ݹ�һ��
A=premnmx(A);
%���뵽�����������
% ��ǰģ��Ϊnet
B=sim(net,A);
%���õ������ݷ���һ���õ�Ԥ������
C=postmnmx(B,mint,maxt);
ei=0;
for ii=1:size(C')
    de(ii) = (C(ii)-vehicle(ii,13))/vehicle(ii,13);
    ei = ei+de(ii)*de(ii);
end
e = sqrt(ei);
e
