% configurations

q = 32; % number of queens
ppl_num = 1000; % population size, even number
gen_num = 100; % maximum number of generations
epoch_l = 10; % epoch period in generations
isle_num = 8; % number of islands

mtt_p = sqrt(1/(q*ppl_num)); % mutation probability, geometric mean of queen number and chromosome length
pair_num = ppl_num/2; % number of mating pairs 
bo_num = 5; % best 2 out of random bo_num pairing 
fit_max = ((q - 1)*q/2); % biggest fitness possible