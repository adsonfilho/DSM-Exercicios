import { createContext, useEffect, useState } from "react";
import { getCidades, getIrradiacao } from "../services/Cidades";
import type { City, IrradiationData, SolarContextType } from "../types";

export const SolarContext = createContext({} as SolarContextType);

export function SolarProvider({ children }: { children: React.ReactNode }) {
  const [cidades, setCidades] = useState<City[]>([]);
  const [irradiacaoSelecionada, setIrradiacaoSelecionada] = useState<IrradiationData>();

  useEffect(() => {
    getCidades().then((data) => setCidades(data as City[]));
  }, []);

async function buscarIrradiacao(id: number) {
  const result = await getIrradiacao(id) as IrradiationData;

  const geo = JSON.parse(result.poligono_geojson);
  const poligono = geo.coordinates[0].map(
    ([lon, lat]: [number, number]) => [lat, lon]
  );

  const data: IrradiationData = {
    ...result,
    coordenadas: [result.lat, result.lon],
    poligono,
  };

  console.log("Irradiação selecionada:", irradiacaoSelecionada);
  setIrradiacaoSelecionada(data);
}


  return (
    <SolarContext.Provider value={{ cidades, irradiacaoSelecionada, buscarIrradiacao }}>
      {children}
    </SolarContext.Provider>
  );
}
