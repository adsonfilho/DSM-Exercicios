class Numero{
  nros: number[] = [];

  add(nro: number): void{
    this.nros.push(nro);
  }

  sum(): number{
    let s = 0;
    
    for(let i = 0; i < this.nros.length; i++){
      s += this.nros[i];
    }

    return s;
  }

  max(): number{
    let maior = this.nros[0];

    for(let i = 1; i < this.nros.length; i++){
      if(this.nros[i] > maior){
        maior = this.nros[i];
      }
    }

    return maior;
  }
}

let n = new Numero();
n.add(8);
n.add(2);
n.add(9);
n.add(4);
n.add(5);

console.log(`Somatório: ${n.sum()}`);
console.log(`Maior: ${n.max()}`);
