import { useContext } from "react";
import { SolarContext } from "../contexts/SolarContext";
import { Panel } from "../styles/PageStyle";
import type { IrradiationData } from "../types";

export function IrradiationPanel() {
  const { irradiacaoSelecionada } = useContext(SolarContext);

  if (!irradiacaoSelecionada) return null;

  const {
    jan,
    fev,
    mar,
    abr,
    mai,
    jun,
    jul,
    ago,
    set,
    out,
    nov,
    dez,
  } = irradiacaoSelecionada as IrradiationData;

  return (
    <Panel>
      <h1>Irradiação</h1>
      <ul>
        <li>Anual: {irradiacaoSelecionada.anual}</li>
        <li>Jan: {jan}</li>
        <li>Fev: {fev}</li>
        <li>Mar: {mar}</li>
        <li>Abr: {abr}</li>
        <li>Mai: {mai}</li>
        <li>Jun: {jun}</li>
        <li>Jul: {jul}</li>
        <li>Ago: {ago}</li>
        <li>Set: {set}</li>
        <li>Out: {out}</li>
        <li>Nov: {nov}</li>
        <li>Dez: {dez}</li>
      </ul>
    </Panel>
  );
}
