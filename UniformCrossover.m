function [y1, y2] = UniformCrossover(x1, x2,End_Index)


  %  alpha = unifrnd(-gamma, 1+gamma, size(x1));
    a= numel(x1) -2 ;
    alpha = randi([0, 1], 1,a);
    y1 = alpha.*x1(2:(a+1)) + (1-alpha).*x2(2:(a+1));
    y2 = alpha.*x2(2:(a+1)) + (1-alpha).*x1(2:(a+1));
    
    y1= [1 y1 End_Index ];
    y2= [1 y2 End_Index ];
end