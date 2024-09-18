const pesos = [0.4,0.2,0.1,0.3];
const notas = [8.2,5.0,10.0,9.1];
let contador = 0;

while (contador < notas.length){

    console.log(`${pesos[contador]} * ${notas[contador]} = ${pesos[contador] * notas[contador]}`);
    contador++;
}
