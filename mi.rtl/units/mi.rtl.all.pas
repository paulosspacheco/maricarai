unit mi.rtl.all;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,fpjson
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
    //public type TApplication = mi.rtl.Objects.Methods.Paramexecucao.Application.TApplication;
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
    {$REGION --> Classe da unit fpjson }

    {: O método **@name** criar um dialogo com o conteúdo de um json }
    class procedure printaJsonObject(aJSONObject: TJSONObject);

    {$REGION --> Implementação da contante MI_InputBox genérica}

       public type TMI_UI_InputBox = mi.rtl.ui.dmxscroller.inputbox.TMI_UI_InputBox;

       public Class Procedure Set_MI_UI_InputBox(aMI_UI_InputBox: TMI_UI_InputBox);Virtual;

       public const MI_UI_InputBox: TMI_UI_InputBox = nil;
    {$ENDREGION --> Implementação da contante MI_UI_InputBox genérica}

    public type MI_UI_InputBox_class = TMI_UI_InputBox_class;
  end;

implementation

{ TMi_rtl }


{: - Inicializa a unit}

class procedure TMi_rtl.printaJsonObject(aJSONObject: TJSONObject);
  var
    i : integer;
    n,v : string;
    template : AnsiString;

  var
    in_JObject,
    out_JObject : TJSONObject;
begin
   template := '';
   for i := 0 to aJSONObject.Count-1 do
   begin
     n  := aJSONObject.Names[i];
     v := aJSONObject.Strings[n];
     template := template+'~'+'Valor de '+n+' é: '+v+'~'+^M;
   end;

   with TMi_rtl,MI_UI_InputBox do
   begin

     in_JObject := TJSONObject.Create([]);
     if InputBox('Teste sem eventos',
        template
        ,in_JObject
        ,out_JObject) = mrok
     then begin
            FreeAndNil(out_JObject);
          end;

   end;
   FreeAndNil(in_JObject);
end;

class procedure TMi_rtl.Set_MI_UI_InputBox(aMI_UI_InputBox: TMI_UI_InputBox);
begin
  MI_UI_InputBox := aMI_UI_InputBox;
  if Assigned(MI_ui_Custom_Application)
  Then MI_ui_Custom_Application.MI_UI_InputBox := MI_UI_InputBox;
end;

Initialization
  with TMI_RTL do
  begin
    //if _Logs = nil
    //then _Logs :=  TFilesLogs.Create(nil);

    Application := mi.rtl.Objects.Methods.Paramexecucao.Application.Application;
  end;

{: - Finaliza a unit}
finalization

  //with TMI_RTL do
  //  if _Logs <> nil
  //  then begin
  //         FreeAndNIl(_Logs)
  //       end;

end.

