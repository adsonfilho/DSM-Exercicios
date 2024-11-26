function exer10() {
    let entrada = document.querySelector("#entrada");
    let valorEntrada = entrada.value;
    let valorTotal = 0;
    if (valorEntrada.length > 0) {
      let ol = document.querySelector("#saida");
      let li = document.createElement("li");
      let txt = document.createTextNode(valorEntrada);
      let title = document.createAttribute("title");
      let onclick = document.createAttribute("onclick");
      onclick.value = "exibir()";
      let total = document.querySelector("#total");
      title.value = valorEntrada;
      li.setAttributeNode(title);
      li.setAttributeNode(onclick);
      li.appendChild(txt);
      ol.appendChild(li);
      entrada.value = "";
      valorTotal = document.querySelectorAll("li").length;
      total.innerText = valorTotal;
    }
}
  
function exibir() {
    alert("Exibindo");
}