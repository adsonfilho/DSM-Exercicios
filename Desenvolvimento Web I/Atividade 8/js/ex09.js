function exer9() {
    let entrada = document.querySelector("#entrada");
    let valorEntrada = entrada.value;
    let valorTotal = 0;
    if (valorEntrada.length > 0) {
      let ol = document.querySelector("#saida");
      let li = document.createElement("li");
      let txt = document.createTextNode(valorEntrada);
      let tittle = document.createAttribute("title");
      let total = document.querySelector("#total");
      tittle.value = valorEntrada;
      li.setAttributeNode(tittle);
      li.appendChild(txt);
      ol.appendChild(li);
      entrada.value = "";
      valorTotal = document.querySelectorAll("li").length;
      total.innerText = valorTotal;
    }
  }