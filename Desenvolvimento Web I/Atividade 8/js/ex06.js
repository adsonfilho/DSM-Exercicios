function exer6(){
    let entrada = document.querySelector('#entrada')
    let saida = document.querySelector('#saida')
    let p = document.createElement('p')
    let txt = document.createTextNode(entrada.value)
    let tittle = document.createAttribute('title')
    tittle.value = 'Nome fornecido'
    p.setAttributeNode(tittle)
    p.appendChild(txt)
    saida.appendChild(p)
}