%% CLREAR ALL AND CLOSE ALL
close all
clear all
clc

%%
cartella = strcat('Simulation_Output_', string(datetime('now','Format','yyyy-MM-dd''_''HH-mm')));
mkdir(cartella)
PathName = pwd;
addpath(PathName)  

%% SIMULATION LOOP
for i = 1:20
    system(['sumo -c' 'C:\Users\sksar\Desktop\github\smart road\Simple_Scenario\Rettilineo_Traci.sumocfg&']);
    [traciVersion sumoVersion]= traci.init(8873);
    detectors_list = traci.inductionloop.getIDList();

    update_freq = 1;
    simulation_time = 3600*update_freq; % simulation time in seconds
    aggregation_time = 5*60*update_freq; % aggregation in minutes * seconds in a minute * step lenght of SUMO
    aggregation_time_counter = 1;

    % Initialization of aggregation vectors
    MEAN_SPEED_AGG  = zeros(simulation_time/aggregation_time,length(detectors_list));
    HARMONIC_SPEED_AGG  = zeros(simulation_time/aggregation_time,length(detectors_list));
    OCC_AGG  = zeros(simulation_time/aggregation_time,length(detectors_list));
    FLOW_AGG = zeros(simulation_time/aggregation_time,length(detectors_list));
    VEH_OBSERVED = zeros(simulation_time/aggregation_time,length(detectors_list));
    
    ID_Veh = {};

    for t = 1:simulation_time
        traci.simulationStep();
        for p = 1:length(detectors_list)
            if (t == 1 || t == aggregation_time*(aggregation_time_counter-1)+1)
                ID_Veh{p} = {'101010101'};
            end
            veh_number = traci.inductionloop.getLastStepVehicleNumber(detectors_list{p});
            if veh_number > 0
                    id = traci.inductionloop.getLastStepVehicleIDs(detectors_list{p});
                for j = 1:length(id)
                    ID_Veh{p}(end+1,1) = id(j);
                    %ID_Veh{t-aggregation_time*(aggregation_time_counter-1)+j-1,p} = id(j);
                end
            else
                id = 'NaN';
            end
        SPEED(t-aggregation_time*(aggregation_time_counter-1),p) = traci.inductionloop.getLastStepMeanSpeed(detectors_list{p});
        OCCUPANCY(t-aggregation_time*(aggregation_time_counter-1),p) = traci.inductionloop.getLastStepOccupancy(detectors_list{p});
        VEHICLES(t-aggregation_time*(aggregation_time_counter-1),p) = veh_number;

        end
        if t == aggregation_time*aggregation_time_counter
            OCCUPANCY(OCCUPANCY ==-1) = NaN;
            SPEED(SPEED ==-1) = NaN;

            MEAN_SPEED_AGG(aggregation_time_counter,:) = nanmean(SPEED);
            HARMONIC_SPEED_AGG(aggregation_time_counter,:) = harmmean(SPEED,'omitnan');
            OCC_AGG(aggregation_time_counter,:)= nanmean(OCCUPANCY);

            for p = 1:length(detectors_list)
                veh_crossed(1,p) = length(unique(ID_Veh{p}))-1;
            end
            VEH_OBSERVED(aggregation_time_counter,:) = veh_crossed;
            FLOW_AGG(aggregation_time_counter,:) = sum(veh_crossed*3600/(aggregation_time/update_freq),1);

            aggregation_time_counter = aggregation_time_counter + 1;
            ID_Veh = {};
        end
    end
    traci.close()
    % MOVE THE SIMULATION OUTPUT INTO A DEDICATED FOLDER
    attuale = cd;
    nome = strcat('Simulation_',num2str(i),'.mat');  
    save(nome)
    movefile(nome,cartella)
end
ESTIMATED_DENSITY = FLOW_AGG./(HARMONIC_SPEED_AGG*3.6);

save('output0.83_0.83.mat',"ESTIMATED_DENSITY","HARMONIC_SPEED_AGG","VEH_OBSERVED","FLOW_AGG")