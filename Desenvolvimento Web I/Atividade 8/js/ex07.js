function exer7(){
    let entrada = document.querySelector('#entrada')
    let ol = document.querySelector('ol')
    let li = document.createElement('li')
    let txt = document.createTextNode(entrada.value)
    let tittle = document.createAttribute('title')
    tittle.value = entrada.value
    li.setAttributeNode(tittle)
    li.appendChild(txt)
    ol.appendChild(li)
}