let nros = "5,8,4,2,9,6,1,7,3";

nros = nros.split(",");

for(i=0; i <= nros.length-1; i++){
    if (parseInt(nros[i]) % 2 == 0){
        console.log(nros[i]);
    }
}
