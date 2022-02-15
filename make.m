% configurations
config; %q, ppl_num, gen_num, epoch_l, isle_num, mtt_p, pair_num 

% run scripts
% initializing islands and populations
if (gcp('nocreate') == 0) 
    islands = parpool(isle_num); 
else 
    islands = gcp; 
end

ppl = Composite(); 
for isle_flg = 1 : isle_num 
    for ppl_flg = 1 : ppl_num 
        ppl_temp(ppl_flg, :) = randperm(q); 
        ppl{isle_flg} = ppl_temp; 
    end
end

tic; 

for epoch_flg = 1 : epoch_num 

    fprintf("Epoch No.%d completed. \n", epoch_flg); 
    % run isles
    spmd
        [ppl_next, ppl_next_fit] = isle(ppl); 
    end

    % population exchange, 50%
    perfect_ppl = 0; 
    for isle_flg = 1 : isle_num 
        perfect_ppl_unit = ppl_next_fit{isle_flg}; 
        perfect_ppl = perfect_ppl + perfect_ppl_unit(ppl_num); 
        % composites only support simple subscripting?? 
        % stash composite data in temps 
        ppl_1 = ppl_next{isle_flg}; 
        if (isle_flg ~= isle_num) 
            ppl_2 = ppl_next{isle_flg+1}; 
        else 
            ppl_2 = ppl_next{1}; 
        end 
        ppl_swap = ppl_1(1 : ppl_num/2, :); 
        ppl_1(1 : ppl_num/2, :) = ppl_2(1 : ppl_num/2, :); 
        ppl_2(1 : ppl_num/2, :) = ppl_swap; 

        %pop data from stash 
        ppl_next{isle_flg} = ppl_1; 
        if (isle_flg ~= isle_num) 
            ppl_next{isle_flg+1} = ppl_2; 
        else 
            ppl_next{1} = ppl_2; 
        end 
    end

    % termination condition of perfect population on all islands 
    if (perfect_ppl == 0) 
        break; 
    end

end
toc; 

%delete(islands); 

%rslt_data = "Results.txt"; 
%delete(rslt_data); 
%file_rslt = fopen(rslt_data, 'a'); 
%
%% BINGO! 
%[ppl_asc, ppl_fit_asc] = fitnsort(ppl); 
%bingo_pos = find(ppl_fit_asc == 0); 
%bingo = ppl_asc(bingo_pos, :); 
%bingo_unique = unique(bingo, 'rows'); 
%
%% print results
%fprintf(file_rslt, "Congratulations! After %d generations, you found %d sets %of successful patterns for this %d-queen problem with a population of %d! %\nThey are: \n", gen_flg, size(bingo_unique, 1), q, ppl_num); 
%printppl(file_rslt, bingo_unique); 
%
%% boardize
%fprintf(file_rslt, "\n\ni.e. \n"); 
%for board_flg = 1 : size(bingo_unique, 1) 
%    fprintf(file_rslt, "Pattern %d: \n", board_flg); 
%    chessbd(file_rslt, bingo_unique(board_flg, :)); 
%end
%
%% print final generation
%if (size(bingo, 1) == ppl_num) 
%    fprintf(file_rslt, "\n\nThe entire population of the final generation %are good boys and good girls! They are: \n"); 
%else 
%    fprintf(file_rslt, "\n\nApart from these, there are altogether %d %successful sets out of the population of %d: \n", size(bingo, 1), %ppl_num); 
%    printppl(file_rslt, bingo); 
%    
%    fprintf(file_rslt, "\n\nAnd population of the final generation are: \n")%; 
%end
%printppl(file_rslt, ppl);
%
%fclose('all'); 
%disp("Let's go to check .txt files!"); 