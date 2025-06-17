// src/components/SectorInfo.tsx
import React from 'react';
import { useCenso } from '../context/CensoContext';
import { InfoItem, SectorInfoContainer, TitleInfo } from '../styles/GlobalStyle';


const SectorInfo: React.FC = () => {
  const { selectedSector, loading, error, setSelectedSector } = useCenso();

  if (!selectedSector) {
    return null;
  }

  if (loading) {
    return (
      <SectorInfoContainer>
        <p>Carregando informações do setor...</p>
      </SectorInfoContainer>
    );
  }

  if (error) {
    return (
      <SectorInfoContainer>
        <p>Erro ao carregar informações do setor: {error}</p>
        <button onClick={() => setSelectedSector(null)}>Fechar</button>
      </SectorInfoContainer>
    );
  }

  return (
    <SectorInfoContainer>
      <TitleInfo>Informações do Setor:</TitleInfo>
      <InfoItem>
        <strong>Cód. Setor:</strong> {selectedSector.cd_setor}
      </InfoItem>
      <InfoItem>
        <strong>Município:</strong> {selectedSector.nm_mun}
      </InfoItem>
      <InfoItem>
        <strong>Situação:</strong> {selectedSector.situacao}
      </InfoItem>
      <InfoItem>
        <strong>Área:</strong> {selectedSector.area_km2.toFixed(3)} km²
      </InfoItem>
    </SectorInfoContainer>
  );
};

export default SectorInfo;