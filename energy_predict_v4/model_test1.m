% save predictdata
clc
clear
%%
load ('predictdata.mat')
predictdata = predictdataetrain;
vehicle_id = predictdata.vehicle_id(2:end);
charge_start_time = predictdata.charge_start_time(2:end);
charge_end_time = predictdata.charge_end_time(2:end);
mileage = predictdata.mileage(2:end);
charge_start_soc = predictdata.charge_start_soc(2:end);
charge_end_soc = predictdata.charge_end_soc(2:end);
charge_start_U = predictdata.charge_start_U(2:end);
charge_end_U = predictdata.charge_end_U(2:end);
charge_start_I = predictdata.charge_start_I(2:end);
charge_end_I = predictdata.charge_end_I(2:end);
charge_max_temp = predictdata.charge_max_temp(2:end);
charge_min_temp = predictdata.charge_min_temp(2:end);
charge_energy = predictdata.charge_energy(2:end);
%%
charge_start_time1 = zeros(1);
charge_end_time1 = zeros(1);
mileage1 = zeros(1);
charge_start_soc1 = zeros(1);
charge_end_soc1 = zeros(1);
charge_start_U1 = zeros(1);
charge_end_U1 = zeros(1);
charge_start_I1 = zeros(1);
charge_end_I1 = zeros(1);
charge_max_temp1 = zeros(1);
charge_min_temp1 = zeros(1);
charge_energy1 = zeros(1);
for i=1:size(vehicle_id)
    if vehicle_id(i) == 1
        charge_start_time1 = [charge_start_time1 charge_start_time(i)];
        charge_end_time1 = [charge_end_time1 charge_end_time(i)];
        mileage1=[mileage1 mileage(i)];
        charge_start_soc1 = [charge_start_soc1 charge_start_soc(i)];
        charge_end_soc1 = [charge_end_soc1 charge_end_soc(i)];
        charge_start_U1 = [charge_start_U1 charge_start_U(i)];
        charge_end_U1 = [charge_end_U1 charge_end_U(i)];
        charge_start_I1 = [charge_start_I1 charge_start_I(i)];
        charge_end_I1 = [charge_end_I1 charge_end_I(i)];
        charge_max_temp1 = [charge_max_temp1 charge_max_temp(i)];
        charge_min_temp1 = [charge_min_temp1 charge_min_temp(i)];
        charge_energy1 = [charge_energy1 charge_energy(i)];
    elseif vehicle_id(i) == 2
        charge_start_time2 = charge_start_time(i);
        charge_end_time2 = charge_end_time(i);
        mileage2=mileage(i);
        charge_start_soc2 = charge_start_soc(i);
        charge_end_soc2 = charge_end_soc(i);
        charge_start_U2 = charge_start_U(i);
        charge_end_U2 = charge_end_U(i);
        charge_start_I2 = charge_start_I(i);
        charge_end_I2 = charge_end_I(i);
        charge_max_temp2 = charge_max_temp(i);
        charge_min_temp2 = charge_min_temp(i);
        charge_energy2 = charge_energy(i);
    elseif vehicle_id(i) == 3
        charge_start_time3 = charge_start_time(i);
        charge_end_time3 = charge_end_time(i);
        mileage3=mileage(i);
        charge_start_soc3 = charge_start_soc(i);
        charge_end_soc3 = charge_end_soc(i);
        charge_start_U3 = charge_start_U(i);
        charge_end_U3 = charge_end_U(i);
        charge_start_I3 = charge_start_I(i);
        charge_end_I3 = charge_end_I(i);
        charge_max_temp3 = charge_max_temp(i);
        charge_min_temp3 = charge_min_temp(i);
        charge_energy3 = charge_energy(i);
    elseif vehicle_id(i) == 4
        charge_start_time4 = charge_start_time(i);
        charge_end_time4 = charge_end_time(i);
        mileage4=mileage(i);
        charge_start_soc4 = charge_start_soc(i);
        charge_end_soc4 = charge_end_soc(i);
        charge_start_U4 = charge_start_U(i);
        charge_end_U4 = charge_end_U(i);
        charge_start_I4 = charge_start_I(i);
        charge_end_I4 = charge_end_I(i);
        charge_max_temp4 = charge_max_temp(i);
        charge_min_temp4 = charge_min_temp(i);
        charge_energy4 = charge_energy(i);
    elseif vehicle_id(i) == 5
        charge_start_time5 = charge_start_time(i);
        charge_end_time5 = charge_end_time(i);
        mileage5=mileage(i);
        charge_start_soc5 = charge_start_soc(i);
        charge_end_soc5 = charge_end_soc(i);
        charge_start_U5 = charge_start_U(i);
        charge_end_U5 = charge_end_U(i);
        charge_start_I5 = charge_start_I(i);
        charge_end_I5 = charge_end_I(i);
        charge_max_temp5 = charge_max_temp(i);
        charge_min_temp5 = charge_min_temp(i);
        charge_energy5 = charge_energy(i);
    else
        error('vehicle id is unknow');
    end
end
%%    
% n = 1:1:223;
% plot(n(2:end),charge_max_temp1(2:end))
% figure
% plot(charge_start_soc1(2:end),charge_energy1(2:end))
% figure
% scatter(charge_start_soc1(2:end),charge_energy1(2:end))
% title('充电能量-充电起始SOC关系图')
veh1 = [charge_start_time1' charge_end_time1' mileage1' charge_start_soc1' charge_end_soc1' ...
    charge_start_U1' charge_end_U1' charge_start_I1' charge_end_I1' charge_max_temp1' ...
    charge_min_temp1' charge_energy1'];
veh1 = veh1(2:end,:);
