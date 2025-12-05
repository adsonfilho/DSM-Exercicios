import { Router } from "express";
import controller from "../controllers/ReservaController";

const router = Router();

router.post("/", controller.create);
router.get("/", controller.list);
router.put("/:id", controller.update);
router.delete("/:id", controller.delete);

export default router;
