import React from 'react';
import { useCenso } from '../context/CensoContext';
import { CityItem, CityListContainer, Title } from '../styles/GlobalStyle';

// Lista de municípios disponíveis conforme o requisito
const availableCities = [
  "Campinas",
  "Jacareí",
  "São José dos Campos",
  "Sorocaba",
  "Ribeirão Preto",
  "São José do Rio Preto",
  "Piracicaba",
];


const CityList: React.FC = () => {
  
  const { selectedCity, setSelectedCity, loading } = useCenso();

  const handleCityClick = (city: string) => {
    if (city !== selectedCity && !loading) {
      setSelectedCity(city);
    }
  };

  return (
    <CityListContainer>
      <Title>Cidades:</Title>
      {availableCities.map((city) => (
        <CityItem
          key={city}
          isSelected={city === selectedCity}
          onClick={() => handleCityClick(city)}
        >
          {city}
        </CityItem>
      ))}
      {loading && <p>Carregando...</p>}
    </CityListContainer>
  );
};

export default CityList;