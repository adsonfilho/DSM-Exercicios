function exer5(){
    let entrada = document.querySelector('#entrada')
    let saida = document.querySelector('#saida')
    let p = document.createElement('p')
    let txt = document.createTextNode(entrada.value)
    p.appendChild(txt)
    saida.appendChild(p)
}