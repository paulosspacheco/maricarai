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
    return '/blog.pssp.app.br/';
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



//Testes:
// var x  = '10';
// console.log(  x == 10 );
// retorna true.