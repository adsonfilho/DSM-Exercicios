let nros = "5,8,4,2,9,6,1,7,3";
let somatorio = 0;
nros = nros.split(",");

for(i=0; i <= nros.length-1; i++){
    somatorio = somatorio + parseInt(nros[i]);
}

console.log("Somatorio: " + somatorio);
