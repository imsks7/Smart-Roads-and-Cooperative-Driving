%% CLREAR ALL AND CLOSE ALL
close all
clear all
clc

%%
cartella = strcat('OUTPUT_Simulations_1');
mkdir(cartella)
PathName = 'C:\Users\ragha\OneDrive\Desktop\Co_Simulation_2\Simple_Scenario'; %cambiare percorso se necessario
addpath(PathName)  


%% SIMULATION LOOP
for i = 1:1
    system(['sumo -c' './Rettilineo_Traci.sumocfg&']);
    [traciVersion sumoVersion]= traci.init(8873);
    detectors_list = traci.inductionloop.getIDList();

    update_freq = 10;
    simulation_time = 3600*update_freq; % simulation time in seconds
    aggregation_time = 5*60*update_freq; % aggregation in minutes * seconds in a minute * step lenght of SUMO
    aggregation_time_counter = 1;
    %ID_Veh = {};

    % Initialization of aggregation vectors
    SPEED_AGG  = zeros(simulation_time/aggregation_time,length(detectors_list));
    OCC_AGG  = zeros(simulation_time/aggregation_time,length(detectors_list));
    FLOW_AGG = zeros(simulation_time/aggregation_time,length(detectors_list));

    for t = 1:simulation_time
        traci.simulationStep();
        for p = 1:length(detectors_list)
            veh_number = traci.inductionloop.getLastStepVehicleNumber(detectors_list{p});
            if veh_number > 0
                    id = traci.inductionloop.getLastStepVehicleIDs(detectors_list{p});
                for j = 1:length(id)
                    ID_Veh{t-aggregation_time*(aggregation_time_counter-1)+j-1,p} = id(j);
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

            SPEED_AGG(aggregation_time_counter,:) = nanmean(SPEED);
            OCC_AGG(aggregation_time_counter,:)= nanmean(OCCUPANCY);
            FLOW_AGG(aggregation_time_counter,:) = sum(VEHICLES*3600/(aggregation_time/update_freq),1);

            aggregation_time_counter = aggregation_time_counter + 1;
        end
    end
    % MOVE THE SIMULATION OUTPUT INTO A DEDICATED FOLDER
    attuale = cd;
    nome = strcat('Simulation_',num2str(i),'.mat');  
    save(nome)
    movefile(nome,cartella)
end

