let senha = "abc";

while(true){
    let entrada = prompt("Entre com a senha: ");

    if (entrada != senha){
        console.log("Senha incorreta.");
    }else{
        console.log("Acesso liberado");
        break;
    }
} 
