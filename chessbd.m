function chessbd(file, pattern)
%CHESSBD convert pattern to chessboard
%   NULL

for queen_flg = 1 : length(pattern) 
    fprintf(file, '|'); 
    for clmn_flg = 1 : pattern(queen_flg) - 1 
        fprintf(file, ' |'); 
    end    
    fprintf(file, 'Q|'); 
    for clmn_flg = pattern(queen_flg) + 1 : length(pattern) 
        fprintf(file, ' |'); 
    end
    fprintf(file, '\n'); 
end

fprintf(file, '\n'); 

end