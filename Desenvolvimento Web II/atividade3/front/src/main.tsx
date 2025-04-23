
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import { BrowserRouter } from 'react-router-dom';
import { SuggestionProvider } from './contexts/SuggestionContext';

const root = ReactDOM.createRoot(document.getElementById('root')!);
root.render(
  <React.StrictMode>
    <SuggestionProvider>
      <BrowserRouter>
        <App />
      </BrowserRouter>
    </SuggestionProvider>
  </React.StrictMode>
);
