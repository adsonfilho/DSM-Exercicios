import { Props } from "../types";
import api from "./api";

export async function getLottery(): Promise<Props> {
  // espera 2 segundos antes de prosseguir
  await delay(2000);
  const { data } = await api.get("/");
  return data;
}

export async function getLotteryById(id: number): Promise<Props> {
  // espera 2 segundos antes de prosseguir
  await delay(2000);
  const { data } = await api.get(`/${id}`);
  return data;
}

// Função para criar um delay
const delay = (ms: number) => new Promise((resolve) => setTimeout(resolve, ms));
