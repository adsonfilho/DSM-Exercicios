import api from "./api";

export async function getCidades() {
  const { data } = await api.get("/cidade");
  return data;
}

export async function getIrradiacao(id: number) {
  const { data } = await api.get(`/cidade/${id}`);
  return data;
}