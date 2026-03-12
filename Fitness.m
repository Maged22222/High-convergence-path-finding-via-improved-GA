function [ CHR_Fitness,CHR_DIS ] = Fitness(P,CHR_LEN,New_Pop,PopMax,Link)


%...................Step_1_Chromosome Total Distance.......................

for i=1:PopMax
    for j=1:(CHR_LEN-1)
        Calculating_CHR_DIS(i,j)  = abs(sqrt(((P(New_Pop(i,j+1),1)-P(New_Pop(i,j),1))^2)+((P(New_Pop(i,j+1),2)-P(New_Pop(i,j),2))^2)+((P(New_Pop(i,j+1),3)-P(New_Pop(i,j),3))^2)));
    end
    CHR_DIS(i,1) = sum(Calculating_CHR_DIS(i,:));
    CHR_DIS_Fitness(i,1) = 1/CHR_DIS(i,1);
end
%........Step_2_Connection b/w two consective Genes of a Chromosomes.......
[M,N] = size(Link);
for i=1:PopMax
    CHR_CONN(i,1) = 0;
    for j=1:(CHR_LEN-1)
        a = New_Pop(i,j);
        b = New_Pop(i,j+1);
        for k=1:N
            if Link(a,k) == b
                CHR_CONN(i,1) = CHR_CONN(i,1)+1;
            end
        end
    end
end
%............Step_3_Fitness of Chromosomes Based On Connections............
for i=1:PopMax
    
    CHR_CONN_Fitness(i,1) = CHR_CONN(i,1)/CHR_LEN; % Fitness of One/Chromosome Length
end
%.....................Step_4_Chromosome Final Fitness......................
for i=1:PopMax
    CHR_Fitness(i,1) = CHR_DIS_Fitness(i) + (CHR_CONN_Fitness(i));
    CHR_Fitness(i,1) = CHR_Fitness(i,1);
end



end