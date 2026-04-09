%% PLOT TO DISPLAY TRAFFIC STATE 
figure(1)
subplot(2,2,1)
scatter(FLOW_AGG(:,1:3),HARMONIC_SPEED_AGG(:,1:3))
set (gca,'Xdir','reverse')
xlabel('Flow [veh/h]')
ylabel('Speed [m/s]')
box('on')

subplot(2,2,2)
scatter(ESTIMATED_DENSITY(:,1:3),HARMONIC_SPEED_AGG(:,1:3))
box('on')
xlabel('Density [veh/km]')
ylabel('Speed [m/s]')

subplot(2,2,3)
scatter(FLOW_AGG(:,1:3),ESTIMATED_DENSITY(:,1:3))
set (gca,'Xdir','reverse')
set (gca,'Ydir','reverse')
xlabel('Flow [veh/h]')
ylabel('Density [veh/km]')
box('on')

%% CUMULATIVE NUMBER OF VEHICLES IN THE 500-m LONG SEGMENT
figure(2)
veh_in = cumsum(sum(VEH_OBSERVED(:,[1 2 3]),2));
veh_out = cumsum(sum(VEH_OBSERVED(:,[4 5 6]),2));
yyaxis left
plot(veh_in,'LineWidth',1.5)
hold on
box on
plot(veh_out,'LineWidth',1.5)
xlabel('Record')
ylabel('Cumulate [veh]')
veh_segment = cumsum(sum(VEH_OBSERVED(:,[1 2 3]),2)-sum(VEH_OBSERVED(:,[4 5 6]),2));
yyaxis right
plot(veh_segment,'LineWidth',1.5)
ylabel('Vehicles in the segment [veh]')
legend('Entrance','Exit','N° vehicle in the segment')