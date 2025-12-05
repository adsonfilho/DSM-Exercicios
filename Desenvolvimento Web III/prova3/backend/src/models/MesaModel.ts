import mongoose, { Schema } from "mongoose";

const MesaSchema = new Schema({
    numeroMesa: { 
        type: Number, 
        required: true 
    },
    capacidade: { 
        type: Number,
        required: true,
        min: 1
    },
    localizacao: { 
        type: String, 
        required: true
    }
});

export default mongoose.model("Mesa", MesaSchema);


