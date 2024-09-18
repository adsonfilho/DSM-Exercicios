function somatorio(array){

    let cont = array.length-1;
    let somatorio = 0;
    console.log("Lista: ");
    
    while (cont >= 0){
        somatorio = somatorio + array[cont]
        cont--; 
    }

    return somatorio
}

numeros = [8, 3, 4, 7, 5];
s = somatorio(numeros);
console.log("Somatório: " + s);
