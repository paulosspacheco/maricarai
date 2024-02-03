unit mi.rtl.ui.dmxscroller.inputbox;
{:< A unit **@name** implementa a classe genérica **TMI_UI_InputBox** com objtivo
  do pacote maricarai possa comunicar-se com usuário nas interfaces visuais na qual
  for implementado inputBox.
}

{$mode Delphi}

interface

uses
  Classes, SysUtils
  ,System.UITypes
  ,fpjson
  ,mi.rtl.objects.Methods.Exception
  ,mi.rtl.Objects.Consts.Mi_MsgBox
  ,mi_rtl_ui_Dmxscroller;
//  ,mi_rtl_ui_dmxscroller_form;

Type
  TMI_UI_InputBox = class;
  TModalResult   = System.UITypes.TModalResult;
  TUiDmxScroller = mi_rtl_ui_Dmxscroller.TUiDmxScroller;
  pDmxFieldRec   = mi_rtl_ui_Dmxscroller.pDmxFieldRec;

  {$REGION ' --->  Tipos procedures of object '}

    TOnInputBox = function (aTitle   : AnsiString;
                            aTemplate: AnsiString;
                            aOnCloseQuery:TOnCloseQuery ;
                            aFont    : AnsiString;
                            aOnEnter:TOnEnter ;
                            aOnExit:TOnExit;
                            aOnEnterField:TOnEnterField;
                            aOnExitField:TOnExitField;
                            {: O parâmetro @name recebe }
                            aIn_JSONObject: TJSONObject;

                            {: Se o botão MrOk for pressionado aForm retorna um formulário tipo TMI_UI_InputBox }
                            out aOut_JSONObject: TJSONObject
                            ): TModalResult of Object unimplemented;

  {$ENDREGION ' --->  Tipos e function of object '}

  { TMI_InputBoxTypes}
  {: A classe **@name** reune os tipos utilizados na classe TMI_InputBox.}

  TMI_InputBoxTypes =
  Class(TMI_MsgBoxTypes)
  end;



  { TMI_UI_InputBox }
  {: A classe **@name** é uma interface abstrata que implementa o método inputbox}
  TMI_UI_InputBox = class(TMI_InputBoxTypes)

    {$REGION ' ---> Property onInputBox : TonInputBox '}
        strict Private Var _onInputBox : TonInputBox;
        Published property  onInputBox: TonInputBox Read _onInputBox   Write  _onInputBox;
    {$ENDREGION}

    {: O Método **@name** gera um formulário baseado no template passado em **aTemplate** .

       - **PARÂMETROS**
         - aTitle   : AnsiString;
           - Título do formulário;

         - aTemplate: AnsiString;
           - Modelo do formulário onde:
             - O caractere ~ marca o inicio e o fim dos rótulos;
             - O caractere \ marca o inicio do buffer dos campos onde:
               - s : Caractere alfanumericos minusculos e maiusculos;
               - S : Caractere alfanumericos maiusculos;
               - L : Inteiro longo de 4 bytes;
               - # : Indica que na posição só pode editar número alfanumérico;
               - chFN : Informa que a sequencia a seguir é o nome do campo;

               - ^M : Fim de linha;

         - aOnCloseQuery:TOnCloseQuery ;
         - aFont    : AnsiString;
         - aOnEnter:TOnEnter ;
         - aOnExit:TOnExit;
         - aOnEnterField:TOnEnterField;
         - aOnExitField:TOnExitField;
         - aIn_JSONObject :TJSONObject;
           - conteúdo inicial do formulário;
         
                              
       - **RETORNA** 
         - TModalResult; 
           - Botão MrOk : 
             - Se confirmado.
           - Botão MrCancel; 
             - Se não confirmado.

         - aOut_JSONObject: TJSONObject
           - Retorna neste parâmetro os dados editados do formulário;    

       - Exemplo de uso está no método testInputBox dor formulário TMI_UI_InputBox_lcl:

         ```pascal

           class procedure TMI_UI_InputBox_lcl.testInputBox;
             var
               in_JObject,
               out_JObject : TJSONObject;
           begin
             with TMi_rtl,MI_UI_InputBox do
             begin
               in_JObject := TJSONObject.Create(['id'      , 1,
                                                 'nome'    ,'Paulo Sérgio',
                                                 'endereco','Rua Francisco de Souza Oliveira',
                                                 'cep'     ,'61624-300']);

               //Exemplo com eventos
               if InputBox('Teste com eventos',
                   ' ~Id:      ~\LLLLLL'+chFN+'id'+^M+
                   ' ~Nome:    ~\sssssssssssssssssssssssssssss`sssssssssssssssssssss'+ChFN+'Nome'+^M+
                   ' ~Endereço:~\sssssssssssssssssssssssssssss`ssssssssssssssssssssssss'+ChFN+'Endereco'+^M+
                   ' ~Cep:     ~\##.###-###'+ChFN+'cep'+^M
                   ,  nil,'',nil,nil,nil,nil
                   ,in_JObject
                   ,out_JObject) = mrok
               then begin

                      in_JObject.free;
                      out_JObject.free;
                    end;

             end;

           end;

         ```

    }
    public function InputBox (aTitle   : AnsiString;
                              aTemplate: AnsiString;
                              aOnCloseQuery:TOnCloseQuery ;
                              aFont    : AnsiString;
                              aOnEnter:TOnEnter ;
                              aOnExit:TOnExit;
                              aOnEnterField:TOnEnterField;
                              aOnExitField:TOnExitField;
                              {: Recebe o conteúdo do formulário em um json }
                              aIn_JSONObject :TJSONObject;

                              {: Rertorna o conteúdo do formulário em um json }
                              out aOut_JSONObject: TJSONObject
                              ): TModalResult; overload;

    {: O Método **@name** recebe um template de um formulário, um json em aIn_JSONObject
       dos dados iniciais e retorna os dados digitados no json aOut_JSONObject e em
       result da função retorna o iteiro MrOk ou mrCancel.


       - Exemplo de uso está no método testInputBox dor formulário TMI_UI_InputBox_lcl:

         ```pascal


         ```
    }
    public function InputBox (aTitle   : AnsiString;
                              aTemplate: AnsiString;

                              {: Recebe o conteúdo do formulário em um json }
                              aIn_JSONObject :TJSONObject;

                              {: Rertorna o conteúdo do formulário em um json }
                              out aOut_JSONObject: TJSONObject
                              ): TModalResult; overload;

    {: O Método @name recebe um template de um formulário, o evento **aOnCloseQuery**,
       um json em **aIn_JSONObject** dos dados iniciais e retorna em os dados digitados
       em **aOut_JSONObject** se o botão MrOk for pressionado.

       - Exemplo de uso está no método testInputBox dor formulário TMI_UI_InputBox_lcl:

         ```pascal

         ```
    }
    public function InputBox (aTitle   : AnsiString;
                              aTemplate: AnsiString;

                              {: Recebe o evento que faz crítica antes de fechar o formulário }
                              aOnCloseQuery:TOnCloseQuery ;

                              {: Recebe o conteúdo do formulário em um json }
                              aIn_JSONObject :TJSONObject;

                              {: Rertorna o conteúdo do formulário em um json }
                              out aOut_JSONObject: TJSONObject
                              ): TModalResult; overload;
  end;

  {: A Classe **name** deve ser implementado na plataforma destino

     - Unit onde essa classe é  implementada na plataforma desktop:
       - MI_UI_InputBox_lcl_u
     - Referência:
       - [Class reference type](https://www.freepascal.org/docs-html/ref/refse35.html)
  }
  TMI_UI_InputBox_class = Class of TMI_UI_InputBox;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Mi.Rtl', [TMI_UI_InputBox]);
end;

{ TMI_UI_InputBox }



function TMI_UI_InputBox.InputBox(aTitle: AnsiString;
                                  aTemplate: AnsiString;
                                  aOnCloseQuery: TOnCloseQuery;
                                  aFont: AnsiString;
                                  aOnEnter: TOnEnter;
                                  aOnExit: TOnExit;
                                  aOnEnterField: TOnEnterField;
                                  aOnExitField: TOnExitField;
                                  aIn_JSONObject :TJSONObject;
                                  out aOut_JSONObject: TJSONObject): TModalResult;
begin
  if Assigned(onInputBox)
  then begin
         If (Not ok_Set_Transaction)
         then begin
                Result := OnInputBox(aTitle,
                                     aTemplate,
                                     aOnCloseQuery,
                                     aFont,
                                     aOnEnter,
                                     aOnExit,
                                     aOnEnterField,
                                     aOnExitField,
                                     aIn_JSONObject,
                                     aOut_JSONObject);
              end
         else Raise TException.Create(self,'InputBox','Não pode executar entrada de dados dentro de uma tranasação!');
       end;
end;

function TMI_UI_InputBox.InputBox(aTitle: AnsiString;
                                  aTemplate: AnsiString;
                                  aIn_JSONObject: TJSONObject;
                                  out aOut_JSONObject: TJSONObject): TModalResult;
begin
 result := InputBox(aTitle,aTemplate,nil,'',nil,nil,nil,nil, aIn_JSONObject,aOut_JSONObject);
end;

function TMI_UI_InputBox.InputBox(aTitle: AnsiString; aTemplate: AnsiString;
                                  aOnCloseQuery: TOnCloseQuery;
                                  aIn_JSONObject: TJSONObject; out
                                  aOut_JSONObject: TJSONObject): TModalResult;
begin
  result := InputBox(aTitle,aTemplate,aOnCloseQuery,'',nil,nil,nil,nil, aIn_JSONObject,aOut_JSONObject);
end;



end.

