% configurations
config; 

% run scripts
% initializing islands and populations
tic; 
if (gcp('nocreate') == 0) 
    archipelago = parpool(isle_num); 
else 
    archipelago = gcp; 
end

ppl = Composite(); 
for isle_flg = 1 : isle_num 
    for ppl_flg = 1 : ppl_num 
        ppl_temp(ppl_flg, :) = randperm(q); 
        ppl{isle_flg} = ppl_temp; 
    end
end
fprintf("Initialization time: \n"); 
toc; 

tic; 

for epoch_flg = 1 : epoch_num 

    fprintf("Epoch %d completed. \n", epoch_flg); 
    % run isles
    spmd
        [ppl_next, ppl_next_fit] = isle(ppl); 
    end

    % population exchange, random half
    perfect_ppl = 0; 
    xchg_token = randperm(ppl_num); 
    for isle_flg = 1 : isle_num - 1 
        perfect_ppl_unit = ppl_next_fit{isle_flg}; 
        perfect_ppl = perfect_ppl + perfect_ppl_unit(end); 
        % composites only support simple subscripting??? 
        % stash composite data in temps 
        ppl_1 = ppl_next{isle_flg}; 
        if (isle_flg ~= isle_num) 
            ppl_2 = ppl_next{isle_flg+1}; 
        else 
            ppl_2 = ppl_next{1}; 
        end 
        ppl_swap = ppl_1(xchg_token(1 : ppl_num/2), :); 
        ppl_1(xchg_token(1 : ppl_num/2), :) = ppl_2(xchg_token(1 : ppl_num/2), :); 
        ppl_2(xchg_token(1 : ppl_num/2), :) = ppl_swap; 

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
fprintf("Run time: \n"); 
toc; 

delete(rslt_data); 
file_rslt = fopen(rslt_data, 'a'); 

% BINGO! on every island 
spmd 
    isle_bingo_pos = find(ppl_next_fit == 0); 
    isle_bingo = ppl_next(isle_bingo_pos, :); 
    isle_bingo_uniq = unique(isle_bingo, 'rows'); 
end

% BINGO! overall 
bingo = []; 
for isle_flg = 1 : isle_num 
    bingo = [bingo; isle_bingo{isle_flg}]; 
end 
bingo_uniq = unique(bingo, 'rows'); 

% print overall results 
fprintf(file_rslt, "Congratulations! \nAfter %d epochs (%d generations), you found %d sets of successful patterns for this %d-queen problem with %d islands in popolation sizes of %d! \nThey are (by rows): \n", epoch_flg, epoch_l*epoch_flg, size(bingo_uniq, 1), q, isle_num, ppl_num); 
printppl(file_rslt, bingo_uniq); 

% boardize
fprintf(file_rslt, "\n\ni.e. \n"); 
for board_flg = 1 : size(bingo_uniq, 1) 
    fprintf(file_rslt, "Pattern %d \n", board_flg); 
    chessbd(file_rslt, bingo_uniq(board_flg, :)); 
end

% print by island 
fprintf(file_rslt, "\n\nFor unique solutions by island: "); 
for isle_flg = 1 : isle_num 
    fprintf(file_rslt, "\n%d solutions on island %d: \n", size(isle_bingo_uniq{isle_flg}, 1), isle_flg); 
    printppl(file_rslt, isle_bingo_uniq{isle_flg}); 
end 

% final generation 
if (size(bingo, 1) == ppl_num_sum) 
    fprintf(file_rslt, "\n\nBy the way, all populations in the final generation are good boys and good girls! \n"); 
else 
    fprintf(file_rslt, "\n\nThere are altogether %d perfect guys out of the population sum of %d: \n", size(bingo, 1), ppl_num_sum); 
    for isle_flg = 1 : isle_num 
        fprintf(file_rslt, "%d individuals on island %d: \n", size(isle_bingo{isle_flg}, 1), isle_flg); 
        printppl(file_rslt, isle_bingo{isle_flg}); 
    end 
    fprintf(file_rslt, "\n\nAnd populations of the final generation are: \n"); 
end

for isle_flg = 1 : isle_num 
    fprintf(file_rslt, "\nIsland %d: \n", isle_flg); 
    printppl(file_rslt, ppl_next{isle_flg}); 
end 

fclose('all'); 
disp("Let's go to check .txt files!"); 

% comment this if you would like to check running results in MATLAB manually
delete(archipelago); 