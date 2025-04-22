import React from 'react';
import { Link } from 'react-router-dom';
import styled from 'styled-components';

const NavBar = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: #1e1e1e;
  padding: 10px 20px;
  color: white;
`;

const NavLinks = styled.div`
  a {
    color: white;
    margin-left: 20px;
    text-decoration: none;
    font-size: 16px;
  }
`;

const Header: React.FC = () => {
  return (
    <NavBar>
      <h1>
        FATEC
      </h1>
      <NavLinks>
        <Link to="/palpite">Palpite</Link>
        <Link to="/historico">Histórico</Link>
      </NavLinks>
    </NavBar>
  );
};

export default Header;
