import { CSSProperties } from "react"
import Display from "./components/Display"
import Input from "./components/Input"
import { LetterProvider } from "./contexts/LetterCtx"


function App() {

  return (
    <div style={appStyle}>
      <LetterProvider>
        <div style={componentsStyle}>
          <Input />
          <Display />
        </div>
      </LetterProvider>
    </div>
  )
}

const appStyle: CSSProperties = {
  display: 'flex',
  flexDirection: 'column',
  alignItems: 'center',
  justifyContent: 'center',
  backgroundColor: '#242424',
  color: 'white',
  width: '500px',
  height: '500px',
};

const componentsStyle: CSSProperties = {
  display: 'flex',
  flexDirection: 'column',
  alignItems: 'center',
  justifyContent: 'center',
  border: '1px solid #eee',
  padding: '10px',
  gap: '50px',
}

export default App
