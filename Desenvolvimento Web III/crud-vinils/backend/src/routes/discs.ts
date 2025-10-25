import { Router } from "express";
import Disc from "../models/Disc";

const router = Router();

router.get("/", async (req, res) => {
  const discs = await Disc.find().sort({ title: 1 });
  res.json(discs);
});

router.get("/:id", async (req, res) => {
  const disc = await Disc.findById(req.params.id);
  if (!disc) return res.status(404).json({ message: "Não encontrado" });
  res.json(disc);
});

router.post("/", async (req, res) => {
  try {
    const newDisc = await Disc.create(req.body);
    res.status(201).json(newDisc);
  } catch (err: any) {
    res.status(400).json({ message: err.message });
  }
});

router.put("/:id", async (req, res) => {
  try {
    const updated = await Disc.findByIdAndUpdate(req.params.id, req.body, {
      new: true,
      runValidators: true,
    });
    if (!updated) return res.status(404).json({ message: "Não encontrado" });
    res.json(updated);
  } catch (err: any) {
    res.status(400).json({ message: err.message });
  }
});

router.delete("/:id", async (req, res) => {
  const removed = await Disc.findByIdAndDelete(req.params.id);
  if (!removed) return res.status(404).json({ message: "Não encontrado" });
  res.json({ message: "Removido" });
});

export default router;
