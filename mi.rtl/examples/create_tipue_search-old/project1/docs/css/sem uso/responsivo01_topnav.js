
/**Menu de opções que deve ser incluídos no modelo de página.
 * Exemplo de inclusão deste arquivo:
 *   <code>
 *     <div class="topnav" id="myTopnav">
 *       <script type="application/x-javascript" src="./responsivo01_topnav.js"></script>
 *     </div>
 *   </code>
 * O código acima inclui um menuBar no local onde o código for inserido.
 * Data da criação: 05/10/2020
 * Data da atualização: 05/10/2020
 * Autor: Paulo Sérgio da Silva Pacheco
 */

function getMainMenu(){
    var s = '';
    try {         
        s = '<!-- <div class="topnav">  menu de opções-->'+
       //     '<div class="topnav" id="myTopnav"> '+
            '    <a href="#home" class="active">Home</a>'+
            '    <a href="#news">News</a> '+
            '    <a href="#contact">Contact</a>'+
            '    <div class="dropdown"> '+
            '      <button class="dropbtn"> '+
            '          Dropdown '+
            '          <i class="fa fa-caret-down">   </i> '+
            '      </button>'+
            '      <div class="dropdown-content"> '+
            '           <a href="#">Link 1 </a> '+
            '           <a href="#">Link 2 </a> '+
            '           <a href="#">Link 3 </a> '+
            '      </div>'+
            '    </div>'+
            '    <a href="#about">About</a> '+
            '    <a href="javascript:void(0);" style="font-size:15px;"  class="icon" onclick="myTopnav_menu()">☰</a> ';
        //    '</div>'
            
            ;

    } catch (error) {
        alert(error);
        s = 'erro inesperado na contrução do menubar'; 
    }
    return s;
}    

menuBar = getMainMenu();
if (menuBar == null ) {

  document.write('menuBar indefinido') ;
  
  alert('menuBar indefinido');

};
document.getElementById("myTopnav").innerHTML = menuBar;

//document.write(menuBar) ;

  
