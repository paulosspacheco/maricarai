/**
 *  Esta função é usada pelo menu topdown que fique no top da página
 * 
 */
function myTopnav_menu() {
    var x = document.getElementById("myTopnav");
    if (x.className === "topnav") {
        x.className += " responsive";
    } else {
        x.className = "topnav";
    }
}

/**
 *  Esta função abre o menu lateral que fica ao lado da página
 * 
 */
function openNav_mySidenav() {
    document.getElementById("mySidenav").style.width = "250px";
    document.getElementById("main").style.marginLeft = "250px";
}

/**
 *  Esta função fecha o menu lateral que fica ao lado da página
 * 
 */

function closeNav_mySidenav() {
    document.getElementById("mySidenav").style.width = "0";
    document.getElementById("main").style.marginLeft = "0";
}

/*
function getPathRaiz() {
    //return 'file:///home/paulosspacheco/Documentos/blogger/blog.pssp.app.br/';
    return '/';
}*/
  
function getPathRaiz() {
    //return 'file:///home/paulosspacheco/Documentos/blogger/blog.pssp.app.br/';
    return '../';
    //return '/';
}

function search(aClass) {
    let input = document.getElementById('searchbar').value
    input=input.toLowerCase();
    let x = document.getElementsByClassName(aClass);
      
    for (i = 0; i < x.length; i++) { 
        if (!x[i].innerHTML.toLowerCase().includes(input)) {
            x[i].style.display="none";
        }
        else {
            x[i].style.display="list-item";                 
        }
    }
}

// function toggleTree() {
//   // Para usar a função na sua página HTML, você pode chamá-la em algum lugar após o   
//   // carregamento do DOM, por exemplo, no evento "DOMContentLoaded":
//   // document.addEventListener("DOMContentLoaded", function() {toggleTree();});    
//     var togglers = document.querySelectorAll(".rootTree");
  
//     Array.from(togglers).forEach(item => {
//       item.addEventListener("click", () => {
//         item.parentElement.querySelector(".children").classList.toggle("active");
//         item.classList.toggle("rootTree-down");
//       });
//     });
//   }
  
function toggleTree() {
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
  }
  

//Testes:
// var x  = '10';
// console.log(  x == 10 );
// retorna true.