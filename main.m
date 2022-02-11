% initial population
for ppl_flg = 1 : ppl_num 
    ppl(ppl_flg, :) = randperm(q); 
end

gen_data = "Generation Data.txt"; 
rslt_data = "Results.txt"; 
delete(gen_data); 
delete(rslt_data); 
file_data = fopen(gen_data, 'a'); 

% for every generation
tic; 
fprintf("Let's count to %d: \n", gen_num);
for gen_flg = 1 : gen_num
    % countdown
    fprintf("%d!\n", gen_flg); 

    % parent fitness and bubble sort
    [ppl_asc, ppl_fit_asc] = fitnsort(ppl); 

    % 20% replacement mating pool generation 
    ppl_pool = [ppl_asc(1 : ppl_num*pool_coef, :); ppl_asc(1 : ppl_num*pool_coef, :); ppl(ppl_num*pool_coef + 1 : ppl_num*(1 - pool_coef), :)]; 

    % pairing by random token
    pair_token = randperm(ppl_num); 
    for pair_flg = 1 : pair_num 
        ppl_paired(pair_flg*2 - 1, :) = ppl_pool(pair_token(pair_flg*2 - 1), :); 
        ppl_paired(pair_flg*2, :) = ppl_pool(pair_token(pair_flg*2), :); 
    end

    % order 1 crossover by random token
    crov_token = floor(rand(1, pair_num)*q) + 1; 
    for pair_flg = 1 : pair_num 
        parent_1 = ppl_paired(pair_flg*2 - 1, :); 
        parent_2 = ppl_paired(pair_flg*2, :); 
        son(pair_flg, :) = crossover(parent_1, parent_2, crov_token(pair_flg)); 
        daughter(pair_flg, :) = crossover(parent_2, parent_1, crov_token(pair_flg)); 
    end
    offspr = [son; daughter]; 

    % swapping mutation
    offspr_mtd = offspr; 
    for ppl_flg = 1 : ppl_num 
        for queen_flg = 1 : q 
            if (rand(1) < mtt_p) 
                queen_swap = floor(rand(1,1)*q) + 1; 
                offspr_mtd(ppl_flg, queen_flg) = offspr(ppl_flg, queen_swap); 
                offspr_mtd(ppl_flg, queen_swap) = offspr(ppl_flg, queen_flg); 
            end
        end
    end

    % survivor fitness and bubble sort 
    survivor = [ppl_asc; offspr_mtd]; 
    [happy_darwinian, happy_darwinian_fit] = fitnsort(survivor); 

    % print by generation
    %printgen; 

    % next generation, kill the latter half
    ppl = happy_darwinian(1:ppl_num, :); 

    if (ppl_fit_asc(ppl_num) == 0) 
        break; 
    end

end

fclose('all'); 
toc; 

file_rslt = fopen(rslt_data, 'a'); 

% BINGO! 
bingo_pos = find(ppl_fit_asc == 0); 
bingo = ppl_asc(bingo_pos, :); 
bingo_unique = unique(bingo, 'rows'); 

% print results
fprintf(file_rslt, "Congratulations! After %d generations, you found %d sets of successful patterns for this %d-queen problem! \nThey are: \n", gen_flg, size(bingo_unique, 1), q); 
printppl(file_rslt, bingo_unique); 

% boardize
fprintf(file_rslt, "\n\ni.e. \n"); 
for board_flg = 1 : size(bingo_unique, 1) 
    fprintf(file_rslt, "Pattern %d: \n", board_flg); 
    chessbd(file_rslt, bingo_unique(board_flg, :)); 
end

% print final generation
if (size(bingo, 1) == ppl_num) 
    fprintf(file_rslt, "\n\nThe entire population of the final generation are good boys and good girls! They are: \n"); 
else 
    fprintf(file_rslt, "\n\nApart from these, there are altogether %d successful sets out of the population of %d: \n", size(bingo, 1), ppl_num); 
    printppl(file_rslt, bingo); 
    
    fprintf(file_rslt, "\n\nAnd population of the final generation are: \n"); 
end
printppl(file_rslt, ppl);

fclose('all'); 
disp("Let's go to check .txt files!"); 