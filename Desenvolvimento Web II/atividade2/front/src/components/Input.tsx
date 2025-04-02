import { CSSProperties, useContext } from "react"
import { LetterCtx } from "../contexts/LetterCtx"

export default function Input(){
    const {input, SetInput} = useContext(LetterCtx)

    return  <div>
                <input style={inputStyle} type='text' value={input} onChange={(e)=>SetInput(e.target.value)} placeholder="Entre com o nome"/>
            </div>
}
const inputStyle: CSSProperties = {
    padding: '8px',
    border: '1px solid #ccc',
    borderRadius: '4px',
    width: '400px',
    fontSize: '16px',
};