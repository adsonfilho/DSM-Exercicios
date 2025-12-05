import express from "express";
import mongoose from "mongoose";
import cors from "cors";
import router from "./routes/reservaRoutes";
import routerMesa from "./routes/mesaRoutes"
import dotenv from "dotenv"

const app = express();
dotenv.config()


const PORT = process.env.PORT || 3000;
const MONGO_URL = process.env.MONGODB_URI || "mongodb://localhost:27017/bancoMongo"

app.use(cors());
app.use(express.json());
app.use("/mesas", routerMesa)
app.use("/reservas", router);

mongoose.connect(MONGO_URL)
    .then(() => console.log("MongoDB conectado"))
    .catch(err => console.log(err));


app.listen(PORT, () => console.log(`Servidor rodando em http://localhost:${PORT}`));
