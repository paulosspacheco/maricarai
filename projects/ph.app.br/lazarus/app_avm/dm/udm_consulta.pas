unit udm_consulta;

{$mode Delphi}

interface

uses
  Classes, SysUtils, ActnList, DB, SQLDB  
  ,mi.rtl.all  
  ,mi_rtl_ui_Dmxscroller  
  //,mi_rtl_ui_dmxscroller_form
  //,udm_connections
  ,udm_table
  ;

type

  { Tdm_consulta }

  Tdm_consulta = class(Tdm_table)
    function DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;

    {$REGION Propriedade Template}
      private _Template:AnsiString;

      {: A propriedade **@name** é usada para criar uma lista de PSItem para ser usada como modelo do formulário.

         - **NOTAS**
           - Template é um string comum, onde cada linha é separada com ^J.
           - Template tem uma lista de string com formato Dmx.
             - Formato da propriedade Template:

               ```pascal

                   Template := '~Nome do Aluno:~\Sssssssssssssssssssssssss`ssssssssssssssss'+ChFN+'Nome'+lf+
                               '~     Endereço:~\Sssssssssssssssssssssssss`ssssssssssssssss'+ChFN+'endereco'+lf+
                               '~          Cep:~\##-###-###'+ChFN+'cep'+lf+
                               '~       Bairro:~\sssssssssssssssssssssssss'+ChFN+'bairro'+lf+
                               '~       Cidade:~\sssssssssssssssssssssssss'+ChFN+'cidade'+lf+
                               '~       Estado:~\SS'+ChFN+'estado'+lf+
                               '~        Idade:~\BB'+ChFN+'idade'+FldUpperLimit+#18+lf+
                               '~    Matricula:~\III'+ChFN+'matricula'+lf+
                               '~     Valor da~'+lf+
                               '~    Mensalidade:~\R,RRR.RR'+ChFN+'mensalidade';

               ```

           - **SINTAXE**
             - **~** (til) : Limitador de rótulos do formulário;
             - **s** (s minúsculo) : caracteres alfanumérico incluindo os maiúsculas, minusculas, números e símbolos;
             - **S** (S maiúsculo) : caracteres alfanumérico incluindo os maiúsculas, números e símbolos;
             - **#** (# cancela) : Aceita somente números de 0 a 99
             - **-** (literal ) : Separador de números
             - **B** (B maiúsculo): Campo do tipo byte
             - **FldUpperLimit** : O caractere seguinte indica o limite superior da variável. No exemplo acima é 18 anos;
             - **R** : Indica um caractere de um campo do tipo double;
             - **I** : Indica um caractere de um campo do tipo interger. Faixa: -32000 a +32000;
      }
      public property Template:AnsiString read _Template write _Template;
    {$ENDREGION Propriedade Template}

    public function Sql_to_template(aSql:String):String;

    public procedure Set_Active(a_active : Boolean;a_SqlText:String);override;

    {: O método **@name** recebe um sql, e retorna um json com a lista name e valor de cada campo.

         - Exemplo:

           ```pascal

             class function Tdm_consulta.TestGetJson :TJSONObject;
               Var
                 dm_consulta : Tdm_consulta;
             begin
               try
                 dm_consulta := Tdm_consulta.Create(nil);
                 dm_consulta.Set_Active(true,'select a.nome,a.id from operadores a order by a.nome asc');

                   with dm_consulta.DmxScroller_Form1 do
                   begin
                     if FirstRec Then
                     begin
                       result := result + JSONObject+LineFeed;
                       while NextRec  do
                         result := result + JSONObject+LineFeed;
                     end;
                   end;

               finally
                 dm_consulta.Free;
               end;
             end;

           ```
    }
    public function getJson(aSql:string):TMi_rtl.TJSONObject;

    class procedure test1;
  end;


implementation

{$R *.lfm}

{ Tdm_consulta }


function Tdm_consulta.DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;
begin
  with TMi_rtl do
  begin
    if _Template  <> ''
    then Result := StringToSItem(_Template)
    else Result := nil;
  end;
end;

function Tdm_consulta.Sql_to_template(aSql: String): String;
  var
    template: String;
    columnName: String;
    i,j: Integer;
    wordsToIgnore: array [1..8] of String = ('select', 'to', 'from', 'where', 'order', 'by', 'asc', 'desc');
    ignoreColumn: Boolean;
begin
  // Inicializa a string de template
  template := '';

  // Verifica se a string SQL não está vazia
  if Length(aSql) > 0 then
  begin
    // Localiza a posição da palavra "FROM"
    i := Pos('from', LowerCase(aSql));

    // Extrai a parte da consulta SQL antes da palavra "FROM"
    if i > 0 then
    begin
      aSql := Trim(Copy(aSql, 1, i - 1));

      // Percorre as palavras da parte SELECT da consulta SQL
      i := 1;
      while i <= Length(aSql) do
      begin
        // Ignora os espaços em branco
        while (i <= Length(aSql)) and (aSql[i] in [' ', ',']) do
          Inc(i);

        // Lê o nome da coluna
        columnName := '';
        while (i <= Length(aSql)) and (not(aSql[i] in [' ', ','])) do
        begin
          columnName := columnName + aSql[i];
          Inc(i);
        end;

        // Verifica se a palavra não deve ser ignorada
        ignoreColumn := False;
        for j := 1 to Length(wordsToIgnore) do
        begin
          if columnName = wordsToIgnore[j] then
          begin
            ignoreColumn := True;
            Break;
          end;
        end;

        // Se a coluna não deve ser ignorada e não está vazia
        if (not(ignoreColumn)) and (not(columnName = '')) then
        begin
          // Adiciona a parte do template referente à coluna
          template := template + '~' + columnName + '~ \ ' + StringOfChar('s', 50)+TMi_Rtl.ChFN+columnName+lf ;
        end;
      end;
    end;
  end;

  // Retorna o template resultante
  Result := template;
end;

procedure Tdm_consulta.Set_Active(a_active: Boolean; a_SqlText: String);
begin
  _Template:= Sql_to_template(a_SqlText);

  inherited Set_Active(a_active, a_SqlText);
end;

function Tdm_consulta.getJson(aSql: string):TMi_rtl.TJSONObject;
begin
  result := DmxScroller_Form1.JSONObject;
end;

class procedure Tdm_consulta.test1;

  Var
    dm_consulta : Tdm_consulta;
begin
  try
    dm_consulta := Tdm_consulta.Create(nil);
    dm_consulta.Set_Active(true,'select operadores.nome,operadores.id from operadores order by nome asc');

    with dm_consulta.DmxScroller_Form1 do
    begin
      if FirstRec Then
      begin
        edit;
        SetArgs(['José Carlos',15]);
        UpdateRec;
        ShowMessage('operadores.nome := '+FieldByName('operadores.nome').AsString+' | '+
                    'operadores.id := '+FieldByName('operadores.id').AsString);
        while NextRec  do
          ShowMessage('operadores.nome := '+FieldByName('operadores.nome').AsString+' | '+
                      'operadores.id := '+FieldByName('operadores.id').AsString);

      end;
    end;

  finally
    dm_consulta.Free;
  end;

end;



end.

