const numeros = [8,3,4,7,5]
let contador = numeros.length-1;
let somatorio = 0;

while (contador >= 0){
    somatorio+=numeros[contador];
    contador--;
}

console.log("Somatorio " + somatorio);