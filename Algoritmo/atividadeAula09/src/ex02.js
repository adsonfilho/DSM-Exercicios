const disciplina = {
    nome: "Algoritmos",
    carga: 80,
    pesos: {
        p1: 0.25,
        p2: 0.35,
        projeto: 0.4
    },
    notas: {
        p1: 8.2,
        p2: 7.5,
        projeto: 9
    }
};

console.log("P1:", disciplina.pesos.p1);
console.log("P2:", disciplina.pesos.p2);
console.log("P3:", disciplina.pesos.projeto);
