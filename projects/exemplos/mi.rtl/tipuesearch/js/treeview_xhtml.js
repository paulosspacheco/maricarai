/* <script>  Usado com css treeview-xhtml.css
   Data: 05/11/2020
*/
    /*debugger; desabilita depuração*/
    console.log('executou treeview_xhtml.js');
    var toggler = document.querySelectorAll(".rootTree");
    Array.from(toggler).forEach(item => {
      item.addEventListener("click", () => {
        item.parentElement.querySelector(".children").classList.toggle("active");
        
        item.classList.toggle("rootTree-down");
      });
    });
/*   </script> */