import { useContext } from "react";
import { LotteryContext } from "../contexts/LotteryContext";
import { Ball } from "../components/Ball";
import styled from "styled-components";

const Container = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  border: 1px solid ${({ theme }) => theme.borderColor};;
  border-radius: 10px;
  padding: 20px;
  gap: 20px;
`;

const BallsContainer = styled.div`
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  align-items: center;
  gap: 10px;
`;

export function Megasena() {
  const { megasena } = useContext(LotteryContext);

  if (!megasena) {
    return <p>Carregando...</p>;
  }

  return (
    <Container>
      <h1>Mega Sena</h1>
      <BallsContainer>
        {megasena.dezenas.map((dezena, index) => (
          <Ball key={index} number={dezena} />
        ))}
      </BallsContainer>
      <span>{megasena.dataPorExtenso}</span>
    </Container>
  );
}
