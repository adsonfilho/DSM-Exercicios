import { createGlobalStyle, DefaultTheme } from "styled-components";

declare module "styled-components" {
  export interface DefaultTheme {
    background: string;
    text: string;
    borderColor: string;
  }
}

export const GlobalStyle = createGlobalStyle`
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }

  body {
    background-color: ${({ theme }) => theme.background};
    color: ${({ theme }) => theme.text};
    height: 100vh;
    width: 100vw;
    display: flex;
    justify-content: center;
    align-items: center;
    font-family: sans-serif;
  }

  button {
    position: fixed;
    bottom: 20px;
    left: 20px;
    border: none;
    cursor: pointer;
    color: ${({ theme }) => theme.background};
    background-color: ${({ theme }) => theme.borderColor};
    border-radius: 50%;
    transition: all 0.3s ease;
    width: 50px;
    height: 50px;
  }
`;
