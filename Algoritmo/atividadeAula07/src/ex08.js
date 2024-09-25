let nros = "8, 2, 3, 5, 9";
let somatorio = 0;

nros = nros.split(",");

for(i=0; i <= nros.length-1; i+=2){
    if (i % 2 == 0){
        somatorio = somatorio + parseInt(nros[i]);
    }
}
 
console.log("Somatorio: " + somatorio);
