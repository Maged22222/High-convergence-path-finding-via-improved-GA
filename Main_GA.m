clc;
clear;
close all;


%............................Coordinates...................................

x =   [1 1 2 2 2 3 3 3 3 3 3 4 4 4 5 5 6 5 6 6 8 8 8 9 9 10 10 10 11 11 11 13 13 13  12 14 14]; % x-coordinates
y =  [7 11 4 6 9 14 1 3 5 8 9 2 6 7 4 7 6 8 11 4 4 6 8 5 9 1 7 11 14 4 8 12 2 6 9 3 8];   % y-coordinates
z =  [3 1 1 3 2 3 4 3 2 4 3 2 3 4 2 1 5 6 3 9 5 2 6 8 3 9 6 3 4 5 1 6 9 7 5 7 4]; % z-coordinate

%x = [1 1 3 3 5 6 6 8 10 10 10 11 13 12 14 14]; % x-coordinate
%y = [7 11 14 1 8 11 4 4 1 7 11 14 12 2 3 8];   % y-coordinate
%z = [3 1 1 3 2 3 4 3 2 4 3 2 3 4 2 1]; % z-coordinate
%% Problem Definition
                               
problem.nVar = 13;                                      % Chrome Length
problem.P = [x' y' z'] ;
problem.index_Points   = size(problem.P,1);             % No. of Points
problem.NOBS = 7;                                       % No. of Obstacles
problem.SP             = [x(1) y(1) z(1)];              % Start Point
problem.EP             = [x(problem.index_Points ) y(problem.index_Points ) z(problem.index_Points)];  % End Point
problem.VarMin =1;
problem.VarMax = problem.index_Points ;
problem.Start_Index    = 1;                         % Start Point
problem.End_Index      = problem.index_Points ;     % End Point
problem.Prev_Fittnes_Value = 0;                     % Variable For Saving Best Path Fitness
problem.Stop_Criteria  = 0;                         % Variable for defining number of times Previous Fitness was equal to New Fitness
problem.obstacleRadius = 4;
problem.numObstacles = 5;
problem.maxObstacleVelocity = 2;
problem.maxPosition = [max(x(1,:)), max(y(1,:)),max(z(1,:))];
%% GA Parameters

params.MaxIt = 1000;
params.nPop = 400;
params.beta = 1;
params.pC = 1;
params.mu = 0.02;
params.sigma = 0.1;
params.Stop_Generation = 0;

%% Run GA

output_GA = RunGA(problem, params);


%% Results

%Definung the nessary values for printing
P = problem.P;
Best_Fitness_Index = output_GA.Best_Fitness_Index.Position ;
Best.CHR.Distance = output_GA.pop(1).CHR_DIS;

for i = 1:params.nPop 

     Positions(i,:)=output_GA.pop(i,:).Position;
end
%................................Text File.................................


fid = fopen('GA_Outputs.txt','wt');
fprintf(fid,'Function has following Values:\n');
fprintf(fid,'Population:\n');
for i = 1:20
    fprintf(fid,'%g\t', Positions(i,:));
    fprintf(fid,'\n');
end
fprintf(fid,'First_Best_Chromosome:\n');
fprintf(fid,'%g\t',output_GA.Best_Fitness_Index(1).Position);
fprintf(fid,'\n');
fprintf(fid,'Second_Best_Chromosome:\n');
fprintf(fid,'%g\t',output_GA.Best_Fitness_Index(2).Position);
fprintf(fid,'\n');
fprintf(fid,'Third_Best_Chromosome:\n');
fprintf(fid,'%g\t',output_GA.Best_Fitness_Index(3).Position);
fprintf(fid,'\n');
fprintf(fid,'No_Of_Generations_For_Result_Convergence=');
fprintf(fid,'%g\t',output_GA.Stop_Criteria);
fprintf(fid,'\n');
fprintf(fid,'Final_Best_Chromosome_Distance:\n');
fprintf(fid,'%g\t',Best.CHR.Distance);
fprintf(fid,'\n');
fclose(fid);




%..................................Plot....................................
figure;
plot(output_GA.bestcost, 'LineWidth', 2);
%semilogy(output_GA.bestcost, 'LineWidth', 2);
xlabel('Iterations');
ylabel('Best Cost');
grid on;

figure;
hold on
%plot obsticales
obstacles = initializeObstacles(problem.numObstacles, problem.maxPosition, problem.maxObstacleVelocity, problem.obstacleRadius);

% Plot all points
plot3(P(:,1), P(:,2), P(:,3), 'o', 'MarkerSize', 2, 'DisplayName', 'All Points');

% Extract coordinates using Best_Fitness_Index
tr = P(Best_Fitness_Index, :)';

% Plot the best fitness path dynamically
plot3(tr(1,:), tr(2,:), tr(3,:), '-o', 'DisplayName', 'Best Path');
plot3(tr(1,:), tr(2,:),tr(3,:), 'ro', 'MarkerFaceColor', 'r', 'DisplayName', 'Red Points');

% Add text labels for all points
for i = 1:length(P)
    text(P(i, 1), P(i, 2), P(i, 3), num2str(i), ...
        'VerticalAlignment', 'bottom', ...
        'HorizontalAlignment', 'right', ...
        'FontSize', 6); % Adjust FontSize to make the text small
end

% Set plot limits and labels
xlim([-2 max(x(1,:))+2])
ylim([-2 max(y(1,:))+2])
zlim([-2 max(z(1,:))+2]);
title('Best Path')
xlabel('Distance along x-axis')
ylabel('Distance along y-axis')
zlabel('Distance along z-axis');

% Customize axis appearance
ax = gca;
ax.XColor = 'r'; % Change x-axis color
ax.YColor = 'g'; % Change y-axis color
ax.ZColor = 'b'; % Change z-axis color

% Add legend
legend('show');

% Ensure 3D view
view(3); % Set the default 3D view
hold off







