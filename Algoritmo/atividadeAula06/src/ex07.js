function inverter(array){

    let cont = array.length-1;
    console.log("Lista: ");
    
    while (cont >= 0){
        console.log(`${cont} : ${array[cont]}`);
        cont--;
    }
}

numeros = [8, 3, 4, 7, 5];
inverter(numeros);