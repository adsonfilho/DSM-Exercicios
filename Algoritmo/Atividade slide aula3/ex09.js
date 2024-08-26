let senha = "abc";
let tentativa = 0;

while(tentativa < 3){
    let entrada = prompt("Entre com a senha: ");

    if (entrada != senha){
        console.log("Senha incorreta.");
        tentativa++;
    }else{
        console.log("Acesso liberado");
        break;
    }
} 