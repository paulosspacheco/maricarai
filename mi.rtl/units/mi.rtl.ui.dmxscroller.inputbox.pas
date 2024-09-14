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
    form : TComponent;
    public Destructor destroy;override;

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
               in_JSONObject,
               out_JSONObject : TJSONObject;
           begin
             with TMi_rtl,MI_UI_InputBox do
             begin
               in_JSONObject := TJSONObject.Create(['id'      , 1,
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
                   ,in_JSONObject
                   ,out_JSONObject) = mrok
               then begin

                      in_JSONObject.free;
                      out_JSONObject.free;
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


    Public function InputBox(const
                              aTitle,
                              aLabel: AnsiString;
                              var
                                aValue: Variant; {:< uffer da variável para ler.}
                              Template: AnsiString
                           ): TModalResult; overload;


    {: O método **@name** ler um valor na tela e retorna em **aValue** o valor e em result
       retorna **MrOk** ou **MrCancel**}

    Public function InputValue(const aTitle,
                                aLabel: AnsiString;
                                var aValue : Variant
                               ): TModalResult;


    public function InputPassword(aTitle: AnsiString; out  aUsername: AnsiString; out apassword: AnsiString): TModalResult;overload;

    Public function InputPassword(const aTitle:AnsiString;out aPassword : AnsiString): TModalResult;Overload;



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


destructor TMI_UI_InputBox.destroy;
begin
  //if form<>nil
  //Then begin
  //       FreeAndNil(form);
  //       inherited Destroy;
  //     end
  //else inherited Destroy;
  inherited Destroy;
end;

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
  if self=nil
  then begin
         Raise TException.Create(self,'InputBox','O método mi.rtl.Objects.Methods.Paramexecucao.Application.TApplication.CreatForm não implementado!');
       end;

  if Assigned(_onInputBox)
  then begin
         If (Not ok_Set_Transaction) and
            (Not get_ok_Set_Server_Http)
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

function TMI_UI_InputBox.InputValue(const aTitle, aLabel: AnsiString; var aValue: Variant): TModalResult;
  var
    aIn_JSONObject :TJSONObject;
    aOut_JSONObject :TJSONObject;
    value : String;
begin
  value := aValue;
  aIn_JSONObject := TJSONObject.Create(['value',Value]);
  result := InputBox(aTitle,' ~'+aLabel+':~'+'\ssssssssssssssssssssssssssssss`'+TUiDmxScroller.ConstStr(150,'s')+chFN+'value',nil,'',nil,nil,nil,nil, aIn_JSONObject,aOut_JSONObject);
  if Result = MrOk
  Then begin
         aValue := aOut_JSONObject.Strings['value'];
         FreeAndNil(aOut_JSONObject);
       end;
  FreeAndNil(aIn_JSONObject);
end;

function TMI_UI_InputBox.InputBox(const aTitle, aLabel: AnsiString; var aValue: Variant; Template: AnsiString): TModalResult;
  var
    aIn_JSONObject :TJSONObject;
    aOut_JSONObject :TJSONObject;
    n : String;
begin
  aIn_JSONObject := TJSONObject.Create(['aValue',aValue]);
  Template := Template+^M;
  result := InputBox(aTitle,Template,nil,'',nil,nil,nil,nil, aIn_JSONObject,aOut_JSONObject);
  if Result = MrOk
  Then begin
         n  := aIn_JSONObject.Names[0];
         aValue := aOut_JSONObject.Strings[n];
         FreeAndNil(aOut_JSONObject);
       end;
  FreeAndNil(aIn_JSONObject);
end;

function TMI_UI_InputBox.InputPassword(const aTitle: AnsiString;  out aPassword: AnsiString): TModalResult;
  var
    aIn_JSONObject :TJSONObject;
    aOut_JSONObject :TJSONObject;
begin
  aPassword := '';
  aIn_JSONObject := TJSONObject.Create(['password',aPassword]);
  result := InputBox(aTitle
                     ,' ~ ~'+'\ssssssssssssssssssss`ssssssssssssssssssssssssssssssssssssssssssss'+CharShowPassword+chFN+'password'+^M
                     ,nil,'',nil,nil,nil,nil, aIn_JSONObject,aOut_JSONObject);
  if Result = MrOk
  Then begin
         aPassword := aOut_JSONObject.Strings['password'];
         FreeAndNil(aOut_JSONObject);
       end;
  FreeAndNil(aIn_JSONObject);
end;

function TMI_UI_InputBox.InputPassword(aTitle: AnsiString; out  aUsername: AnsiString; out apassword: AnsiString): TModalResult;
  var
    aIn_JSONObject :TJSONObject;
    aOut_JSONObject :TJSONObject;

begin
  aUsername := '';
  apassword := '';
  aIn_JSONObject := TJSONObject.Create(['username',aUserName,
                                        'password',aPassword ]);
  Result := InputBox(aTitle,' ~Login: ~'+'\ssssssssssssssssssssssssssssss`ssssssssssssssssssssssssssssssssssssssssssssssssssss'+chFN+'username'+^M
                           +' ~Senha: ~'+'\ssssssssssssssssssssssssssssss`sssssssssssssssssssssssssssssssss'+CharShowPassword+chFN+'password'+^M
                    ,nil,'',nil,nil,nil,nil, aIn_JSONObject,aOut_JSONObject);
  if Result= MrOk
  Then begin
         aUsername := aOut_JSONObject.Strings['username'];
         aPassword := aOut_JSONObject.Strings['password'];
         FreeAndNil(aOut_JSONObject);
       end;

  FreeAndNil(aIn_JSONObject);

end;




end.

