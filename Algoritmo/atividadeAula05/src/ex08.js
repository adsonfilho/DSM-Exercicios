const pesos = [0.4,0.2,0.1,0.3];
const notas = [8.2,5.0,10.0,9.1];
let contador = 0;
let somatorio = 0;

while (contador < notas.length){

    somatorio+=(pesos[contador] * notas[contador]);

    contador++;
}

console.log("Nota final " + somatorio);
