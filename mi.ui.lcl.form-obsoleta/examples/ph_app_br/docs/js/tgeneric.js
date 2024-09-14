/* 
  IMPLEMENTAÇÃO DA CLASS GENERIC
    Data: 06/11/2020
    Autor: Paulo Pacheco
    Finalidade: Essa classe tem como finalidade implemtar os métodos genérico que uso no site.
*/

class Tgeneric {
  constructor() {
    this._alias = "class.tgeneric()";
  }

  /* Criar a propriedade alias */
  get alias() {
    return this._alias;
  }
  set alias(aalias) {
    this._alias = aalias;
  }

  /*Escreve x em innerHTML do elemento id*/
  write(id, x) {
    var el = document.getElementById(id);
    if (el == null)
      alert('O identificador "' + id + '" não existe em document!');
    else el.innerHTML = x;
  }
  /*Escreve x em innerHTML do elemento id e posiciona a escrita na próxima linha*/
  writeln(id, x) {
    var el = document.getElementById(id);
    if (el == null)
      alert('O identificador "' + id + '" não existe em document!');
    else el.innerHTML = x + "<br>";
  }
  /*Omite ou mostra o elemento HTML*/
  displayOnOff(id) {
    var display = document.getElementById(id).style.display;
    if (display == "none") document.getElementById(id).style.display = "block";
    else document.getElementById(id).style.display = "none";
  }
  /**
   * Mostra auto da página
   */
  displayAuthor(id) {
    var el = document.getElementById(id);
    if (el == null)
      alert('O identificador "' + id + '" não existe em document!');
    else el.innerHTML = "Paulo Pacheco" + "<br>";
  }

  /*Define a cor do elemento html*/
  color(id, cor) {
    var el = document.getElementById(id);
    if (el == null)
      alert('O identificador "' + id + '" não existe em document!');
    else el.style.color = cor;
  }


  /* - A dunção #name  adiciona um comportamento de alternância a todos os elementos 
       HTML com a classe .rootTree, permitindo que o usuário expanda e contraia seções de conteúdo 
       clicando em um triângulo preto apontando para a direita ou para baixo, dependendo do estado 
       atual do elemento. 
  */
  alternaRootTree() {
    /* - Selecionar  todos os elementos HTML com a classe .rootTree e armazena-os em uma variável 
         chamada alterna */
    var alterna = document.querySelectorAll(".rootTree");

    if (alterna == null) {
      /* Se não houver nenhum elemento com a classe .rootTree, a função exibe um alerta com a mensagem 
         “Não existe classe ‘.rootTree’” */
      alert('Não exite classe ".rootTree"');
    } else {
      /* o método Array.from() converte a lista de elementos HTML em um array.*/
      Array.from(alterna).forEach( /* método forEach() para iterar sobre cada elemento do array */
        /* Para cada elemento, a função adiciona um ouvinte de eventos de clique que executa duas ações:*/
        (item) => {
          item.addEventListener("click", () => {
            /* Torna a classe .children do elemento pai do elemento atual ativa ou inativa, dependendo do 
               seu estado atual. */
            item.parentElement.querySelector(".children").classList.toggle("active");

            /* Alterna a classe .rootTree-down do elemento atual*/  
            item.classList.toggle("rootTree-down");
          });
        }
      );
    }
  }



  /**
   *
   * @param {Script javascript} codejs
   * Retorna true se o codejs foi carregado
   * retorna a descrição do error se não foi carregado
   */
  defer(codejs) {
    try {
      var x = document.getElementById(codejs).defer;
      return true;
    } catch (error) {
      return error;
    }
  }

  createTemplatFooter() {
    document.write(
      //      "<meta name='createDate' content='10/11/2020'>"+
      //      "<meta name='createDateUpdate' content='11/11/2020'>"+
      "<meta name='author' content='Paulo Sérgio da Silva Pacheco'>" +
        "<meta name='e_mail' content='paulosspacheco@yahoo.com.br'>" +
        "<meta name='local' content='Icaraí - Caucaia - Ceará - Brasil'>"
    );

    document.write(
      "<div class='footer'> <br>" +
        "<table style='width: 100%;'> <br>" +
        "    <tbody> <br>" +
        "        <tr> <br>" +
        "            <td style='text-align: left; vertical-align: middle; background-color: white;'> <br>" +
        "                <pre class='pre1'> <br>" +
        "                    Data da criaçãoo:           <span id='createDate'>??????</span> <br>" +
        "                    Data da ultima atualização: <span id='createDateUpdate'>??????</span> <br>" +
        "                    Autor: <span id='author'>??????</span> <br>" +
        "                    Email: <span id='e_mail'>??????</span> <br>" +
        "                    Local: <span id='local'>??????</span> <br>" +
        "                </pre> <br>" +
        "            </td> <br>" +
        "        </tr> <br>" +
        "    </tbody> <br>" +
        "  </table> <br>" +
        "<div></div> <br>"
    );
  }
  displayBarTitle() {
    try {
      if (document.getElementsByName("title")[0] !== null) {
        var title = document.getElementById("title");
        if (title !== null) title.innerHTML = document.title;
      }
    } catch (error) {
      console.log(error);
    }
  }

