const disciplina = {
    nome: "Algoritmos",
    carga: 80,
    pesos: [0.25,0.35,0.4],
    notas: [8.2,7.5,9]
};

pesoP1 = disciplina.pesos[0];
pesoP2 = disciplina.pesos[1];
pesoProjeto = disciplina.pesos[2];
notaP1 = disciplina.notas[0];
notaP2 = disciplina.notas[1];
notaProjeto = disciplina.notas[2];

console.log("Nota final:", pesoP1 * notaP1 + pesoP2 * notaP2 + pesoProjeto * notaProjeto);
