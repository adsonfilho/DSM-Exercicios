import React from 'react';
import { useSuggestions } from '../contexts/SuggestionContext';
import styled from 'styled-components';
import Header from './Header';

const Container = styled.div`
  background-color: #121212;
  height: 100vh;
  color: white;
`;

const Content = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 80%;
`;

const Card = styled.div`
  border: 1px solid gray;
  padding: 40px;
  border-radius: 10px;
  text-align: center;
`;

const Row = styled.div`
  display: flex;
  justify-content: center;
  margin-bottom: 10px;
`;

const Ball = styled.span`
  background-color: #2ecc71;
  color: white;
  padding: 15px;
  margin: 5px;
  border-radius: 50%;
  font-size: 18px;
  display: inline-block;
  width: 45px;
  text-align: center;
`;

const History: React.FC = () => {
  const { suggestions } = useSuggestions();

  return (
    <Container>
      <Header />
      <Content>
        <Card>
          <h2>Palpites</h2>
          {suggestions.map((sug, idx) => (
            <Row key={idx}>
              {sug.map((num, i) => (
                <Ball key={i}>{num}</Ball>
              ))}
            </Row>
          ))}
        </Card>
      </Content>
    </Container>
  );
};

export default History;
