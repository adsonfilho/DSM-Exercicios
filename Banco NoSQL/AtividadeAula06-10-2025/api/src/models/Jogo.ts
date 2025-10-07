import { Schema, model, Document } from "mongoose";

export interface IJogo extends Document {
  nome: string;
  categoria: string;
  preco: number;
  estoque: number;
}

const jogoSchema = new Schema<IJogo>({
  nome: { type: String, required: true },
  categoria: { type: String, required: true },
  preco: { type: Number, required: true },
  estoque: { type: Number, required: true },
});

export default model<IJogo>("Jogo", jogoSchema);
