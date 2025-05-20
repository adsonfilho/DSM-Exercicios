import { createContext, useEffect, useState } from "react";
import { LotteryContextProps, LotteryProps, ProviderProps } from "../types";
import { getLottery } from "../services/Lottery";

export const LotteryContext = createContext({} as LotteryContextProps);

export function LotteryProvider({ children }: ProviderProps) {
  const [megasena, setMegasena] = useState<LotteryProps | undefined>();
  useEffect(() => {
    (async function () {
      const result = await getLottery();
      setMegasena(result);
      console.log("result", result);
    })();
  }, []);
  return (
    <LotteryContext.Provider value={{ megasena }}>
      {children}
    </LotteryContext.Provider>
  );
}
