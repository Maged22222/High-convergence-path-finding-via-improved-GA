function output_GA = RunGA(problem, params)

    % Problem
    nVar = problem.nVar;
    VarMin = problem.VarMin;
    VarMax = problem.VarMax;        
    Start_Index = problem.Start_Index   ;
    End_Index = problem.End_Index   ;  
    Prev_Fittnes_Value = problem.Prev_Fittnes_Value ;
    Stop_Criteria = problem.Stop_Criteria ; 
    P=problem.P ;
  
    
    % Params
    MaxIt = params.MaxIt;
    nPop = params.nPop;
    beta = params.beta;
    pC = params.pC;
    nC = round(pC*nPop/2)*2;
    mu = params.mu;
    elite_percentage = round(0.1*nPop/2)*2;
    Stop_Generation = params.Stop_Generation ;
    % Template for Empty Individuals
    empty_individual.Position = [];
    empty_individual.Cost = [];
    empty_individual.CHR_DIS = [];
    Initial_Population = [];
    CHR_Fitness = [];
    selected_elit_group = [] ;
    selected_elit_group1 = [] ; % 10% for elit group
    selected_elit_group2 = [] ; 
    Link = [];
    % Best Solution Ever Found
    bestsol.Cost = 0;
    
    % Initialization  of initial population
    pop = repmat(empty_individual, nPop, 1);
    [Initial_Population , Link] = Population (nPop, nVar,Start_Index,End_Index,P);

    % Evaluation for initial population
    [ CHR_Fitness,CHR_DIS ] = Fitness(P,nVar,Initial_Population ,nPop,Link);
    
    for i= 1:nPop

        pop(i).Position = Initial_Population(i,:);
        pop(i).Cost = CHR_Fitness(i) ;
        pop(i).CHR_DIS = CHR_DIS(i) ;
        
         % Compare Solution to Best Solution Ever Found
        if pop(i).Cost > bestsol.Cost
            bestsol = pop(i);
        end 

    end

     % Sort Populations
     pop = flip((SortPopulation(pop)));

     %Initialization  ofselected_elit_group1
     selected_elit_group1 = repmat(empty_individual, elite_percentage, 1);

    for i = 1:elite_percentage

     selected_elit_group1(i) =  pop(i);
    end
    
    Best_Fitness_Index = transpose(selected_elit_group1(1:4));
    
 
    % Best Cost of Iterations
    bestcost = nan(MaxIt, 1);

    
    % Main Loop
 while(Stop_Generation ~=1)
    for it = 1:MaxIt
        
        % Selection Probabilities
        c = [pop.Cost];
        avgc = mean(c);
        if avgc ~= 0
            c = c/avgc;
        end
        probs = exp(-beta*c);
        
        % Initialize Offsprings Population
        popc = repmat(empty_individual, nC/2, 2);
        
        % Crossover
        for k = 1:nC/2
            
            % Select Parents
            p1 = pop(RouletteWheelSelection(probs));
            p2 = pop(RouletteWheelSelection(probs));
            
            % Perform Crossover
            [popc(k, 1).Position, popc(k, 2).Position] = ...
                UniformCrossover(p1.Position, p2.Position,End_Index);
            
        end
        
        % Convert popc to Single-Column Matrix
        popc = popc(:);
        
        % Mutation
        for l = 1:nC
            
            % Perform Mutation
            popc(l).Position = Mutate(popc(l).Position, mu,Link);
            
            % Check for Variable Bounds
            popc(l).Position = max(popc(l).Position, VarMin);
            popc(l).Position = min(popc(l).Position, VarMax);
            Initial_Population(l,:)= popc(l).Position ;
        end

          
          % Evaluation fo mutation
           [ CHR_Fitness,CHR_DIS ] = Fitness(P,nVar, Initial_Population,nPop,Link);
            
       for i= 1:nPop

            popc(i).Cost = CHR_Fitness(i) ;
            popc(i).CHR_DIS = CHR_DIS(i) ;
        
                 % Compare Solution to Best Solution Ever Found
               if popc(i).Cost > bestsol.Cost
                    bestsol = popc(i);
               end 

        end
        % Sort Populations
        popc = flip((SortPopulation(popc)));

        %Initialization  ofselected_elit_group1
        selected_elit_group2 = repmat(empty_individual, elite_percentage, 1);
        selected_elit_group = repmat(empty_individual, 2*elite_percentage, 1);
        for i = 1:elite_percentage

               selected_elit_group2(i) =  popc(i);
        end

        selected_elit_group = [selected_elit_group1;selected_elit_group2];
        [~, so] = (sort([selected_elit_group.Cost]));
        selected_elit_group = flip(selected_elit_group(so));
        Best_Fitness_Index = transpose(selected_elit_group(1:4));


        % Merge  Populations
        pop = [pop; popc];

        
        % Sort Populations
        pop =flip((SortPopulation(pop)));
         
        % Remove Extra Individuals
        pop = pop(1:nPop);
        
        % Update Best Cost of Iteration
        bestcost(it) = bestsol.Cost;

        % Display Itertion Information
        disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(bestcost(it))]);


        %Check_For_Stopping_Criteria..
          Cheaking_Equlaity = eq(Prev_Fittnes_Value,  Best_Fitness_Index(1).Cost);
         if Cheaking_Equlaity == 1
             Stop_Criteria = Stop_Criteria+1;
         else
             Prev_Fittnes_Value =  Best_Fitness_Index(1).Cost;
             Stop_Criteria = 0;
         end


        if  Stop_Criteria == 40

               Stop_Generation = 1;
        else 
               Stop_Generation = 0;
        end
        


         if  Stop_Generation == 1
             break;
         end



    end
   
 end
    
    % Results
    output_GA.pop = pop;
    output_GA.bestsol = bestsol;
    output_GA.bestcost = bestcost;
    output_GA.selected_elit_group = selected_elit_group ;
    output_GA.Best_Fitness_Index = Best_Fitness_Index ;
    output_GA.selected_elit_group1 =selected_elit_group1 ;
    output_GA.selected_elit_group2 =selected_elit_group2 ;
    output_GA.Stop_Criteria=Stop_Criteria ;
    output_GA.Link = Link;
end