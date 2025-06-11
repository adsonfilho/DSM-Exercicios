export interface City {
  id: number;
  nome: string;
}

export interface IrradiationData {
  id: number;
  nome: string;
  lat: number;
  lon: number;
  anual: number;
  jan: number;
  fev: number;
  mar: number;
  abr: number;
  mai: number;
  jun: number;
  jul: number;
  ago: number;
  set: number;
  out: number;
  nov: number;
  dez: number;
  coordenadas: [number, number];
  poligono: [number, number][];
  poligono_geojson: string;
}

export interface SolarContextType {
  cidades: City[];
  irradiacaoSelecionada?: IrradiationData;
  buscarIrradiacao: (id: number) => void;
}