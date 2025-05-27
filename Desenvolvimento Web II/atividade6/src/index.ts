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

// Rota para obter todas as cidades
app.get('/cidade', async (req: Request, res: Response) => {
    const r:any = await db.query(
    "SELECT * FROM cidades"
    );
    res.json(r.rows);
});


// Rota para obter um ponto de incidencia de uma cidade especifica
app.get('/cidade/:id', async (req: Request, res: Response) => {
    const { id } = req.params;
    const r:any = await db.query(
    "SELECT * FROM incidencias i INNER JOIN cidades c ON ST_Contains(i.geom, c.geom) WHERE c.id = $1",
    [id]
    );
    if (r.rows.length === 0) {
        res.status(404).json({ message: `Nao existe dados dessa cidade ${id}`});
    }
    res.json(r.rows[0]);
});


// Inicializa o servidor
app.listen(PORT, () => {
console.log(`Servidor rodando em http://localhost:${PORT}`);
});