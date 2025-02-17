
const salarioMensal:number = 3000;
const percentualAjuste:number = 10;

const salarioAjustado:number = salarioMensal + (salarioMensal * percentualAjuste / 100);

console.log(`Salario antigo: ${salarioMensal}`);
console.log(`Salario ajustado: ${salarioAjustado}`);
