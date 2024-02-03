

var s = '';

s =      '<!-- <div class="topnav">  menu de opções-->'+
         '<div class="topnav" id="myTopnav"> '+
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
         '    <a href="javascript:void(0);" style="font-size:15px;"  class="icon" onclick="myTopnav_menu()">☰</a> '+
         '</div>';

document.writeln(s);