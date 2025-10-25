import { Schema, model } from 'mongoose';


export interface IDisc {
    title: string;
    artist: string;
    year?: number;
    genre?: string;
    format: 'Vinil' | 'CD' | string;
    price?: number;
}


const DiscSchema = new Schema<IDisc>({
    title: { type: String, required: true },
    artist: { type: String, required: true },
    year: { type: Number },
    genre: { type: String },
    format: { type: String, required: true },
    price: { type: Number }
});


export default model<IDisc>('Disc', DiscSchema);