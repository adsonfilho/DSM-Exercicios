import Home from "./pages/Home";
import { SolarProvider } from "./contexts/SolarContext";

export default function App() {
  return (
    <SolarProvider>
      <Home />
    </SolarProvider>
  );
}
