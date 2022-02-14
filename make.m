% configurations
config; %q, ppl_num, gen_num, isle_num, mtt_p, pair_num, fit_max 

% run scripts
% initializing islands and populations
islands = parpool(isle_num); 

ppl = Composite(); 
for isle_flg = 1 : isle_num 
    for ppl_flg = 1 : ppl_num 
        ppl{isle_flg}(ppl_flg, :) = randperm(q); 
    end
end

tic; 

for epoch_flg = 1 : gen_num/epoch_l
spmd
    ppl_next = isle(ppl{labindex}); 
  
end
toc; 

rslt_data = "Results.txt"; 
delete(rslt_data); 
file_rslt = fopen(rslt_data, 'a'); 

% BINGO! 
[ppl_asc, ppl_fit_asc] = fitnsort(ppl); 
bingo_pos = find(ppl_fit_asc == 0); 
bingo = ppl_asc(bingo_pos, :); 
bingo_unique = unique(bingo, 'rows'); 

% print results
fprintf(file_rslt, "Congratulations! After %d generations, you found %d sets of successful patterns for this %d-queen problem with a population of %d! \nThey are: \n", gen_flg, size(bingo_unique, 1), q, ppl_num); 
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