// src/styles/GlobalStyle.ts
import styled, { createGlobalStyle } from 'styled-components';

export const GlobalStyle = createGlobalStyle`
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }

  html, body, #root {
    height: 100%;
    width: 100%;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #0f1117;
    color: #f1f1f1;
    overflow: hidden;
  }
`;

export const CityListContainer = styled.div`
  position: absolute;
  top: 20px;
  right: 20px;
  background-color: rgba(20, 22, 30, 0.95);
  padding: 16px;
  border-radius: 12px;
  box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
  z-index: 1;
  min-width: 220px;
  max-height: calc(100vh - 40px);
  overflow-y: auto;
  border: 1px solid #2e2e40;
`;

export const Title = styled.h3`
  margin-bottom: 12px;
  color: #00d9ff;
  font-size: 1.2em;
  text-shadow: 0 0 2px #00d9ff88;
`;

export const CityItem = styled.div<{ isSelected: boolean }>`
  padding: 10px 0;
  cursor: pointer;
  color: ${props => (props.isSelected ? '#00d9ff' : '#aaa')};
  font-weight: ${props => (props.isSelected ? 'bold' : 'normal')};
  border-left: ${props => (props.isSelected ? '4px solid #00d9ff' : '4px solid transparent')};
  padding-left: 10px;
  transition: all 0.2s ease;

  &:hover {
    color: #00b3cc;
    transform: translateX(5px);
  }
`;

export const SectorInfoContainer = styled.div`
  position: absolute;
  bottom: 20px;
  right: 20px;
  background-color: rgba(20, 22, 30, 0.95);
  padding: 16px;
  border-radius: 12px;
  box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
  z-index: 1;
  min-width: 270px;
  max-width: 380px;
  border: 1px solid #2e2e40;
`;

export const TitleInfo = styled.h4`
  margin-bottom: 12px;
  color: #00ffa6;
  font-size: 1.15em;
  text-shadow: 0 0 2px #00ffa688;
`;

export const InfoItem = styled.p`
  margin-bottom: 6px;
  color: #ccc;
  font-size: 0.95em;

  strong {
    color: #fff;
  }
`;
