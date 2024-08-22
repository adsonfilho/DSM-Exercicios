let altura = parseFloat(prompt("Entre com a altura (m): "));
let peso = parseFloat(prompt("Entre com a peso (kg): "));

let imc = peso/(altura * altura);

if (imc > 40){
    console.log("Obesidade III (mórbita)");
}else if(imc >= 35.0 && imc <= 39.9 ){
    console.log("Obesidade grau II (severa)");
}else if(imc >= 30.0 && imc <= 34.9){
    console.log("Obesidade grau I");
}else if(imc >= 25.0 && imc <= 29.9){
    console.log("Levemente acima do peso");
}else if(imc >= 18.6 && imc <= 24.9){
    console.log("Peso ideal (parabens");
}else{
    console.log("Abaixo do peso");
}