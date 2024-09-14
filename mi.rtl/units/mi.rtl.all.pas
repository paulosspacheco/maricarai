unit mi.rtl.all;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,db,fpjson
  ,mi.rtl.treenode
  ,mi.rtl.Objects.Methods.Paramexecucao.Application
  ,mi.rtl.types
  ,mi.rtl.Consts
  ,mi.rtl.MiStringListBase
  ,mi.rtl.MiStringList
  ,mi.rtl.files
  ,mi.rtl.objects.types
  ,mi.rtl.objects.consts
  ,mi.rtl.objects.consts.MI_MsgBox
  ,mi.rtl.objects.consts.progressdlg_if
  ,mi.rtl.objects.Methods
  ,mi.rtl.objects.Methods.Dates
  ,mi.rtl.objects.methods.ParamExecucao
  ,mi.rtl.objects.Methods.Exception
  ,mi.rtl.objects.methods.StreamBase
  ,mi.rtl.objects.methods.StreamBase.Stream
  ,mi.rtl.objects.methods.StreamBase.Stream.MemoryStream
  ,mi.rtl.objects.methods.StreamBase.Stream.MemoryStream.BufferMemory
  ,mi.rtl.objects.methods.StreamBase.Stream.FileStream
  ,mi.rtl.objects.methods.Collection
  ,mi.rtl.objects.methods.Collection.SortedCollection
  ,mi.rtl.objects.methods.Collection.SortedCollection.StrCollection
  ,mi.rtl.objects.methods.Collection.SortedCollection.stringCollection
  ,mi.rtl.objects.methods.Collection.SortedCollection.stringcollection.CollectionString
  ,mi.rtl.objects.methods.Collection.FilesStreams
  ,mi.rtl.objects.methods.db.tb_access
  ,mi.rtl.objects.methods.db.tb__access
  ,mi.rtl.objects.methods.db.tb___access
  ,mi.rtl.objects.methods.pageproducer
  ,mi_rtl_ui_types
  ,mi_rtl_ui_consts
  ,mi_rtl_ui_methods
  ,mi_rtl_ui_DmxScroller_Buttons
  ,mi_rtl_ui_Dmxscroller
  ,mi.rtl.ui.dmxscroller.inputbox
  ,mi_rtl_ui_dmxscroller_form
  ,mi_rtl_ui_custom_application

  ;

