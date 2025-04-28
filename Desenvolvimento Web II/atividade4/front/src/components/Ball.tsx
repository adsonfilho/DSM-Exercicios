import styled from "styled-components";

interface BallProps {
  number: string;
}

const StyledBall = styled.div`
  width: 50px;
  height: 50px;
  background-color: #209869;
  color: #ffffff;
  border-radius: 50%;
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 20px;
  margin: 5px;
`;

export function Ball({ number }: BallProps) {
  return <StyledBall>{number}</StyledBall>;
}
