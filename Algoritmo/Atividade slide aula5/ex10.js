const matriz = [
    [9,2,4],
    [6,5,7],
    [2,1,3]
];

let linha = 0;
let coluna = 0;

while(linha < matriz.length){
    while(coluna < matriz.length){

        if(linha == coluna){
            console.log(matriz[linha][coluna]);            
        }
        coluna++;
    }
    coluna = 0;
    linha++;
}
