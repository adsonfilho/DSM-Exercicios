const entradas = [9,2,4,5,8];
const saidas = [3,5,2,7,4];
let contador = 0;

while (contador < entradas.length){

    maior = entradas[contador] > saidas[contador] ? entradas[contador] : saidas[contador]

    console.log(`${contador} : ${maior}`);
    contador++;
}