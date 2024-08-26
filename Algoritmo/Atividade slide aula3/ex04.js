let num1 = parseInt(prompt("Entre com um valor: "));
let num2 = parseInt(prompt("Entre com um valor: "));
let somatorio = 0;

if(num1 > num2){
    [num1, num2] = [num2, num1]
}

while (num1 <= num2){
    somatorio+=num1;
    num1++;
}

console.log("Somatorio:" + somatorio);