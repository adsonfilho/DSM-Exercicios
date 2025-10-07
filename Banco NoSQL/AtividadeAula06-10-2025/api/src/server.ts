import express from "express";
import jogosRoutes from "./routes/jogos";
import mongoose from "mongoose";

const app = express();

app.use(express.json());
app.use("/api", jogosRoutes);

const PORT = 3000;
const MONGO_URL = "mongodb://localhost:27017/api_games";

mongoose
  .connect(MONGO_URL)
  .then(() => {
    console.log("MongoDB conectado");
    app.listen(PORT, () => {
      console.log(`Servidor rodando na porta ${PORT}`);
    });
  })
  .catch((err) => {
    console.error("Erro ao conectar ao MongoDB:", err);
  });

