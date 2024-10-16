unit u_conts;
{:< A unit **@name** usado para concentrar as constantes do projeto create_tipuesearch.

  - **Obs**:
    - Se a diretiva **Var** for trocada para a diretiva **Const** as variáveis abaixo não
    podem ser alteradas.


}
{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;


var

  {:A contante **@name** contem o nome do arquivo json gerado.}
  HTMLFileResult_json : string = '/home/paulosspacheco/blog.pssp.app.br/tipuesearch_content.js';

  {:A contante **@name** contém o nome do arquivo html gerado.}
  HTMLFileResult_mapa_site : string = '/home/paulosspacheco/blog.pssp.app.br/mapa_do_site.html';

implementation

end.

