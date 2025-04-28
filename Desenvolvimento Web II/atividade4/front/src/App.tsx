import { ThemeProvider } from "styled-components";
import { useTheme } from "./hooks/useTheme";
import { lightTheme, darkTheme } from "./styles/theme";
import { GlobalStyle } from "./styles/GlobalStyle";
import { LotteryProvider } from "./contexts/LotteryContext";
import { Megasena } from "./pages/Megasena";
import { FaMoon, FaSun } from "react-icons/fa";

function App() {
  const { theme, toggleTheme } = useTheme();

  return (
    <ThemeProvider theme={theme === "light" ? lightTheme : darkTheme}>
      <LotteryProvider>
        <GlobalStyle />
        <Megasena />
        <button onClick={toggleTheme}>
          {theme === "light" ? <FaMoon size={20} /> : <FaSun size={20} />}
        </button>
      </LotteryProvider>
    </ThemeProvider>
  );
}

export default App;
