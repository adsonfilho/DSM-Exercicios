
import React, { useEffect, useRef } from 'react';
import { MapContainer, TileLayer, GeoJSON, useMap } from 'react-leaflet';
import L, { type PathOptions } from 'leaflet';
import 'leaflet/dist/leaflet.css';
import styled from 'styled-components';
import { useCenso } from '../context/CensoContext';


// Importar os tipos específicos do GeoJSON
import type { Feature, FeatureCollection, GeoJsonProperties, Geometry, Position } from 'geojson';
import type { CensoPolygon, ChangeViewProps } from '../types';

// Ajuste para os ícones padrão do Leaflet, que podem não carregar corretamente no Webpack/Vite
delete (L.Icon.Default.prototype as any)._getIconUrl;
L.Icon.Default.mergeOptions({
  iconRetinaUrl: 'https://unpkg.com/leaflet@1.7.1/dist/images/marker-icon-2x.png',
  iconUrl: 'https://unpkg.com/leaflet@1.7.1/dist/images/marker-icon.png',
  shadowUrl: 'https://unpkg.com/leaflet@1.7.1/dist/images/marker-shadow.png',
});

// Estilização do container do mapa
const MapContainerStyled = styled(MapContainer)`
  height: 100vh;
  width: 100vw;
  position: absolute;
  top: 0;
  left: 0;
  z-index: 0;
`;


function ChangeView({ center, zoom }: ChangeViewProps) {
  const map = useMap();
  useEffect(() => {
    map.flyTo(center, zoom);
  }, [center, zoom, map]);
  return null;
}

const MapComponent: React.FC = () => {
  const { censoData, selectedSector, fetchSectorDetails, loading } = useCenso();
  const geoJsonRef = useRef<L.GeoJSON>(null);

  const wktToGeoJSON = (wkt: string, cd_setor_prop: string): Feature => {
    if (wkt.startsWith('POLYGON')) {
      const coordsString = wkt.substring(wkt.indexOf('((') + 2, wkt.lastIndexOf('))'));
      const coordinates: Position[] = coordsString.split(',').map(pair => {
        const [x, y] = pair.trim().split(' ').map(Number);
        return [x, y];
      });
      return {
        type: 'Feature',
        properties: { cd_setor: cd_setor_prop },
        geometry: {
          type: 'Polygon',
          coordinates: [coordinates],
        },
      };
    } else if (wkt.startsWith('MULTIPOLYGON')) {
      const cleanedWkt = wkt.substring(wkt.indexOf('(((') + 3, wkt.lastIndexOf(')))'));
      const polygonStrings = cleanedWkt.split(')),((');

      const multiPolygonCoordinates: Position[][][] = polygonStrings.map(polygonString => {
        const coordsPairStrings = polygonString.replace(/\(|\)/g, '').split(',');
        const coordinates: Position[] = coordsPairStrings.map(pair => {
            const [x, y] = pair.trim().split(' ').map(Number);
            return [x, y];
        });
        return [coordinates]; 
      });

      return {
        type: 'Feature',
        properties: { cd_setor: cd_setor_prop }, 
        geometry: {
          type: 'MultiPolygon',
          coordinates: multiPolygonCoordinates,
        },
      };
    }
   
    return {
      type: 'Feature',
      properties: { cd_setor: cd_setor_prop }, 
      geometry: {
        type: 'Point',
        coordinates: [],
      },
    };
  };


  const style = (feature: Feature<Geometry, GeoJsonProperties> | undefined): PathOptions => {
    const featureCdSetor = feature?.properties?.cd_setor;
    const selectedCdSetor = selectedSector?.cd_setor;

 
    const isSelected = selectedSector && featureCdSetor === selectedCdSetor;

    return {
      fillColor: isSelected ? '#ff0000' : '#0000ff',
      weight: 1,
      opacity: 1,
      color: 'white',
      dashArray: '3',
      fillOpacity: 0.5,
    };
  };


  const onEachFeature = (_feature: Feature<Geometry, GeoJsonProperties>, layer: L.Layer) => {
    
    layer.on({
      click: (e) => {
        const { lat, lng } = e.latlng;
        fetchSectorDetails(lng, lat);
        L.DomEvent.stopPropagation(e);
      },
    });
  };

  useEffect(() => {
    if (geoJsonRef.current && censoData) {
      geoJsonRef.current.clearLayers();
      const features: Feature[] = censoData.polygons.map((p: CensoPolygon) => wktToGeoJSON(p.geom, p.cd_setor));
      const newGeoJsonData: FeatureCollection = { type: 'FeatureCollection', features: features };
      geoJsonRef.current.addData(newGeoJsonData);
    }
  }, [censoData, selectedSector]); 

  if (loading && !censoData) {
    return <p>Carregando mapa...</p>;
  }

  if (!censoData) {
    return <p>Selecione uma cidade para visualizar o mapa.</p>;
  }

 
  const initialCenter: [number, number] = censoData.centroid ? [censoData.centroid.latitude, censoData.centroid.longitude] : [-23.2847, -45.9615];
  const initialZoom = 12;

  const geoJsonFeatures: Feature[] = censoData.polygons.map((p: CensoPolygon) => wktToGeoJSON(p.geom, p.cd_setor));
  const geoJsonData: FeatureCollection = {
    type: 'FeatureCollection',
    features: geoJsonFeatures,
  };

  return (
    <MapContainerStyled center={initialCenter} zoom={initialZoom} scrollWheelZoom={true}>
      <TileLayer
        attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
      />
      {censoData.centroid && (
        <ChangeView center={[censoData.centroid.latitude, censoData.centroid.longitude]} zoom={initialZoom} />
      )}
      <GeoJSON
        key={`${censoData.centroid.latitude}-${censoData.centroid.longitude}-${selectedSector?.cd_setor || ''}`}
        data={geoJsonData}
        style={style}
        onEachFeature={onEachFeature}
        ref={geoJsonRef}
      />
    </MapContainerStyled>
  );
};

export default MapComponent;