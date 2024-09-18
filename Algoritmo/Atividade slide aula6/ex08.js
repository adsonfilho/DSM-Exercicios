function matriz(matrix){

    let linha = 0;
    let somatoria = 0;

    while (linha <= matrix.length - 1){
        coluna = 0;
        while (coluna <= matrix.length - 1){
            somatoria+=matrix[linha][coluna];
            coluna++;
        }
        linha++;
    }

    return somatoria;
}

numeros = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8 ,9]
];

s = matriz(numeros);
console.log("Somatoria: " + s);
