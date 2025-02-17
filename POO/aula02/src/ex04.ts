class Carro{
  marca: string = "";
  modelo: string = "";

  setMarca(marca: string): void{
    this.marca = marca;
  }

  setModelo(modelo: string): void{
    this.modelo = modelo;
  }

  print(): void{
    console.log(`${this.marca} ${this.modelo}`);
  }
}

let carro1 = new Carro();
let carro2 = new Carro();

carro1.setModelo("Gol");
carro1.setMarca("Volkswagen");

carro2.setModelo("Uno");
carro2.setMarca ("Fiat");

carro1.print();
carro2.print();
