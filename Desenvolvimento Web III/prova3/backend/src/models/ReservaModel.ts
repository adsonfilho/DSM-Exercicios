import mongoose, { Schema } from "mongoose";

const ReservaSchema = new Schema({
    nomeCliente: { 
        type: String, 
        required: [true, "É necessario informar o nome do cliente"]
    },
    contatoCliente: { 
        type: String,
        required: [true, "É necessario informar o contato do cliente"]
    },
    numeroMesa: { 
        type: Number, 
        required: [true, "Informe o numero da mesa"]
    },
    quantidadePessoa: { 
        type: Number, 
        required: [true, "Informe a quantidade de pessoas"] 
    },
    dataReserva: { 
        type: Date, 
        required: [true, "Informe a data reservada"] 
    },
    observacoes: {
        type: String,
    },
    status: {
        type: String, 
        required: [true, "É necessario informar o status da reserva"],
        default: "disponivel",
        enum: ["reservado", "ocupado", "finalizado", "cancelado", "disponivel"]
    } 
});

export default mongoose.model("Reserva", ReservaSchema);


