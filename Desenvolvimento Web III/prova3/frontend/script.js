const API = "http://localhost:3000/reservas";

// CRIAR OU ATUALIZAR
async function salvarReserva() {
    const id = document.getElementById("idReserva").value;

    const dados = {
        nomeCliente: document.getElementById("nomeCliente").value,
        contatoCliente: document.getElementById("contatoCliente").value,
        numeroMesa: document.getElementById("numeroMesa").value,
        quantidadePessoa: document.getElementById("quantidadePessoa").value,
        dataReserva: document.getElementById("dataReserva").value ,
        observacoes: document.getElementById("observacoes").value || undefined,
        status: document.getElementById("status").value
    };

    if (id) {
        // ATUALIZAR
        await fetch(`${API}/${id}`, {
            method: "PUT",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(dados)
        });

        alert("Reserva atualizada!");
    } else {
        // CRIAR
        await fetch(API, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(dados)
        });

        alert("Reserva criada!");
    }

    limparFormulario();
    listarReservas();
}

// LIMPAR FORMULÁRIO
function limparFormulario() {
    document.getElementById("idReserva").value = "";
    document.getElementById("nomeCliente").value = "";
    document.getElementById("contatoCliente").value = "";
    document.getElementById("numeroMesa").value = "";
    document.getElementById("quantidadePessoa").value = "";
    document.getElementById("dataReserva").value = "";
    document.getElementById("observacoes").value = "";
    document.getElementById("status").value = "disponivel";

    document.getElementById("btnSalvar").innerText = "Cadastrar";
    document.getElementById("form-title").innerText = "Cadastrar Reserva";
}

// LISTAR
async function listarReservas() {
    const resp = await fetch(API);
    const reservas = await resp.json();

    const box = document.getElementById("listaReservas");
    box.innerHTML = "";

    reservas.forEach(s => {
        box.innerHTML += `
            <div class="reserva-card">
                <h3>${s.nomeCliente}</h3>
                <p>${s.contatoCliente}</p>
                <p><b>Numero Mesa:</b> ${s.numeroMesa}</p>
                <p><b>Quantidade pessoas:</b> ${s.quantidadePessoa}</p>
                <p><b>Data reserva:</b> ${s.dataReserva ? s.dataReserva.substring(0, 10) : "—"}</p>
                <p><b>Observacoes:</b>${s.observacoes}</p>
                <p><b>Status:</b>${s.status}</p>

                <button onclick="editarReserva('${s._id}')">Editar</button>
                <button onclick="excluirReserva('${s._id}')">Excluir</button>
            </div>
        `;
    });
}

// CARREGAR PARA EDIÇÃO
function editarReserva(id) {
    fetch(API)
        .then(res => res.json())
        .then(reservas => {
            const s = reservas.find(x => x._id === id);

            document.getElementById("idReserva").value = s._id;
            document.getElementById("nomeCliente").value = s.nomeCliente;
            document.getElementById("contatoCliente").value = s.contatoCliente;
            document.getElementById("quantidadePessoa").value = s.quantidadePessoa;
            document.getElementById("numeroMesa").value = s.numeroMesa;
            document.getElementById("observacoes").value = s.observacoes || "";
            document.getElementById("status").value = s.status;
            document.getElementById("dataReserva").value = s.dataReserva ? s.dataReserva.substring(0, 10) : "";

            document.getElementById("btnSalvar").innerText = "Salvar Alterações";
            document.getElementById("form-title").innerText = "Editar Reserva";
        });
}

// EXCLUIR
async function excluirReserva(id) {
    const confirmar = confirm("Deseja excluir esta reserva?");
    if (!confirmar) return;

    const resp = await fetch(`${API}/${id}`, { method: "DELETE" });

    const data = await resp.json();
    
    if (resp.ok){
        alert("Reserva excluida")
        listarReservas();
    }else{
        alert("Erro: " + data.error)
    }
    
}

listarReservas();
