const numeros = [8,3,4,7,5,6,4];
let contador = 0;

while (contador < numeros.length){

    if(contador % 2 == 1){
        console.log(`${contador} : ${numeros[contador]}`);
    }

    contador++;
}