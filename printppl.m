function printppl(fid, ppl)
%PRINTPPL Print population
%   NULL
ppl_num = size(ppl, 1); 
for ppl_flg = 1 : ppl_num 
    fprintf(fid, "%d ", ppl(ppl_flg, :)); 
    fprintf(fid, "\n"); 
end 

end