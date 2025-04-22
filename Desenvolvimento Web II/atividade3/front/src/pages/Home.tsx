import React from 'react';
import { useNavigate } from 'react-router-dom';
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

const Home: React.FC = () => {
  const navigate = useNavigate();

  return (
    <Container>
      <Header />
      <Content>
        <Card>
          <h1>Bem-vindo!</h1>
          <Button onClick={() => navigate('/palpite')}>Clique para começar</Button>
        </Card>
      </Content>
    </Container>
  );
};

export default Home;