type

  { TMi_rtl }

  TMi_rtl = class(TDmxScroller_Form)
    public type TApplication = mi.rtl.Objects.Methods.Paramexecucao.Application.TApplication;
    public type TFuncApplication = mi.rtl.Objects.Methods.Paramexecucao.Application.TFuncApplication;
    public class Procedure SetFuncApplication(aFuncApplication : TFuncApplication);
    //public const Application : TApplication =  nil;
    //public Class Procedure Set_MI_MsgBox(aMI_MsgBox: TMI_MsgBox);Virtual;

    //public type TTypes          = mi.rtl.types.TTypes;
    //public type TConsts         = mi.rtl.Consts.TConsts;
    //public type TStringListBase = mi.rtl.MiStringListBase.TStringListBase;
    //public type TMiStringList   = mi.rtl.MiStringList.TMiStringList;
    //public type TFiles          = mi.rtl.files.TFiles;
    //public type TObjectsTypes  = mi.rtl.objects.types.TObjectsTypes;
    //public type TObjectsConsts = mi.rtl.objects.consts.TObjectsConsts;
    //public type TObjectsMethods = mi.rtl.objects.Methods.TObjectsMethods;
    //public type TException      = mi.rtl.objects.Methods.Exception.TException;
    //public type TStreambase     = mi.rtl.objects.methods.StreamBase.TStreambase;
    //public type TStream         = mi.rtl.objects.methods.StreamBase.Stream.TStream;
    //public type TMemoryStream   = mi.rtl.objects.methods.StreamBase.Stream.MemoryStream.TMemoryStream;
    //public type TFileStream     = mi.rtl.objects.methods.StreamBase.Stream.FileStream.TFileStream;
    //public type TBufferMemory   = mi.rtl.objects.methods.StreamBase.Stream.MemoryStream.BufferMemory.TBufferMemory;

    //public type TCollection           = mi.rtl.objects.methods.Collection.TCollection;
    //public type TSortedCollection     = mi.rtl.objects.methods.Collection.SortedCollection.TSortedCollection;
    //public type TCollectionString     = mi.rtl.objects.methods.Collection.SortedCollection.stringcollection.CollectionString.TCollectionString;
    //public type TStringCollection     = mi.rtl.objects.methods.Collection.SortedCollection.stringcollection.TStringCollection;
    //public type TUnStringCollection   = mi.rtl.objects.methods.Collection.SortedCollection.stringcollection.TUnSortedStringCollection;
    //public type TStrCollection        = mi.rtl.objects.methods.Collection.SortedCollection.StrCollection.TStrCollection;
    //public type TUnStrCollection      = mi.rtl.objects.methods.Collection.SortedCollection.StrCollection.TUnSortedStrCollection;
    //public type TFilesStreams         = mi.rtl.objects.methods.Collection.FilesStreams.TFilesStreams;
    //
    //public type TDates                = mi.rtl.objects.Methods.Dates.TDates;
    //
    //public type TParamExecucao = mi.rtl.objects.methods.ParamExecucao.TParamExecucao;

    //public type TTb_Access_types = mi.rtl.objects.methods.db.tb_access.TTb_Access_types;
    //public type TTb_Access_conts = mi.rtl.objects.methods.db.tb_access.TTb_Access_consts;
    //public type Ttb_access =  mi.rtl.objects.methods.db.tb_access.TTb_Access;
    //
    //public type TTb__Access_types = mi.rtl.objects.methods.db.tb__access.TTb__Access_types;
    //public type TTb__Access_conts = mi.rtl.objects.methods.db.tb__access.TTb__Access_consts;
    //public type Ttb__access = mi.rtl.objects.methods.db.tb__access.Ttb__access;
    //
    //public type TTb___Access_types = mi.rtl.objects.methods.db.tb___access.TTb___Access_types;
    //public type TTb___Access_consts = mi.rtl.objects.methods.db.tb___access.TTb___Access_consts;
    //public type TTb___Acces = mi.rtl.objects.methods.db.tb___access.TTb___Access;

    //public Type TListBoxRec = record    {<-- omit if TListBoxRec is defined else where}
    //              PS           : TCollectionString;
    //              Selection    : longint;
    //              {: O campo a seguir devolve a pedaco da string limitadas por ~ usada para transferencia de dados}
    //              StrSelection : String;
    //            end;
    //
    public type TMi_rtl_treenode = mi.rtl.treenode.TMi_rtl_treenode;
    //public type TPageProducer = mi.rtl.objects.methods.pageproducer.TPageProducer;
    public type TUiTypes = mi_rtl_ui_types.TUiTypes;
    public type TUiConsts = mi_rtl_ui_consts.TUiConsts;
    public type TUiMethods = mi_rtl_ui_methods.TUiMethods;
    public type TUiDmxScroller_Buttons = mi_rtl_ui_DmxScroller_Buttons.TUiDmxScroller_Buttons;
    public type TUiDmxScroller = mi_rtl_ui_Dmxscroller.TUiDmxScroller;
    public type TDmxScroller_Form = mi_rtl_ui_dmxscroller_form.TDmxScroller_Form;

    public type TMI_ui_Custom_Application = mi_rtl_ui_custom_application.TMI_ui_Custom_Application;
    public const MI_ui_Custom_Application : TMI_ui_Custom_Application =  nil;

    {$REGION --> Classe da unit fpjson }

      {: O tipo **@name** é a Base (abstract) object for all JSON based data types
         - O **@name** é uma classe abstrata que apresenta todas as propriedades
           e métodos necessários para trabalhar com dados baseados em JSON.
           Nunca deve ser instanciado. Com base no tipo de dados que devem ser
           representados, um dos seguintes descendentes deve ser instanciado.
           - Números
             - deve ser representado usando um de TJSONIntegerNumber , TJSONFloatNumber
               ou TJSONInt64Number , dependendo do tipo do número.
           - Strings
             - Pode ser representado com TJSONString .
           - boleano
             - Pode ser representado com TJSONBoolean .
           - null
             - É compatível com TJSONNull
           - Array
             - Os dados podem ser representados usando TJSONArray
           - Object
             - Os dados podem ser suportados usando TJSONObject
      }
      public type TJSONData = fpjson.TJSONData;

      {: O tipo **@name** é ancestral comum para as classes JSON de valor numérico.
         - TJSONNumber é uma classe abstrata que serve como ancestral para as
           3 classes numéricas. Nunca deve ser instanciado diretamente.
           Em vez disso, dependendo do tipo de dados, um dos TJSONIntegerNumber ,
           TJSONInt64Number ou TJSONFloatNumber deve ser instanciado.
      }
      public type TJSONNumber = fpJson.TJSONNumber;

      {: O tipo **@name** representa dados JSON inteiros de 32 bits.
         - O **@name** deve ser usado sempre que dados inteiros de 32 bits precisarem
           ser representados. Para dados inteiros de 64 bits, TJSONInt64Number
           deve ser usado.
      }
      public type TJSONIntegerNumber = fpjson.TJSONIntegerNumber;

      {: O tipo **@name** representa dados JSON inteiros de 64 bits.
         - O **@name** deve ser usado sempre que dados inteiros de 64 bits precisarem
           ser representados. Para dados inteiros de 32 bits, TJSONIntegerNumber
           deve ser usado.
      }
      public type TJSONInt64Number = fpjson.TJSONInt64Number;

      {: O tipo **@name** representa dados JSON de ponto flutuante.
         - O **@name** deve ser usado sempre que dados de ponto flutuante precisarem
           ser representados. Ele pode lidar com dados TJSONFloat (normalmente duplos).
           Para dados inteiros, TJSONIntegerNumber ou TJSONInt64Number são mais adequados.
      }
      public type TJSONFloatNumber = fpjson.TJSONFloatNumber;

      {: O tipo **@name** representar dados JSON de string.
         - O **@name** deve ser usado sempre que dados de string devem ser
           representados. Atualmente a implementação usa uma string ANSI para
           armazenar os dados. Isso significa que para armazenar dados Unicode
           corretamente, uma codificação UTF-8 deve ser usada.
      }
      public type TJSONString = fpjson.TJSONString;

      {: O tipo **@name** representa dados JSON booleanos.
         - TJSONBoolean deve ser usado sempre que dados booleanos precisarem ser
           representados. Possui funcionalidade limitada para converter o valor
           de ou para dados inteiros ou de ponto flutuante.
      }
      public type TJSONBoolean = fpjson. TJSONBoolean;

      {: O tipo **@name** deve ser usado sempre que um valor nulo precisar ser representado. }
      public type TJSONNull = fpjson.TJSONNull;

      {: O tipo **@name** representa um objeto JSON.
         - Referência: [TJSONObject](https://lazarus-ccr.sourceforge.io/docs/fcl/fpjson/tjsonobject.html)
      }
      public type TJSONObject = fpjson.TJSONObject;

      {: O tipo **@name** representa dados JSON Array.}
      public type TJSONArray = fpjson.TJSONArray;
    {$ENDREGION --> Classe da unit fpjson }

    {: O método **@name** criar um dialogo com o conteúdo de um json }
    public procedure printaJsonObject(aJSONObject: TJSONObject);

    {$REGION --> Implementação da contante MI_InputBox genérica}
       public type TMI_UI_InputBox = mi.rtl.ui.dmxscroller.inputbox.TMI_UI_InputBox;

//       public Class Procedure Set_MI_UI_InputBox(aMI_UI_InputBox: TMI_UI_InputBox);Virtual;
//       public const MI_UI_InputBox: TMI_UI_InputBox = nil;
       public class Function create_MI_UI_InputBox:TMI_UI_InputBox;

       public Procedure Test_create_MI_UI_InputBox ;
       public Function create_MI_MsgBox:TMI_MsgBox;override;
       public Procedure Test_create_MI_MsgBox ;


    {$ENDREGION --> Implementação da contante MI_UI_InputBox genérica}

     Public function InputBox(aTitle   : AnsiString;
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

                             ): TModalResult;overload;

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

     public function InputBox (aTitle   : AnsiString;
                               aTemplate: AnsiString;

                               {: Recebe o evento que faz crítica antes de fechar o formulário }
                               aOnCloseQuery:TOnCloseQuery ;

                               {: Recebe o conteúdo do formulário em um json }
                               aIn_JSONObject :TJSONObject;

                               {: Rertorna o conteúdo do formulário em um json }
                               out aOut_JSONObject: TJSONObject
                               ): TModalResult; overload;

    {: O método **@name** ler um valor na tela e retorna em **aValue** o valor e em result
       retorna **MrOk** ou **MrCancel**}
    Public class function InputValue(const aTitle,aLabel: AnsiString;var aValue : Variant): TModalResult;

    {: - A função **@name** mostra um dialogo com dois botões **OK** e **Cancel** e um campo input solicitando
         que o usuário digite um valor.

       - **RETORNA:**
         - **True** : Se o botão **ok** foi pŕessionando;
         - **False** : Se o botão **cancel** foi pŕessionando.
         - **aResult** : Retorna a string digitada no formulário;
    }
    Public class Function Prompt(aTitle: AnsiString;aPergunta:AnsiString;Var aResult: Variant):Boolean;

    {: - A função **@name** mostra um dialogo solicitando o login do usuário e a senha e dois botões **OK**
         e **Cancel**

       - **RETORNA:**
         - **True** : Se o botão **ok** foi pŕessionando;
         - **False** : Se o botão **cancel** foi pŕessionando.
         - **aUsername** : Retorna a string com nome do usuário.
         - **apassword** : Retorna a string com a senha do usuário.
    }
    Public class Function InputPassword(aTitle: AnsiString;out aUsername:AnsiString;out apassword:AnsiString):Boolean;Overload;
    Public class Function InputPassword(aTitle: AnsiString;out apassword:AnsiString):Boolean;Overload;

    Public class function Locate(const aField:pDmxFieldRec): TModalResult;Virtual;
  end;

procedure register;

implementation

procedure register;
begin
  RegisterComponents('Mi.Rtl', [TMi_rtl]);
end;

{ TMi_rtl }

class procedure TMi_rtl.SetFuncApplication(aFuncApplication: TFuncApplication);
begin
  FuncApplication:= aFuncApplication;
end;

procedure TMi_rtl.printaJsonObject(aJSONObject: TJSONObject);
  var
    i : integer;
    n,v : string;
    template : AnsiString;

  var
    in_JSONObject,
    out_JSONObject : TJSONObject;
    MI_UI_InputBox : TMI_UI_InputBox;
    Len_n_Max      : Longint;
begin
   try
     MI_UI_InputBox := create_MI_UI_InputBox;

     template := '\s'+CharAccReadOnly+^M;
     //Calculado a largura do maior label
     Len_n_Max := 0;
     for i := 0 to aJSONObject.Count-1 do
     begin
       n  := aJSONObject.Names[i];
       Len_n_Max := MaxL(Len_n_Max,length(n));
     end;


     for i := 0 to aJSONObject.Count-1 do
     begin
       n  := aJSONObject.Names[i];
       v := aJSONObject.Strings[n];
       template := template+'~'+'Valor de '+spc(n,Len_n_Max)+': '+v+'~'+^M;
     end;

     with MI_UI_InputBox do
     begin

       in_JSONObject := TJSONObject.Create([]);
       if InputBox('Teste sem eventos',
          template
          ,in_JSONObject
          ,out_JSONObject) = mrok
       then begin
              FreeAndNil(out_JSONObject);
            end;

     end;
     FreeAndNil(in_JSONObject);


   finally
   end;
end;


function TMi_rtl.InputBox(aTitle: AnsiString;
                                aTemplate: AnsiString;
                                aOnCloseQuery: TOnCloseQuery;
                                aFont: AnsiString;
                                aOnEnter: TOnEnter;
                                aOnExit: TOnExit;
                                aOnEnterField: TOnEnterField;
                                aOnExitField: TOnExitField;
                                aIn_JSONObject: TJSONObject;
                                out aOut_JSONObject: TJSONObject): TModalResult;

  var
    MI_UI_InputBox : TMI_UI_InputBox;
begin
 try
   MI_UI_InputBox := create_MI_UI_InputBox;
   With MI_UI_InputBox do
       Result := InputBox(aTitle,
                            aTemplate,
                            aOnCloseQuery,
                            aFont,
                            aOnEnter,
                            aOnExit,
                            aOnEnterField,
                            aOnExitField,
                            aIn_JSONObject,
                            aOut_JSONObject);
   finally
     if Assigned(MI_UI_InputBox.OnFree_form_owner)
     then MI_UI_InputBox.OnFree_form_owner;
   end;
end;

function TMi_rtl.InputBox(aTitle: AnsiString;
                          aTemplate: AnsiString;
                          aIn_JSONObject: TJSONObject;
                          out aOut_JSONObject: TJSONObject): TModalResult;
 var
   MI_UI_InputBox : TMI_UI_InputBox;
begin
  try
    MI_UI_InputBox := create_MI_UI_InputBox;
    With MI_UI_InputBox do
      Result := InputBox(aTitle,
                          aTemplate,
                          aIn_JSONObject,
                          aOut_JSONObject);

  finally
    if Assigned(MI_UI_InputBox.OnFree_form_owner)
    then MI_UI_InputBox.OnFree_form_owner;
  end;
end;

function TMi_rtl.InputBox(aTitle: AnsiString;
                          aTemplate: AnsiString;
                          aOnCloseQuery: TOnCloseQuery;
                          aIn_JSONObject: TJSONObject;
                          out aOut_JSONObject: TJSONObject): TModalResult;
var
  MI_UI_InputBox : TMI_UI_InputBox;
begin
 try
   MI_UI_InputBox := create_MI_UI_InputBox;
   With MI_UI_InputBox do
     Result := InputBox(aTitle,
                          aTemplate,
                          aOnCloseQuery,
                          aIn_JSONObject,
                          aOut_JSONObject);

 finally
   if Assigned(MI_UI_InputBox.OnFree_form_owner)
   then MI_UI_InputBox.OnFree_form_owner;
 end;

end;

class function TMi_rtl.InputValue(const aTitle, aLabel: AnsiString;  var aValue: Variant): TModalResult;
var
  MI_UI_InputBox : TMI_UI_InputBox;
begin
 try
   MI_UI_InputBox := create_MI_UI_InputBox;
   if Assigned(MI_UI_InputBox)
   then Result := MI_UI_InputBox.InputValue(aTitle,aLabel,aValue);

 finally
   if Assigned(MI_UI_InputBox) and Assigned(MI_UI_InputBox.OnFree_form_owner)
   then MI_UI_InputBox.OnFree_form_owner;
 end;

end;

class function TMi_rtl.Prompt(aTitle: AnsiString; aPergunta: AnsiString;  var aResult: Variant): Boolean;
  var
    MI_UI_InputBox : TMI_UI_InputBox;
begin
 try
   MI_UI_InputBox := create_MI_UI_InputBox;
   if Assigned(MI_UI_InputBox)
   then Result := InputValue(aTitle,aPergunta,aResult)=TMI_UI_InputBox.MrOk
   else Result := false;

 finally
   if Assigned(MI_UI_InputBox) and Assigned(MI_UI_InputBox.OnFree_form_owner)
   then MI_UI_InputBox.OnFree_form_owner;
end;


end;

class function TMi_rtl.InputPassword(aTitle: AnsiString; out  aUsername: AnsiString; out apassword: AnsiString): Boolean;
  var
    MI_UI_InputBox : TMI_UI_InputBox;
begin
  try
    MI_UI_InputBox := create_MI_UI_InputBox;
    if Assigned(MI_UI_InputBox)
    then with MI_UI_InputBox do
           result := MI_UI_InputBox.InputPassword(aTitle,aUsername,apassword) = MrOk
    else Result := false;

  finally
    if Assigned(MI_UI_InputBox) and Assigned(MI_UI_InputBox.OnFree_form_owner)
    then MI_UI_InputBox.OnFree_form_owner;
  end;

end;

class function TMi_rtl.InputPassword(aTitle: AnsiString; out  apassword: AnsiString): Boolean;
  var
    MI_UI_InputBox : TMI_UI_InputBox;
begin
  try
    MI_UI_InputBox := create_MI_UI_InputBox;
    if Assigned(MI_UI_InputBox)
    Then with MI_UI_InputBox do
           result := MI_UI_InputBox.InputPassword(aTitle,apassword)=MrOk
    else Result := false;

  finally
    if Assigned(MI_UI_InputBox) and Assigned(MI_UI_InputBox.OnFree_form_owner)
    then MI_UI_InputBox.OnFree_form_owner;
  end;

end;

class function TMi_rtl.create_MI_UI_InputBox: TMI_UI_InputBox;
begin
  result := nil;
  if Assigned(Application)
  then Application.CreateForm(TMI_UI_InputBox,Result)
  else Result := nil;
end;

procedure TMi_rtl.Test_create_MI_UI_InputBox;
  var
    in_JSONObject,
    out_JSONObject : TJSONObject;
  var
    IBox : TMi_rtl.TMI_UI_InputBox;

begin
  try
    iBox := create_MI_UI_InputBox;
    if Assigned(iBox) then
    with IBox do
    begin
      in_JSONObject := TJSONObject.Create(['id'      , 1,
                                        'nome'    ,'Paulo Sérgio',
                                        'endereco','Rua Francisco de Souza Oliveira',
                                        'cep'     ,'61624-300']);

      //Exemplo com eventos
      if IBox.InputBox('Teste com eventos',
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

  finally
    if Assigned(iBox) and Assigned(iBox.OnFree_form_owner)
    then iBox.OnFree_form_owner;
  end;

end;

function TMi_rtl.create_MI_MsgBox: TMI_MsgBox;
begin
  result := nil;
  if Assigned(Application)
  then Application.CreateForm(TMI_MsgBox,Result)
  else Result := nil;
end;

procedure TMi_rtl.Test_create_MI_MsgBox;
  var
    MBox : TMi_rtl.TMI_MsgBox;

begin
  try
    MBox := create_MI_MsgBox;
    if Assigned(MBox)
    then MBox.MessageBox('Alô Mundo!');

  finally
    if Assigned(MBox) and Assigned(MBox.OnFree_form_owner)
    then MBox.OnFree_form_owner;
  end;

end;

class function TMi_rtl.Locate(const aField: pDmxFieldRec): TModalResult;
  var
    aIn_JSONObject :TJSONObject;
    aOut_JSONObject :TJSONObject;
    aKeyValues,AFieldName,ATemplate : AnsiString;
    Mi_rtl : TMi_rtl;
//    Current_pDmxFieldRec :pDmxFieldRec;
begin
  Mi_rtl := TMi_rtl.Create(nil);
  with Mi_rtl do
  try
//    Current_pDmxFieldRec := aField^.owner_UiDmxScroller.CurrentField;

    if (aField^.Fieldnum=0)
       or (aField^.IsInputRadio)
       or (aField^.IsComboBox)
       or (aField^.IsInputCheckbox)
    then begin
           Result := TMI_MsgBox.mrCancel;
           exit;
         end;

    aFieldName := aField^.FieldName;
    aTemplate := aField^.Template_org;

    aKeyValues := '';
    aIn_JSONObject := TJSONObject.Create([aFieldName,aKeyValues]);

    Result := InputBox('Pesquisar por: '+aFieldName,
                '~~'+^M+
                '~'+aFieldName+': ~'+'\'+aTemplate+chFN+aFieldName
                ,nil,'',nil,nil,nil,nil,
                aIn_JSONObject,
                aOut_JSONObject);

    if Result = TMI_MsgBox.mrok
    then begin
           aKeyValues := aOut_JSONObject.Strings[aFieldName];
           FreeAndNil(aOut_JSONObject);
           if aField^.IsNumber
           then begin
                   if aField^.owner_UiDmxScroller.Locate(aFieldName,aKeyValues, [loCaseInsensitive])
                   then Result := TMI_MsgBox.mrok
                   else Result := TMI_MsgBox.mrNo;
                end
           else begin
                   if aField^.owner_UiDmxScroller.Locate(aFieldName,aKeyValues, [loCaseInsensitive, loPartialKey])
                   then Result := TMI_MsgBox.mrok
                   else Result := TMI_MsgBox.mrNo;
                end;
         end
    else Result := TMI_MsgBox.mrCancel;

  finally
//    aField^.owner_UiDmxScroller.CurrentField := Current_pDmxFieldRec;
    FreeAndNil(aIn_JSONObject);
    Freeandnil(Mi_rtl);
  end;

end;


Initialization
  with TMI_RTL do
  begin
    //if _Logs = nil
    //then _Logs :=  TFilesLogs.Create(nil);

    //Application := mi.rtl.Objects.Methods.Paramexecucao.Application.Application;
  end;

{: - Finaliza a unit}
finalization

  //with TMI_RTL do
  //  if _Logs <> nil
  //  then begin
  //         FreeAndNIl(_Logs)
  //       end;

end.

