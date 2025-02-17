class Filme{
  titulo: string;
  duracao: number;

  constructor(titulo: string, duracao: number){
    this.titulo = titulo;
    this.duracao = duracao;
  }

  print(): void{
    console.log(`O filme ${this.titulo} tem duração de ${this.duracao} minutos`);
  }
}

let deVoltaAoFuturo = new Filme("De Volta ao Futuro", 116);
let matrix = new Filme("Matrix", 136);

deVoltaAoFuturo.print();
matrix.print();
