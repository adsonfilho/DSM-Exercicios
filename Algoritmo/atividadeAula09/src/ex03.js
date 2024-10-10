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

pesoP1 = disciplina.pesos.p1;
pesoP2 = disciplina.pesos.p2;
pesoProjeto = disciplina.pesos.projeto
notaP1 = disciplina.notas.p1;
notaP2 = disciplina.notas.p2;
notaProjeto = disciplina.notas.projeto

console.log("Nota final:", pesoP1 * notaP1 + pesoP2 * notaP2 + pesoProjeto * notaProjeto);
