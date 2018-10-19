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
find(charge_start_U==1)
find(charge_start_U==2)
find(charge_start_U==3)
find(charge_start_U==4)
find(charge_start_U==5)

find(charge_end_U==1)
find(charge_end_U==2)
find(charge_end_U==3)
find(charge_end_U==4)
find(charge_end_U==5)
%%
predictdata = predictdataetrain(2:end,:);
data = table2array(predictdata);
for i=1:5
    if i==1
        row_index = data(:,1) == i;
        veh1 = data(row_index,:);
    elseif i==2
        row_index = data(:,1) == i;
        veh2 = data(row_index,:);
    elseif i==3
        row_index = data(:,1) == i;
        veh3 = data(row_index,:);
    elseif i==4
        row_index = data(:,1) == i;
        veh4 = data(row_index,:);
    else
        row_index = data(:,1) == i;
        veh5 = data(row_index,:);
    end
end

% z1 = find(data==1);
% veh1 = data(z1',:);
% x(find(isnan(x)==1)) = 0
