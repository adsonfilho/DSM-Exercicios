import express from 'express';
import cors from 'cors';
import mongoose from 'mongoose';
import dotenv from 'dotenv';
import discsRouter from './routes/discs';


dotenv.config();


const app = express();
app.use(cors());
app.use(express.json());


const PORT = process.env.PORT || 3000;
const MONGODB_URI = process.env.MONGODB_URI || 'mongodb://127.0.0.1:27017/cadastro_discos';


mongoose.connect(MONGODB_URI)
.then(() => console.log('MongoDB conectado'))
.catch(err => console.error('Erro MongoDB:', err));


app.use('/api/discs', discsRouter);


app.listen(PORT, () => console.log(`Servidor rodando em http://localhost:${PORT}`));