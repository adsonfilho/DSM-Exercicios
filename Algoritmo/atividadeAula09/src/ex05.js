const disciplina = {
    nome: "Algoritmos",
    carga: 80,
        notas: [
        {
            peso: 0.25,
            nota: 8.2
        },
        {
            peso: 0.35,
            nota: 7.5
        },
        {
            peso: 0.4,
            nota: 9
        }
    ]
};


pesoP1 = disciplina.notas[0].nota;
pesoP2 = disciplina.notas[1].nota;
pesoProjeto = disciplina.notas[2].nota;
notaP1 = disciplina.notas[0].peso;
notaP2 = disciplina.notas[1].peso;
notaProjeto = disciplina.notas[2].peso;

console.log("Nota final:", pesoP1 * notaP1 + pesoP2 * notaP2 + pesoProjeto * notaProjeto);
