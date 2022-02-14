function ppl_epoch = isle(ppl_ini) 

%gen_data = "Generation Data.txt"; 
%delete(gen_data); 
%file_data = fopen(gen_data, 'a'); 

% for every generation
for gen_flg = 1 : epoch_l

    fprintf("%d\n", gen_flg); 
    % local pooling and pairing, best 2 out of random bo_num 
    grp_token = floor(rand(bo_num, pair_num)*ppl_num) + 1; 
    for pair_flg = 1 : pair_num 
        ppl_pool = ppl(grp_token(:, pair_flg), :); 
        [ppl_bo, ppl_bo_fit] = fitnsort(ppl_pool); 
        ppl_paired(pair_flg*2 - 1 : pair_flg*2, :) = ppl_bo(1:2, :); 
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
    survivor = [ppl; offspr_mtd]; 
    [happy_darwinian, happy_darwinian_fit] = fitnsort(survivor); 

    % print by generation
    %printgen; 

    % next generation, kill the latter half
    ppl_epoch = happy_darwinian(1:ppl_num, :); 

    %if (happy_darwinian_fit(ppl_num) == 0) 
    %    break; 
    %end

end

%fclose('all'); 

end