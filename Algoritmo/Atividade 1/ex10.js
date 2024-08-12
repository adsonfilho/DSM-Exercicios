let i = 0;
while (i < 6){
    nro = Math.random()*100;
    nro = Math.floor(nro);
    if(nro < 50){
        if(nro % 2 == 1){
            console.log(nro);
            i = i + 1;
        }
    }else{
        if(nro % 2 == 0){
            console.log(nro);
            i = i + 1;
        }
    }
}