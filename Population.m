function [ Initial_Population, Link] = Population (nPop, nVar,Start_Index,End_Index,P)

% Creatiing a permisable knots for every point( THis can be upgareded to be dynamicly related to thr enviroment 
Link(01,01)= 01 ; Link(01,02)= 03 ; Link(01,03)= 04 ; Link(01,04)= 05 ;    Link(01,05)= 10 ;
Link(02,01)= 02 ; Link(02,02)= 05 ; Link(02,03)= 06 ; Link(02,04)= 11 ;    Link(02,05)= 14 ;
Link(03,01)= 03 ; Link(03,02)= 07 ; Link(03,03)= 08 ; Link(03,04)= 09 ;
Link(04,01)= 04 ; Link(04,02)= 09 ; Link(04,03)= 10 ; Link(04,04)= 13 ;    Link(04,05)= 14 ;
Link(05,01)= 05 ; Link(05,02)= 11 ; Link(05,03)= 10 ;
Link(06,01)= 06 ; Link(06,02)= 19 ;
Link(07,01)= 07 ; Link(07,02)= 12 ; 
Link(08,01)= 08 ; Link(08,02)= 09 ; Link(08,03)= 12 ;   
Link(09,01)= 09 ; Link(09,02)= 13 ; Link(09,03)= 14 ; Link(09,04)= 15 ;
Link(10,01)= 10 ; Link(10,02)= 11 ; Link(10,03)= 13 ; Link(10,04)= 14 ;    Link(10,05)= 16;  Link(10,06)= 18;  
Link(11,01)= 11 ; Link(11,02)= 13 ; Link(11,03)= 14 ; Link(11,04)= 16 ;    Link(11,05)= 18 ; Link(11,06)= 19 ;
Link(12,01)= 12 ; Link(12,02)= 15 ; Link(12,03)= 20 ; Link(12,04)= 21 ;    Link(12,05)= 26 ;
Link(13,01)= 13 ; Link(13,02)= 15 ; Link(13,03)= 16 ; Link(13,04)= 17 ;    Link(13,5)= 18 ;  Link(13,06)= 20 ;
Link(14,01)= 14 ; Link(14,02)= 15 ; Link(14,03)= 16 ; Link(14,04)= 17 ;    Link(14,05)= 18 ; Link(14,06)= 19 ;  Link(14,07)= 20 ;
Link(15,01)= 15 ; Link(15,02)= 17 ; Link(15,03)= 20 ; Link(15,04)= 26 ;
Link(16,01)= 16 ; Link(16,02)= 17 ; Link(16,03)= 18 ; Link(16,04)= 20 ;    Link(16,05)= 23 ;
Link(17,01)= 17 ; Link(17,02)= 19 ; Link(17,03)= 20 ; Link(17,04)= 21 ;    Link(17,05)= 22 ; Link(17,06)= 23 ;  Link(17,07)= 29 ;
Link(18,01)= 18 ; Link(18,02)= 19 ; Link(18,03)= 22 ; Link(18,04)= 23 ; 
Link(19,01)= 19 ; Link(19,02)= 23 ; Link(19,03)= 25 ; Link(19,04)= 28 ;    Link(19,05)= 29 ;
Link(20,01)= 20 ; Link(20,02)= 21 ; Link(20,03)= 22 ; Link(20,04)= 26 ;
Link(21,01)= 21 ; Link(21,02)= 22 ; Link(21,03)= 24 ; Link(21,04)= 26 ;
Link(22,01)= 22 ; Link(22,02)= 23 ; Link(22,03)= 24 ; Link(22,04)= 27 ;
Link(23,01)= 23 ; Link(23,02)= 25 ; Link(23,03)= 27 ;
Link(24,01)= 24 ; Link(24,02)= 27 ; Link(24,03)= 30 ;
Link(25,01)= 25 ; Link(25,02)= 27 ; Link(25,03)= 28 ; Link(25,04)= 31 ;    Link(25,05)= 35 ;
Link(26,01)= 26 ; Link(26,02)= 30 ; Link(26,03)= 33 ;
Link(27,01)= 27 ; Link(27,02)= 30 ; Link(27,03)= 31 ; Link(27,04)= 34 ;
Link(28,01)= 28 ; Link(28,02)= 29 ; Link(28,03)= 31 ; Link(28,04)= 32 ;    Link(28,05)= 35 ;
Link(29,01)= 29 ; Link(29,02)= 32 ;
Link(30,01)= 30 ; Link(30,02)= 33 ; Link(30,03)= 34 ; Link(30,04)= 36 ;
Link(31,01)= 31 ; Link(31,02)= 34 ; Link(31,03)= 35 ; 
Link(32,01)= 32 ; Link(32,02)= 37 ; 
Link(33,01)= 33 ; Link(33,02)= 34 ; Link(33,03)= 36 ;
Link(34,01)= 34 ; Link(34,02)= 37 ;
Link(35,01)= 35 ; Link(35,02)= 37 ;
Link(36,01)= 36 ; Link(36,02)= 37 ;
Link(37,01)= 37 ; 


%....................Step_2_GENE Distance & GENE_Fitness...................
[M,N] = size(Link);
for i=1:M
    for j=1:(N-1)
        if (Link(i,j)>0 && Link(i,j+1)>0)
            GENE_DIS(i,j)  = abs(sqrt(((P(Link(i,j),1))-(P(Link(i,j+1),1)))^2+((P(Link(i,j),2))-(P(Link(i,j+1),2)))^2+((P(Link(i,j),3))-(P(Link(i,j+1),3)))^2));
            GENE_FIT(i,j)  = 1/GENE_DIS(i,j);
            GENE_FIT(i,j)  = GENE_FIT(i,j)*(2^5);%Multiplying by 2^5 for better fitness Function
        end
    end
end
%................. .Step_3_Calculating GENE Probability....................
for i=1:M-1
    for j=1:(N-1)
        GENE_Prob(i,j) = GENE_FIT(i,j)/sum(GENE_FIT(i,:));
    end
end
%..............Step_4_Calculating Comulative GENE Probability..............
for i=1:M-1
    GENE_Cum_Prob(i,1) = GENE_Prob(i,1);
    r=(N-1);
    for j= 2:r 

          if (GENE_Prob(i,j) > 0 )
                GENE_Cum_Prob(i,j) = GENE_Cum_Prob(i,j-1) + GENE_Prob(i,j);
        
          end   
    end
end
%...........Step_5_Start Point and End Points are Defined by User..........
for i=1:nPop
    Initial_Population(i,1)       = Start_Index;
    Initial_Population(i,nVar) = End_Index  ;
end
%.....................Step_6_Creates A New Population......................
 
for k = 1:nPop
    i = Start_Index;
    j = Start_Index + 1;
    while j < nVar
        a = rand;
        
        % Iterate through columns of GENE_Cum_Prob for the current row i
        for col = 1:size(GENE_Cum_Prob, 2)
            if a < GENE_Cum_Prob(i, col)
                % Ensure col+1 does not exceed the size of Link
                if col + 1 <= size(Link, 2)
                    Initial_Population(k, j) = Link(i, col + 1);
                    i = Link(i, col + 1);
                end
                
                % Handle the end index case
                if i == End_Index
                    while j ~= nVar - 1
                        Initial_Population(k, j + 1) = End_Index;
                        j = j + 1;
                    end
                end
                break; % Exit the loop once a condition is met
            end
        end
        
        j = j + 1;
    end
end

end