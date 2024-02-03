//TODO: Menu de opções que deve ser incluídos no modelo de página.
/**
 *
 * Exemplo de inclusão deste arquivo:
 *   <cfode>
 *     <div class="topnav" id="myTopnav">
 *       <script type="application/x-javascript" src="./responsivo01_topnav.js"></script>
 *     </div>
 *   </cfode>
 * O código acima inclui um menuBar no local onde o código for inserido.
 * Data da criação: 05/10/2020
 * Data da atualização: 05/10/2020
 * Autor: Paulo Sérgio da Silva Pacheco
 */

class THelpCtx {
  constructor(aowner, aalias) {
    var towner = THelpCtx;
    this.owner = towner;

    this.owner = aowner;
    this.alias = aalias;

    this.helpCtx_Historico = ""; //O atributo HelpCtx_Historico armazena um texto indicativo da alterações do documento
    this.helpCtx_Porque = ""; //O atributo HelpCtx_Porque armazena porque este documento é necessário
    this.helpCtx_Onde = ""; //O atributo HelpCtx_Onde armazena onde este documento é usado
    this.helpCtx_Como = ""; //O atributo HelpCtx_Como armazena como este documento é usado
    this.helpCtx_Quais = ""; // O atributo HelpCtx_Quais armazena um texto indicativo de onde este documento será usado
    this.helpCtx_Hint = ""; //Criação da propriedade HelpCtx_Hint
  }
}

//import THelpCtx from ('../js/thelpctx.js') ;

class TMenuBar extends THelpCtx {
  constructor(aowner, aalias, apathRaiz) {
    super(aowner, aalias);
    this.alias = aalias;
    this.pathRaiz = apathRaiz;
    //console.log(this.path);
    this.menu = "";

  }
 
  SetMenu() {
    try {
      /*this.menu = '<a href=\"' + this.pathRaiz + 'index.html" class="active">Home</a>' +*/
      this.menu =   '<a href="' + this.pathRaiz +  'index.html">Home</a>' +
                    //this.infraestruturaTI =
                    '    <div class="dropdown"> ' +
                    '      <button class="dropbtn"> ' +
                    "          Infraestrutura de TI" +
                    '          <i class="fa fa-caret-down">   </i> ' +
                    "      </button>" +
                    '      <div class="dropdown-content"> ' +
                    '           <a href="' +this.pathRaiz+'infraestrutura/linux/shell/index.html">Comandos do shell do Linux </a> ' +
                    '           <a href="' +this.pathRaiz+'infraestrutura/linux/flatpak/index.html">Aplicativo flatpak </a> ' +
                    '           <a href="' +this.pathRaiz+'infraestrutura/linux/git/index.html">Aplicativo Git </a> ' +
                    '           <a href="' +this.pathRaiz+'infraestrutura/linux/nfs/index.html">Network File System (NFS) </a> ' +
                    "           ------> Internet <------<br>" +
                    '           <a href="' +this.pathRaiz +'infraestrutura/linux/servidor-web-apache/index.html">Servidor Web Apache2 </a> ' +
                    '    <div class="dropdown"> ' +
                    '      <button class="dropbtn"> ' +
                    '         "Infraestrutura de TI"' +
                    '          <i class="fa fa-caret-down">   </i> ' +
                    "      </button>" +
                    '           <div class="dropdown-content"> ' +
                    '              <a href="' +this.pathRaiz+'infraestrutura/linux/shell/index.html">Comandos do shell do Linux </a> ' +
                    '              <a href="' +this.pathRaiz+'infraestrutura/linux/git/index.html">Aplicativo Git </a> ' +
                    '           <a href="' +this.pathRaiz+'infraestrutura/linux/nfs/index.html">Network File System (NFS) </a> ' +                    
                    '           </div>'+
                    "      </div>" +                    
                    "      </div>" +
                    "    </div>"+                      
                    //this.programacao =
                    '    <div class="dropdown"> ' +
                    '      <button class="dropbtn"> ' +
                    "          Programacao" +
                    '          <i class="fa fa-caret-down">   </i> ' +
                    "      </button>" +
                    '      <div class="dropdown-content"> ' +
                    '           <a href="' + this.pathRaiz + 'programacao/html/js/index.html">Linguagem javascript </a> ' +
                    '           <a href="' + this.pathRaiz + 'programacao/html/json/index.html">Linguagem json </a> ' +
                    '           <a href="' + this.pathRaiz + 'programacao/html/typescript/index.html">Linguagem typescript </a> ' +
                    '           <a href="' + this.pathRaiz + 'programacao/html/markdown/index.html">Linguagem Markdown </a> ' +
                    '           <a href="' + this.pathRaiz + 'programacao/nodejs/index.html">Runtime typescript nodejs </a> ' +                   
                    "      </div>" +
                    "    </div>"+                    
                    //this.linguagemHumana =
                    '    <div class="dropdown"> ' +
                    '      <button class="dropbtn"> ' +
                    "          Linguagem Humana" +
                    '          <i class="fa fa-caret-down">   </i> ' +
                    "      </button>" +
                    '      <div class="dropdown-content"> ' +
                    '           <a href="' +this.pathRaiz +'linguas_humanas/portugues/producao_de_textos/index.html">Produção de textos </a> ' +
                    "      </div>" +
                    "    </div>"+
                    '<a href="' + this.pathRaiz +'./js/footer.html">Sobre</a>' +
                    '<a href="javascript:void(0);'+
                    ' style="font-size:15px;" class="icon" onclick="myTopnav_menu()">☰</a> ;'
    } catch (error) {
      //alert(error);
      this.menu = "erro inesperado na construção do menubar";
    }
    document.getElementById("myTopnav").innerHTML = this.menu;
  }
}

function getPathRaiz() {
  //return 'file:///home/paulosspacheco/Documentos/blogger/blog.pssp.app.br/';
  //return '/blog.pssp.app.br/';
  return "../../";
}

function createMenuBar() {
  try {
    try {
      var menuBar = new TMenuBar(
        (aowner = document),
        (aalias = "Menu principal"),
        (apathRaiz = getPathRaiz())
      );
      menuBar.SetMenu();
    } catch (error) {
      //alert(error);
      console.log(error);
    }
  } finally {
    delete menuBar;
  }

  //var http = require('./index')
}

createMenuBar();
