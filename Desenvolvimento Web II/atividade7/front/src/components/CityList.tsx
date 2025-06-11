import { useContext } from "react";
import { SolarContext } from "../contexts/SolarContext";
import {List, ListItem} from "../styles/PageStyle";



export function CityList() {
  const { cidades, buscarIrradiacao } = useContext(SolarContext);

  return (
    <List>
      {cidades.map((cidade) => (
        <ListItem key={cidade.id} onClick={() => buscarIrradiacao(cidade.id)}>
          {cidade.nome}
        </ListItem>
      ))}
    </List>
  );
}
