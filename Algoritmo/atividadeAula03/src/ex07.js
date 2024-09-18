let maior = 0;
let num = 0;
let entradas = 0;

while (entradas < 5){

    num = parseInt(prompt("Entre com um numero: "));
    maior = entradas == 0 ? num : maior;
    
    if (num > maior){
        maior = num;
    }

    entradas++;
}

console.log("maior valor: " + maior);