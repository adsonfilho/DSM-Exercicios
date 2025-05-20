import express, { Request, Response } from 'express';
import dotenv from 'dotenv';
import db from './controllers/db';
import cors from 'cors';

// Carrega variáveis de ambiente do arquivo .env
dotenv.config();

// Inicializa o aplicativo Express
const app = express();
const PORT = process.env.PORT || 3000;

// Middleware para permitir que o servidor interprete JSON
app.use(express.json());
app.use(cors());

// Rota para obter o concurso mais recente
app.get('/', async (req: Request, res: Response) => {
    const r:any = await db.query(
    "SELECT * FROM megasena ORDER BY data_do_sorteio DESC LIMIT 1"
    );
    res.json(r.rows[0]);
});


// Rota para obter um concurso específico
app.get('/:concurso', async (req: Request, res: Response) => {
    const { concurso } = req.params;
    const r:any = await db.query(
    "SELECT * FROM megasena WHERE concurso = $1",
    [concurso]
    );
    if (r.rows.length === 0) {
        res.status(404).json({ message: `Nao existe dados do concurso ${concurso}`});
    }
    res.json(r.rows[0]);
});


// Inicializa o servidor
app.listen(PORT, () => {
console.log(`Servidor rodando em http://localhost:${PORT}`);
});
