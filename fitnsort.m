function [mtx_asc,fit_asc] = fitnsort(mtx)
%FITNSORT sort a matrix, return fitness and data matrix in ascending order
%   NULL
[unit_num, q] = size(mtx); 
for unit_flg = 1 : unit_num 
    fit = 0; 
    for atker = 1 : q-1 
        for atkee = atker + 1 : q 
            fit_unit = abs(mtx(unit_flg,atker) - mtx(unit_flg,atkee)); 
            if (fit_unit == atkee - atker) || (fit_unit == 0) 
                fit = fit + 1; 
            end
        end
    end
    fit_asc(unit_flg) = fit; 
end

%bubble sort
mtx_asc = mtx; 
for mtx_flg_1 = 1 : unit_num - 1
    for mtx_flg_2 = mtx_flg_1 + 1 : unit_num 
        if(fit_asc(mtx_flg_1) > fit_asc(mtx_flg_2)) 
            fit = fit_asc(mtx_flg_1); %if bigger fitness, swap fitness
            fit_asc(mtx_flg_1) = fit_asc(mtx_flg_2); 
            fit_asc(mtx_flg_2) = fit; 

            unit = mtx_asc(mtx_flg_1, :); %and units
            mtx_asc(mtx_flg_1, :) = mtx_asc(mtx_flg_2, :); 
            mtx_asc(mtx_flg_2, :) = unit; 
        end
    end
end

end