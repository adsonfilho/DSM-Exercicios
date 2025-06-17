// src/services/censoService.ts
import type { CensoCityData, SectorDetails } from '../types';
import api from './api';


export async function getCensoDataByCity(city: string): Promise<CensoCityData> {
  try {
    const response = await api.get<CensoCityData>('/censo', {
      params: { city },
    });
    return response.data;
  } catch (error) {
    console.error('Erro ao buscar dados do censo por cidade:', error);
    throw error;
  }
}

export async function getCensoDataByPoint(x: number, y: number): Promise<SectorDetails> {
  try {
    const response = await api.get<SectorDetails>('/censo/point', {
      params: { x, y },
    });
    return response.data;
  } catch (error) {
    console.error('Erro ao buscar dados do censo por ponto:', error);
    throw error;
  }
}