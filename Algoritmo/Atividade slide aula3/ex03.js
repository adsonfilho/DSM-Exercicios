let num1 = parseInt(prompt("Entre com um valor: "));
let num2 = parseInt(prompt("Entre com um valor: "));


if(num1 > num2){
    [num1, num2] = [num2, num1]
}

while (num1 <= num2){
    console.log(num1++);
}