  setInnerHTML(aInnerHtml) {
    if (aInnerHtml !== null)
    try {
      if (document.getElementsByName(aInnerHtml)[0] !== null) {
        var createDate = document.getElementsByName(aInnerHtml)[0].content;
        if ((createDate !== null) && (document.getElementById(aInnerHtml) !== null ))  
        {
          if (document.getElementById(aInnerHtml).innerHTML !== null)
            document.getElementById(aInnerHtml).innerHTML = createDate;
        }
      }
    } catch (error) {
      console.log(error);
    }
  }
  /**
   * diplay footer imprime as variáveis do rodapé da página
   */
  displayFooter() {
    //this.createTemplatFooter();
    this.setInnerHTML("createDate");

    // try {
    //   if (document.getElementsByName("createDate")[0] !== null)
    //   {
    //     var createDate = document.getElementsByName("createDate")[0].content;
    //     if (createDate !== null)
    //       document.getElementById("createDate").innerHTML = createDate;
    //   }

    // } catch (error) {
    //   console.log(error);
    //}

    this.setInnerHTML("createDateUpdate");
    // try {
    //   if (document.getElementsByName("createDateUpdate")[0] !== null)
    //   {
    //     var createDateUpdate = document.getElementsByName("createDateUpdate")[0].content
    //     if (createDateUpdate !== null)
    //       document.getElementById("createDateUpdate").innerHTML = createDateUpdate;
    //   }
    // } catch (error) {
    //   console.log(error);
    // }

    this.setInnerHTML("author");
    // try {
    //   if (document.getElementsByName("author")[0] !== null)
    //   {
    //     var author = document.getElementsByName("author")[0].content
    //     if (author !== null)
    //       document.getElementById("author").innerHTML = author;
    //   }
    // } catch (error) {
    //   console.log(error);
    // }

    this.setInnerHTML("e_mail");
    // try {
    //   if (document.getElementsByName("e_mail")[0] !== null)
    //   {
    //     var e_mail = document.getElementsByName("e_mail")[0].content
    //     if (e_mail !== null)
    //       document.getElementById("e_mail").innerHTML = e_mail;
    //   }

    // } catch (error) {
    //   console.log(error);
    // }

    this.setInnerHTML("local");
    // try {
    //   if (document.getElementsByName("local")[0] !== null)
    //   {
    //     var local = document.getElementsByName("local")[0].content
    //     if (e_mail !== null)
    //       document.getElementById("local").innerHTML = local;
    //   }
    // } catch (error) {
    //   console.log(error);
    // }
  }

  display() {
    try {
      this.displayBarTitle();
    } catch (error) {
      console.log(error);
    }
    try {
      this.displayFooter();
    } catch (error) {
      console.log(error);
    }
  }
} /*end class Tgeneric */

/**
 * Função usada para incluir um arquivo dentro do código html
 * obs: O arquivo não pode ter a extensção .html e sim .txt ou .inc
 * Exemplo de uso:
 *    <bodY>
 *      <div w3-include-html="content.html"></div>
 *      <script>
 *        includeHTML();
 *      </script>
 *     </body>
 */

function includeHTML() {
  var z, i, elmnt, file, xhttp;
  /* Loop through a collection of all HTML elements: */
  z = document.getElementsByTagName("*");
  for (i = 0; i < z.length; i++) {
    elmnt = z[i];
    /*search for elements with a certain atrribute:*/
    file = elmnt.getAttribute("w3-include-html");
    if (file) {
      /* Make an HTTP request using the attribute value as the file name: */
      xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function () {
        if (this.readyState == 4) {
          if (this.status == 200) {
            elmnt.innerHTML = this.responseText;
          }
          if (this.status == 404) {
            elmnt.innerHTML = "Page not found.";
          }
          /* Remove the attribute, and call this function once more: */
          elmnt.removeAttribute("w3-include-html");
          includeHTML();
        }
      };
      xhttp.open("GET", file, true);
      xhttp.send();
      /* Exit the function: */
      return;
    }
  }
}

/* Variavel global generic*/
generic = new Tgeneric();
generic.alternaRootTree();
