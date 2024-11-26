function exer8() {
    let entrada = document.querySelector("#entrada");
    let valorEntrada = entrada.value;
    if (valorEntrada.length > 0) {
      let ol = document.querySelector("ol");
      let li = document.createElement("li");
      let txt = document.createTextNode(valorEntrada);
      let tittle = document.createAttribute("title");
      tittle.value = valorEntrada;
      li.setAttributeNode(tittle);
      li.appendChild(txt);
      ol.appendChild(li);
    }
}