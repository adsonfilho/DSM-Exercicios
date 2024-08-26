let menor = 0;
let num = 0;
let entradas = 0;

while (entradas < 5){

    num = parseInt(prompt("Entre com um numero: "));
    menor = entradas == 0 ? menor=num : menor=menor;
    
    if (num < menor){
        menor = num;
    }

    entradas++;
}

console.log("Menor valor: " + menor);