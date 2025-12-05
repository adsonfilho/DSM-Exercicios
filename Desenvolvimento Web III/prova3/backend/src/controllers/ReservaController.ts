import { Request, Response } from "express";
import Reserva from "../models/ReservaModel";

export default {
    async create(req: Request, res: Response) {
        try {
            const reserva = await Reserva.create(req.body);
            return res.status(201).json({ message: "Reserva criada!", reserva });
        } catch (err) {
            return res.status(400).json({ error: err });
        }
    },

    async list(req: Request, res: Response) {
        try {
            const { cliente, mesa, data, status } = req.query;

            const filter: any = {};

            if (cliente) {
                filter.cliente = cliente;
            }

            if (mesa) {
                filter.mesa = mesa;
            }

            if (data) {
                filter.data = data;
            }

            if (status) {
                filter.status = status;
            }

            const reserva = await Reserva.find(filter);
            return res.json(reserva);

        } catch (error) {
            return res.status(500).json({ error: "Erro ao listar as reservas" });
        }
    },

    async update(req: Request, res: Response) {
        try {
            const reserva = await Reserva.findByIdAndUpdate(req.params.id, req.body, { new: true });
            return res.json({ message: "Reserva atualizada!", reserva });
        } catch (err) {
            return res.status(400).json({ error: err });
        }
    },

    async delete(req: Request, res: Response) {
        try {
            const { id } = req.params;

            await Reserva.findByIdAndDelete(id);

            return res.json({ message: "Reserva removida com sucesso!" });

        } catch (error) {
            return res.status(500).json({ error: "Erro ao excluir a reserva." });
        }
    }
}
