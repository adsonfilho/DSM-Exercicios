let somatorio = 0;
let num = 0;
let entradas = 0;

while (entradas < 5){
    num = parseInt(prompt("Entre com um numero: "));
    somatorio += num;
    entradas++;
}

console.log("Somatorio: " + somatorio);