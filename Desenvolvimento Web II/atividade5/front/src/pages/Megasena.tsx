import { useContext, useEffect, useState } from "react";
import { LotteryContext } from "../contexts/LotteryContext";
import { Ball } from "../components/Ball";
import { getLotteryById } from "../services/Lottery";
import styled from "styled-components";
import { Props } from "../types";

const Container = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  border: 1px solid ${({ theme }) => theme.borderColor};
  border-radius: 10px;
  padding: 20px;
  gap: 20px;
  min-height: 200px;
  min-width: 500px;
`;

const BallsContainer = styled.div`
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  align-items: center;
  gap: 10px;
`;

const Input = styled.input`
  width: 100%;
  padding: 8px 12px;
  border-radius: 6px;
  border: 1px solid ${({ theme }) => theme.borderColor};
  font-size: 16px;
  background-color: ${({ theme }) => theme.background};
  color: ${({ theme }) => theme.text};
`;

const MensagemErro = styled.p`
  color: ${({ theme }) => theme.text};
  font-weight: bold;
  font-size: 24px;
  text-align: center;
`;

export function Megasena() {
  const { megasena: megasenaMaisRecente } = useContext(LotteryContext);
  const [concursoId, setConcursoId] = useState<string>("");
  const [resultado, setResultado] = useState<Props | null>(null);
  const [erro, setErro] = useState<string>("");

  // Buscar por ID se valor estiver preenchido, senão usa o mais recente
  useEffect(() => {
    async function buscarConcurso() {
      setErro("");

      if (concursoId === "") {
        setResultado(megasenaMaisRecente ?? null);
        return;
      }

      try {
        const concurso = await getLotteryById(Number(concursoId));
        setResultado(concurso);
      } catch (e) {
        setResultado(null);
        setErro(`Nao existem dados do curso ${concursoId}`);
      }
    }

    buscarConcurso();
  }, [concursoId, megasenaMaisRecente]);

  if (!megasenaMaisRecente) return <p>Carregando...</p>;

  return (
    <>
      <Input
        type="number"
        placeholder="Digite o número do concurso"
        value={concursoId}
        onChange={(e) => setConcursoId(e.target.value)}
      />

    <Container>
      
      {erro && <MensagemErro>{erro}</MensagemErro>}

      {resultado ? (
        <>
          <h1>Mega Sena</h1>
          <BallsContainer>
            {[resultado.bola1, resultado.bola2, resultado.bola3, resultado.bola4, resultado.bola5, resultado.bola6].map(
              (dezena, index) => (
                <Ball key={index} number={dezena.toString()} />
              )
            )}
          </BallsContainer>
          <span>{new Date(resultado.data_do_sorteio).toDateString()}</span>
        </>
      ) : (
        !erro && <p>Carregando concurso...</p>
      )}
    </Container>
    </>
  );
}
