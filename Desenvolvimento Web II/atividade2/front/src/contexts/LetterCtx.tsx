import { createContext, useState } from "react";
import { LetterCtxProps } from "../types";

interface Props{
    children: React.ReactNode 
}

const LetterCtx = createContext<LetterCtxProps>({} as LetterCtxProps)

function LetterProvider({children}:Props){
    const [input, SetInput] = useState('')

    return <LetterCtx.Provider value={{input, SetInput}}>
        {children}
    </LetterCtx.Provider>
}

export {LetterCtx, LetterProvider}

