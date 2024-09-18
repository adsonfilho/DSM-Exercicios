let numero = parseInt(prompt("Entre com um numero: "));
let numero2 = parseInt(prompt("Entre com um numero: "));
let numero3 = parseInt(prompt("Entre com um numero: "));

let maior = numero;

if (maior > numero2 && maior > numero3){
    console.log("Maior: " + maior);
}else if(maior > numero2 && maior < numero3){
    maior = numero3;
    console.log("Maior: " + maior);
}else{
    maior = numero2;
    console.log("Maior: " + maior)
}