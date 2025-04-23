
import React from 'react';
import { Routes, Route } from 'react-router-dom';
import Home from './pages/Home';
import Suggestion from './pages/Suggestion';
import History from './pages/History';

const App: React.FC = () => {
  return (
    <Routes>
      <Route path="/" element={<Home />} />
      <Route path="/palpite" element={<Suggestion />} />
      <Route path="/historico" element={<History />} />
    </Routes>
  );
};

export default App;