import React, { createContext, useState, useContext } from 'react';

type SuggestionContextType = {
  suggestions: number[][];
  addSuggestion: (suggestion: number[]) => void;
};

const SuggestionContext = createContext<SuggestionContextType | undefined>(undefined);

export const SuggestionProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [suggestions, setSuggestions] = useState<number[][]>([]);

  const addSuggestion = (suggestion: number[]) => {
    setSuggestions((prev) => [...prev, suggestion]);
  };

  return (
    <SuggestionContext.Provider value={{ suggestions, addSuggestion }}>
      {children}
    </SuggestionContext.Provider>
  );
};

export const useSuggestions = () => {
  const context = useContext(SuggestionContext);
  return context;
};
