% configurations

% population param 
q = 32; % number of queens
ppl_num = 2000; % population size, even number 
isle_num = 8; % number of islands
ppl_num_sum = isle_num*ppl_num; % sum of overall population 

% time param 
epoch_l = 10; % epoch period in generations
epoch_num = 1000; % maximum number of epochs 
gen_num = epoch_l*epoch_num; % maximum number of generations

% evolution param
mtt_p = (1/q + 1/ppl_num)/2; % mutation probability 
pair_num = 3*ppl_num/2; % number of mating pairs, lambda = 3*mu 
bo_num = 5; % best 2 out of random bo_num pairing 

% files 
rslt_data = "Results.txt"; % txt file for result data storage 
gen_data = "Generation Data.txt"; % txt file for data storage by generation 