import type { ReactNode } from "react";

export interface CensoContextType {
  selectedCity: string;
  censoData: CensoCityData | null;
  selectedSector: SectorDetails | null;
  loading: boolean;
  error: string | null;
  setSelectedCity: (city: string) => void;
  setSelectedSector: (sector: SectorDetails | null) => void;
  fetchCensoData: (city: string) => Promise<void>;
  fetchSectorDetails: (x: number, y: number) => Promise<void>;
}

export interface CensoProviderProps {
  children: ReactNode;
}

export interface CensoPolygon {
  geom: string;
  cd_setor: string;
}

export interface CensoCentroid {
  longitude: number;
  latitude: number;
}

export interface CensoCityData {
  centroid: CensoCentroid;
  polygons: CensoPolygon[];
}

export interface SectorDetails { 
  cd_setor: string;
  situacao: string;
  area_km2: number;
  nm_mun: string;
  geom: string; 
}

export interface ChangeViewProps {
  center: [number, number];
  zoom: number;
}