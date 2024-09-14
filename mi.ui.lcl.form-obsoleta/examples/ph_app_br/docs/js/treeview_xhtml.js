/* <script>  Usado com css treeview-xhtml.css
   Data: 05/11/2020
*/
// var toggler = document.querySelectorAll(".rootTree");
// Array.from(toggler).forEach(item => {
//   item.addEventListener("click", () => {
//     item.parentElement.querySelector(".children").classList.toggle("active");
    
//     item.classList.toggle("rootTree-down");
//   });
// });

    // Adiciona um ouvinte de evento ao elemento pai
    document.addEventListener("click", function (event) {
      // Verifica se o clique foi em um elemento com a classe 'rootTree'
      if (event.target.classList.contains("rootTree")) {
        // Obtém o elemento pai do elemento clicado
        var parent = event.target.parentElement;
  
        // Encontra o elemento '.children' dentro do pai
        var children = parent.querySelector(".children");
  
        // Verifica se o elemento '.children' foi encontrado
        if (children) {
          // Alterna a classe 'active' no elemento '.children'
          children.classList.toggle("active");
  
          // Alterna a classe 'rootTree-down' no elemento clicado
          event.target.classList.toggle("rootTree-down");
        }
      }
    });