
/**Menu de opções que deve ser incluídos no modelo de página.
 * Exemplo de inclusão deste arquivo:
 *   &lsaquo;code>
 *     &lsaquo;div class="topnav" id="myTopnav">
 *       &lsaquo;script type="application/x-javascript" src="./responsivo01_topnav.js">&lsaquo;/script>
 *     &lsaquo;/div>
 *   &lsaquo;/code>
 * O código acima inclui um menuBar no local onde o código for inserido.
 * Data da criação: 05/10/2020
 * Data da atualização: 05/10/2020
 * Autor: Paulo Sérgio da Silva Pacheco
 */

function getInfraStructurTI() { 
  try {
  
  var result =   
  '    &lsaquo;div class="dropdown"> '+
  '      &lsaquo;button class="dropbtn"> '+
  '          Infraestrutura de TI'+
  '          &lsaquo;i class="fa fa-caret-down">   &lsaquo;/i> '+
  '      &lsaquo;/button>'+
  '      &lsaquo;div class="dropdown-content"> '+
  '           &lsaquo;a href="#">Link 1 &lsaquo;/a> '+
  '           &lsaquo;a href="#">Link 2 &lsaquo;/a> '+
  '           &lsaquo;a href="#">Link 3 &lsaquo;/a> '+
  '      &lsaquo;/div>'+
  '    &lsaquo;/div>';  

      } catch (error) {
          console.log('Error: '+error); 
            alert(error);
  //          result = "";
      } 
  //console.log('getInfraStructurTI().result: '+result)
  return result;
}

function getMainMenu(){

    var result = '';
    var InfraStructurTI = '';

    this.InfraStructurTI = getInfraStructurTI();
    console.log('Infra strutura: '+this.InfraStructurTI ); 

    try {         
        result = 
            '&lsaquo;!-- &lsaquo;div class="topnav">  menu de opções-->'+
       //     '&lsaquo;div class="topnav" id="myTopnav"> '+
            '    &lsaquo;a href="#home" class="active">Home&lsaquo;/a>'+
            '    &lsaquo;a href="#news">News&lsaquo;/a> '+
            '    &lsaquo;a href="#contact">Contact&lsaquo;/a>'+
                 this.InfraStructurTI +
            '    &lsaquo;a href="#about">About&lsaquo;/a> '+
            '    &lsaquo;a href="javascript:void(0);" style="font-size:15px;"  class="icon" onclick="myTopnav_menu()">☰&lsaquo;/a> ';
        //    '&lsaquo;/div>'
            
            ;

    } catch (error) {
        alert(error);
        result = 'erro inesperado na contrução do menubar'; 
    }
    return result;
}    

var menuBar = getMainMenu();
if (this.menuBar == null ) {

  document.write('menuBar indefinido') ;
  
  alert('menuBar indefinido');

};
console.log(this.menuBar)

document.getElementById("myTopnav").innerHTML = this.menuBar;

//document.write(menuBar) ;

  
