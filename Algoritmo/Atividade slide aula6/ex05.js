function inverte(nome){
    let aux = "";
    let cont = nome.length-1;

    while (cont >= 0){
        aux = aux + nome[cont]
        cont--;
    } 
    return aux;
}

r = inverte("Pedro");
console.log("Invertido: " + r);
