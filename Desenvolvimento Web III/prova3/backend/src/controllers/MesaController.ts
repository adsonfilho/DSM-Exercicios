import { Request, Response } from "express";
import Mesa from "../models/MesaModel";

export default {
    async create(req: Request, res: Response) {
        try {
            const reserva = await Mesa.create(req.body);
            return res.status(201).json({ message: "Mesa criada!", reserva });
        } catch (err) {
            return res.status(400).json({ error: err });
        }
    },

    async list(req: Request, res: Response) {
        try {
            const reserva = await Mesa.find();
            return res.json(reserva);

        } catch (error) {
            return res.status(500).json({ error: "Erro ao listar as mesas" });
        }
    },

    async update(req: Request, res: Response) {
        try {
            const reserva = await Mesa.findByIdAndUpdate(req.params.id, req.body, { new: true });
            return res.json({ message: "Mesa atualizada!", reserva });
        } catch (err) {
            return res.status(400).json({ error: err });
        }
    },

    async delete(req: Request, res: Response) {
        try {
            const { id } = req.params;

            await Mesa.findByIdAndDelete(id);

            return res.json({ message: "Mesa removida com sucesso!" });

        } catch (error) {
            return res.status(500).json({ error: "Erro ao excluir a mesa." });
        }
    }
}
