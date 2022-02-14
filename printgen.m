
    fprintf(file_data, "\n\n\nGen %d: \nPopulation: \n", gen_flg); 
    printppl(file_data, ppl); 

    fprintf(file_data, "\n\nPairs: \n"); 
    for pair_flg = 1 : pair_num 
        fprintf(file_data, "%d ", ppl_paired(pair_flg*2 - 1, :)); 
        fprintf(file_data, "\n"); 
        fprintf(file_data, "%d ", ppl_paired(pair_flg*2, :)); 
        fprintf(file_data, "\n"); 
        fprintf(file_data, "%d ", crov_token(pair_flg)); 
        fprintf(file_data, "\n\n"); 
    end 

    fprintf(file_data, "\n\nMutated offspring: \n"); 
    printppl(file_data, offspr_mtd); 

    fprintf(file_data, "\n\nAll survivors: \n"); 
    printppl(file_data, happy_darwinian); 