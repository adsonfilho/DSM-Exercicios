import { Request, Response } from "express";
import Jogo from "../models/Jogo";
import mongoose from "mongoose";

export const getJogos = async (req: Request, res: Response) => {
  try {
    const jogos = await Jogo.find();
    res.json(jogos);
  } catch {
    res.status(500).json({ error: "Erro ao buscar jogos" });
  }
};

export const createJogo = async (req: Request, res: Response) => {
  try {
    const novoJogo = new Jogo(req.body);
    const jogoSalvo = await novoJogo.save();
    res.status(201).json(jogoSalvo);
  } catch (err) {
    res.status(400).json({ error: (err as Error).message });
  }
};

export const updateJogo = async (req: Request, res: Response) => {
  const { id } = req.params;

  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(400).json({ error: "ID inválido" });
  }

  try {
    const jogoAtualizado = await Jogo.findByIdAndUpdate(id, req.body, {
      new: true,
      runValidators: true,
    });

    if (!jogoAtualizado) {
      return res.status(404).json({ error: "Jogo não encontrado" });
    }

    res.json(jogoAtualizado);
  } catch (err) {
    res.status(400).json({ error: (err as Error).message });
  }
};

export const deleteJogo = async (req: Request, res: Response) => {
  const { id } = req.params;

  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(400).json({ error: "ID inválido" });
  }

  try {
    const jogoRemovido = await Jogo.findByIdAndDelete(id);
    if (!jogoRemovido) {
      return res.status(404).json({ error: "Jogo não encontrado" });
    }
    res.json({ mensagem: "Jogo removido com sucesso" });
  } catch {
    res.status(500).json({ error: "Erro ao remover o jogo" });
  }
};
