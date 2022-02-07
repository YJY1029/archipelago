% configurations

q = 8; % number of queens
ppl_num = 1000; % population size
gen_num = 100; % number of generations
pool_coef = 0.2; % proportion of CASTRATED population

mtt_p = sqrt(1/(q*ppl_num)); % mutation probability, geometric mean of queen number and chromosome length
pair_num = ppl_num/2; % number of mating pairs
fit_max = ((q - 1)*q/2); % biggest fitness possible

% run scripts
main; 