function y = Mutate(x, mu,Link)


%Making falag that indicate which gene should be replaed
flag = (rand(size(x)) < mu);
a= numel(x)  ;
 y = x;

  for i = 2:a-1
      
          if flag(i) == true

                   switch i

                        case 1
                              j=[1];
                          
                        case 2
                            %making the near possible indexes of points
                              j=[2,5,4,3,10,11];

                        case 3
                             j= [11,18,14,13,16];
                      
                        case 4
                             j= [19,16,17,15,20,12];
                        case 5
                             j= [19,17,20,22,21,24,27,25,28];
 
                        case 6
                             j= [28,25,29,31,27,24];

                       otherwise
                           
                            j= [21:36];
                   end
              %sellecting a random index
              M=randi(numel(j)) ;
              %selecting the possible solutions for the index
              N = sum(Link(j(M)+1,:) > 0);
              r = randi([1,N],1,1);
              %selecting the upcong index value for the gene
              y(i) =Link(j(M)+1,r);

          end

  end

    
end