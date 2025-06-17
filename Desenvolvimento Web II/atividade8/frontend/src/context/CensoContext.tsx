
import React, { createContext, useState, useContext, useEffect, useCallback } from 'react';
import { getCensoDataByCity, getCensoDataByPoint } from '../services/censoService';
import type { CensoCityData, CensoContextType, CensoProviderProps, SectorDetails } from '../types';


const CensoContext = createContext<CensoContextType | undefined>(undefined);

export const CensoProvider: React.FC<CensoProviderProps> = ({ children }) => {
  const [selectedCity, setSelectedCity] = useState<string>('Jacareí'); // Inicia com Jacareí
  const [censoData, setCensoData] = useState<CensoCityData | null>(null);
  const [selectedSector, setSelectedSector] = useState<SectorDetails | null>(null);
  const [loading, setLoading] = useState<boolean>(false);
  const [error, setError] = useState<string | null>(null);

  const fetchCensoData = useCallback(async (city: string) => {
    setLoading(true);
    setError(null);
    try {
      const data = await getCensoDataByCity(city);
      setCensoData(data);
      setSelectedSector(null); 
    } catch (err) {
      console.error('Erro ao buscar dados do censo:', err);
      setError('Não foi possível carregar os dados do município.');
    } finally {
      setLoading(false);
    }
  }, []);

  
  const fetchSectorDetails = useCallback(async (x: number, y: number) => {
    setLoading(true);
    setError(null);
    try {
      const data = await getCensoDataByPoint(x, y);
      setSelectedSector(data);
    } catch (err) {
      console.error('Erro ao buscar detalhes do setor:', err);
      setError('Não foi possível carregar os detalhes do setor.');
      setSelectedSector(null);
    } finally {
      setLoading(false);
    }
  }, []);

 
  useEffect(() => {
    fetchCensoData(selectedCity);
  }, [selectedCity, fetchCensoData]); 

  const contextValue: CensoContextType = {
    selectedCity,
    censoData,
    selectedSector,
    loading,
    error,
    setSelectedCity,
    setSelectedSector,
    fetchCensoData,
    fetchSectorDetails,
  };

  return (
    <CensoContext.Provider value={contextValue}>
      {children}
    </CensoContext.Provider>
  );
};


export const useCenso = () => {
  const context = useContext(CensoContext);
  if (context === undefined) {
    throw new Error('useCenso deve ser usado dentro de um CensoProvider');
  }
  return context;
};