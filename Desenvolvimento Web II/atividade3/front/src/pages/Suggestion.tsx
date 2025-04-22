import React, { useEffect, useState } from 'react';
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

const Button = styled.button`
  margin-top: 20px;
  padding: 10px 20px;
  background-color: blue;
  color: white;
  font-weight: bold;
  border: none;
  cursor: pointer;
  border-radius: 4px;
`;

const Suggestion: React.FC = () => {
  const suggestionContext = useSuggestions();
  if (!suggestionContext) {
    throw new Error('useSuggestions deve ser usado dentro de um SuggestionProvider');
  }
  const { addSuggestion } = suggestionContext;
  const [currentSuggestion, setCurrentSuggestion] = useState<number[]>([]);

  const generateSuggestion = () => {
    const suggestion = Array.from(new Set(Array.from({ length: 6 }, () => Math.floor(Math.random() * 60) + 1)));
    while (suggestion.length < 6) {
      const num = Math.floor(Math.random() * 60) + 1;
      if (!suggestion.includes(num)) suggestion.push(num);
    }
    return suggestion.sort((a, b) => a - b);
  };

  useEffect(() => {
    const suggestion = generateSuggestion();
    setCurrentSuggestion(suggestion);
    addSuggestion(suggestion);
  }, []);

  const handleNewSuggestion = () => {
    const suggestion = generateSuggestion();
    setCurrentSuggestion(suggestion);
    addSuggestion(suggestion);
  };

  return (
    <Container>
      <Header />
      <Content>
        <Card>
          <h2>Palpite para a Mega-sena</h2>
          <div>
            {currentSuggestion.map((num, idx) => (
              <Ball key={idx}>{num}</Ball>
            ))}
          </div>
          <Button onClick={handleNewSuggestion}>Nova sugestão</Button>
        </Card>
      </Content>
    </Container>
  );
};

export default Suggestion;
