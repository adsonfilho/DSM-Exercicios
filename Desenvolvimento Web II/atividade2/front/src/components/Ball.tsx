import React, { CSSProperties } from 'react';

interface BallProps {
  letter: string;
}

const Ball: React.FC<BallProps> = ({ letter }) => {
  return <div style={ballStyle}>{letter}</div>;
};

const ballStyle: CSSProperties = {
  width: '50px',
  height: '50px',
  borderRadius: '50%',
  backgroundColor: '#646cff',
  color: 'white',
  display: 'flex',
  justifyContent: 'center',
  alignItems: 'center',
  margin: '5px'
};

export default Ball;
