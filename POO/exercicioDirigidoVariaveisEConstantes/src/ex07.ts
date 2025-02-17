
const votosBrancos:number = 20
const votosNulos:number = 30  
const votosValidos:number = 40

const totalVotos:number = votosBrancos + votosNulos + votosValidos;

const percentualVotosBrancos:number = (votosBrancos / totalVotos) * 100;
const percentualVotosNulos:number = (votosNulos / totalVotos) * 100;
const percentualVotosValidos:number = (votosValidos / totalVotos) * 100;

console.log(`Percentual de votos brancos: ${percentualVotosBrancos}%`);
console.log(`Percentual de votos nulos: ${percentualVotosNulos}%`);
console.log(`Percentual de votos válidos: ${percentualVotosValidos}%`);
