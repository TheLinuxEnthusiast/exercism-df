#!/usr/bin/gawk -f
@namespace "matrix"

function read(filename, matrix_var) {
    i = 1
    while ((getline < filename) > 0){
        for (j = 1; j <= NF; ++j)
            matrix_var[i][j] = $j
        ++i
    }
    close(filename)
}

function row(matrix_var, row_num) {
    for(j=1; j <= length(matrix_var[row_num]); j++){
        result = result " " matrix_var[row_num][j]
    }
    return substr(result, 2)
}

function column(matrix_var, column_num) {
    for(i=1; i <= length(matrix_var); i++){
        result = result " " matrix_var[i][column_num]
    }
    return substr(result,2) 
}

#Testing only
#BEGIN {
#    matrix::read("input.txt", matrix_var)
#    matrix::row(matrix_var, 2)
#    }