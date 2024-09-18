let nome = prompt("Entre com o nome: ");
let tamanho = 0;


while (tamanho < nome.length){

    if(tamanho % 2 == 0){
        console.log(nome[tamanho]);
    }

    tamanho++;
}