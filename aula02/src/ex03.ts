class Aleatorio{
  get(): number {
    return Math.floor(Math.random() * 100+1);
  }
}

let numeroAleatorio = new Aleatorio();

for (let i = 0; i < 5; i++){
  console.log(numeroAleatorio.get());
}
