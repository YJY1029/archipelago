function printppl(fid, ppl)
%PRINTPPL Print population
%   NULL
ppl_num = length(ppl); 
for ppl_flg = 1 : ppl_num 
    fprintf(fid, "%d", ppl(ppl_flg, :)); 
    fprintf(fid, " "); 
end 

end