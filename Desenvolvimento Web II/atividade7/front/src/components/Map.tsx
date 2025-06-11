import { useContext, useEffect, useState } from "react";
import {
  MapContainer,
  TileLayer,
  Marker,
  Polygon,
  useMap,
} from "react-leaflet";
import { SolarContext } from "../contexts/SolarContext";
import "leaflet/dist/leaflet.css";

function ResizeFixer() {
  const map = useMap();
  useEffect(() => {
    setTimeout(() => {
      map.invalidateSize();
    }, 100);
  }, [map]);
  return null;
}

function MoverMapa({ position }: { position: [number, number] }) {
  const map = useMap();
  useEffect(() => {
    map.flyTo(position, 10); // Ajuste o zoom se necessário
  }, [position, map]);
  return null;
}

const Mapa = () => {
  const { irradiacaoSelecionada } = useContext(SolarContext);
  const [markerPosition, setMarkerPosition] = useState<[number, number] | null>(null);
  const [polygonPositions, setPolygonPositions] = useState<[number, number][]>([]);

  useEffect(() => {
    if (irradiacaoSelecionada) {
      const novaPosicao: [number, number] = [
        irradiacaoSelecionada.lat,
        irradiacaoSelecionada.lon,
      ];
      setMarkerPosition(novaPosicao);

      const polygonGeoJSON = JSON.parse(irradiacaoSelecionada.poligono_geojson);
      const novasCoordenadas = polygonGeoJSON.coordinates[0].map(
        ([lon, lat]: [number, number]) => [lat, lon]
      );
      setPolygonPositions(novasCoordenadas);
    }
  }, [irradiacaoSelecionada]);

  const posicaoInicial: [number, number] = [-15.78, -47.93]; // Centro do Brasil

  return (
    <MapContainer
      center={posicaoInicial}
      zoom={4}
      scrollWheelZoom={true}
      style={{ height: "100%", width: "100%" }}
    >
      <ResizeFixer />
      <TileLayer
        attribution='&copy; OpenStreetMap contributors'
        url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
      />
      {markerPosition && (
        <>
          <MoverMapa position={markerPosition} />
          <Marker position={markerPosition} />
        </>
      )}
      {polygonPositions.length > 0 && (
        <Polygon positions={polygonPositions} pathOptions={{ color: "orange" }} />
      )}
    </MapContainer>
  );
};

export default Mapa;
