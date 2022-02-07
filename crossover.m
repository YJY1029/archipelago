function offspr = crossover(dad, mom, site)
%CROSSOVER standard order one permutation crossover
%   NULL

q = length(dad); 
for queen_flg_1 = 1 : site 
    for queen_flg_2 = queen_flg_1 : q 
        if (dad(queen_flg_1) == mom(queen_flg_2)) 
            queen_swap = mom(queen_flg_1); 
            mom(queen_flg_1) = mom(queen_flg_2); 
            mom(queen_flg_2) = queen_swap; 
            break; 
        end 
    end 
end 

head = dad(1 : site - 1); 
tail = mom(site : q); 
offspr = [head, tail]; 

end