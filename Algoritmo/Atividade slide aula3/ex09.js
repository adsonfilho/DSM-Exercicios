let senha = "abc";
let tentativa = 0;

while(true){
    let entrada = prompt("Entre com a senha: ");
    
    if (entrada != senha){
        if (tentativa == 2){
            console.log("Numero de tentativas acabou");
            break;
        }else{
            console.log("Senha incorreta.");
            tentativa++;
        }
    }else{
        console.log("Acesso liberado");
        break;
    }
} 
