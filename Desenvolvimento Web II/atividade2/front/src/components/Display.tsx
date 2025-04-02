import Ball from './Ball';
import { CSSProperties, useContext } from 'react';
import { LetterCtx } from '../contexts/LetterCtx';

export default function Display() {
  const { input } = useContext(LetterCtx);

  if (!input) {
    return <div style={displayStyle}>Sem entrada</div>;
  }

  return (
    <div style={displayStyle}>
      {input.split('').map((letter, index) => (
        <Ball key={index} letter={letter} />
      ))}
    </div>
  );
}

const displayStyle: CSSProperties = {
  border: '1px solid #eee',
  padding: '10px',
  width: '400px',
  height: '72px',
  display: 'flex',
  justifyContent: 'center',
  alignItems: 'center',
  color: 'white',
  fontSize: '20px',
  borderRadius: '10px',
};
