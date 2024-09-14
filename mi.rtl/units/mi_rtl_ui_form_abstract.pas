unit mi_rtl_ui_form_abstract;

{:< A unit **@name** implementa a classe TMi_rtl_ui_dmxscroller_View.

   - Autor: Paulo Sérgio da Silva Pacheco paulosspacheco@@yahoo.com.br)

  - **VERSÃO**
    - Alpha - 1.0.0

  - **CÓDIGO FONTE**:
    - @html(<a href="../units/mi_rtl_ui_dmxscroller_View.pas">uMi_rtl_ui_Dmxscroller_form.pas</a>)

  - **HISTÓRICO**:
    - @html(<a href="../units/mi_rtl_ui_dmxscroller_View_historico.md">mi_rtl_ui_dmxscroller_View_historico.md</a>)

    - **2024-02-13**
      - Cria a unit **@name**

  - **PENDÊNCIAS**
    - T12 - Criar uma forma desta classe ser independente da visão, ou seja:
      - Todo o processamento ser feito em um TDataModule e poder ser usado
        para interagir com controles LCL, controles html, controles  android etc.



  - **CONCLUÍDO**
    -

}

{$mode Delphi}

interface

uses
  Classes
  , SysUtils
  ,mi_rtl_ui_Dmxscroller;

  type

    { TMi_rtl_ui_Form_abstract }

    {: A classe **@name** é uma classe abstrata cujo objetivo é editar o buffer
       da classe **TDmxScroller_Form**.
       Esta classe deve ser a base para implementação de componentes visuais
       tais como Formulários LCL, web Browser, Controles android.
    }
    TMi_rtl_ui_Form_abstract = class(TComponent,IMi_rtl_ui_Form)
      public constructor Create(AOwner: TComponent); override;

      {$REGION '--->Construção da propriedade Alias'}
        Protected Function GetAlias:AnsiString;Virtual;
        Protected Procedure SetAlias(Const aAlias:AnsiString);Virtual;
        Published  Property Alias : AnsiString Read GetAlias Write SetAlias;
      {$ENDREGION}


      {$REGION --> Propriedade UiDmxScroller}

         private _UiDmxScroller: TUiDmxScroller;

         {: O método **@anme** deve ser anulado para implementar as referências
            a classe TUiDmxScroller se **a_UiDmxScroller** for <> nil }
         protected procedure createRef_UiDmxScroller;virtual;

         {: O método **@anme** deve ser anulado para destruir as referências
            a classe TUiDmxScroller se **_UiDmxScroller** for <> nil }
         protected procedure destroyRef_UiDmxScroller;virtual;

         {: O método **@name** deve contruir e destrui as referência a classe
            _UiDmxScroller de processamento.
         }
         protected Procedure Set_UiDmxScroller(a_UiDmxScroller: TUiDmxScroller);Virtual;
         protected Function Get_UiDmxScroller:TUiDmxScroller;Virtual;
         {: A propriedade **@name** integra a classe visual a classe de processamento }
         public property UiDmxScroller: TUiDmxScroller read Get_UiDmxScroller write Set_UiDmxScroller;

      {$ENDREGION --> Propriedade UiDmxScroller}

      {$REGION --> Propriedade Active}
         protected function GetActive:Boolean;virtual;
         protected procedure SetActive(aActive : Boolean);virtual;
         public property Active : Boolean Read GetActive Write SetActive;
      {$ENDREGION --> Propriedade Active}

      {$REGION --> Propriedade FldRadioButtonsAdicionados}

         {: Usado para evitar que RadiosButton sejam adicionados mais de uma vês em
            radiosgroups diferentes.
            - Mais informações veja campos FldRadioGrous.
         }
         private _FldRadioButtonsAdicionados:TStringList;
//         protected function getFldRadioButtonsAdicionados:TStringList;
         public property FldRadioButtonsAdicionados:TStringList read _FldRadioButtonsAdicionados;

     {$ENDREGION --> Propriedade FldRadioButtonsAdicionados}

      public procedure ShowControlState;Virtual;

      {: O método **@name** é usado para da o scroller na janela onde esse componente for inserido.
         - **NOTA**
            - A LCL não rola a tela com a tecla tab e o controle não estiver visível.
      }
      public procedure Scroll_it_inview(AControl: pDmxFieldRec);Virtual;overload;

      {: O método **@name** é executado antes de executar getTemplate em SetActiveTarget.}
      public procedure DoBeforeSetActiveTarget;Virtual;


      {: O Método **@name** cria o formulário LCL baseado na lista de campos PDmxScroller. }
      public procedure CreateForm(aaOwner:TComponent);Virtual;

      public procedure DestroyStruct; Virtual;

      public   procedure UpdateBuffers_Controls;Virtual;
//      public procedure UpdateBuffers;Virtual;

      {: O método **@name** refresh repinta os campo se foi auterado. }
      public procedure Refresh;Virtual;

      {: A procedure **@name** seta a propriedade active  e criar um formulário
         LCL
      }
  //    public procedure SetActiveTarget(aActive: Boolean);Virtual;

      {: O método **@name** altera a fonte e o tamanho do controle passado por **ctrl** e de seus filhos.}
      public procedure ModifyFontsAll(ctrl_WinControl: TComponent;aFontName:String;aSize:integer);virtual;overload;

      {: O método **@name** altera a fonte do controle passado por **ctrl** e de seus filhos.}
      public procedure ModifyFontsAll(ctrl_WinControl: TComponent;aFontName:String);Virtual;overload;

      {: Essa média só funciona bem para as fontes Courie new ou Dejavu Sans Mono tamanho 12 }
      public function GetWidthChar():integer;virtual;Overload;
  //    public function GetWidthChar(s:string):integer;Overload;

      public function GetHeightChar():integer;virtual;Overload;

      //Verifica se o componente fornecido possui uma relação db e se o conteúdo foi alterado
      public function isValueDbChanged(Sender: TComponent): Boolean;Virtual;

      public function TextWidthChar(AFont: TPersistent): Integer;virtual;overload;
      public function TextHeightChar(AFont: TPersistent): Byte;virtual;overload;

      {: O método @name Executa o browser padrão do sistema operacional.

         - Exemplo:

           ```pascal

             program Project1;
              uses
                Interfaces,
                mi_rtl_ui_methods;
             begin

              TUiDmxScroller_ViewMethods.ShowHtml('https://wiki.freepascal.org/Webbrowser');

             end.
           ```
      }
      Public Procedure ShowHtml(URL:string);Virtual;

      {: O método **@name** inicia a documentação resumida do campo. aFldNum }
      Public Function SetHelpCtx_Hint(aFldNum:Integer;a_HelpCtx_Hint:AnsiString):pDmxFieldRec;Virtual;overload;

      {: O método **@name** inicia a documentação resumida do campo passado em :apDmxFieldRec}
      Public Procedure SetHelpCtx_Hint(apDmxFieldRec:pDmxFieldRec;a_HelpCtx_Hint:AnsiString);Virtual;overload;
    end;

implementation

{ TMi_rtl_ui_Form_abstract }



procedure TMi_rtl_ui_Form_abstract.createRef_UiDmxScroller;
begin
  _FldRadioButtonsAdicionados := TStringList.create;
end;

procedure TMi_rtl_ui_Form_abstract.destroyRef_UiDmxScroller;
begin
  FreeAndNil(_FldRadioButtonsAdicionados);
end;

procedure TMi_rtl_ui_Form_abstract.Set_UiDmxScroller(a_UiDmxScroller: TUiDmxScroller);
begin
  if Assigned(_UiDmxScroller)
    then begin
           destroyRef_UiDmxScroller;
           _UiDmxScroller := a_UiDmxScroller;
         end;

  _UiDmxScroller := a_UiDmxScroller;
  createRef_UiDmxScroller;

  UiDmxScroller.Set_Mi_rtl_ui_Form(self);

end;

function TMi_rtl_ui_Form_abstract.Get_UiDmxScroller: TUiDmxScroller;
begin
  result := _UiDmxScroller;
end;

function TMi_rtl_ui_Form_abstract.GetActive: Boolean;
begin
  if Assigned(UiDmxScroller)
  then result := UiDmxScroller.Active
  else result := false;
end;

procedure TMi_rtl_ui_Form_abstract.SetActive(aActive: Boolean);
begin
  if Assigned(UiDmxScroller)
  then UiDmxScroller.Active := aActive
  else raise TUiDmxScroller.TException.Create(self,'SetActive','A propriedade UiDmxScroller é obrigatória para ativar o formulário!');
end;

function TMi_rtl_ui_Form_abstract.getFldRadioButtonsAdicionados: TStringList;
begin
  result := _FldRadioButtonsAdicionados;
end;

procedure TMi_rtl_ui_Form_abstract.ShowControlState;
begin

end;

procedure TMi_rtl_ui_Form_abstract.Scroll_it_inview(AControl: pDmxFieldRec);
begin

end;

procedure TMi_rtl_ui_Form_abstract.DoBeforeSetActiveTarget;
begin

end;

procedure TMi_rtl_ui_Form_abstract.CreateForm(aaOwner: TComponent);
begin

end;

procedure TMi_rtl_ui_Form_abstract.DestroyStruct;
begin

end;

procedure TMi_rtl_ui_Form_abstract.UpdateBuffers_Controls;
begin

end;

procedure TMi_rtl_ui_Form_abstract.Refresh;
begin

end;

procedure TMi_rtl_ui_Form_abstract.ModifyFontsAll(ctrl_WinControl: TComponent;
  aFontName: String; aSize: integer);
begin

end;

procedure TMi_rtl_ui_Form_abstract.ModifyFontsAll(ctrl_WinControl: TComponent;
  aFontName: String);
begin

end;

function TMi_rtl_ui_Form_abstract.GetWidthChar(): integer;
begin
  result := 12;
end;

function TMi_rtl_ui_Form_abstract.GetHeightChar(): integer;
begin
  result := 17;
end;

function TMi_rtl_ui_Form_abstract.isValueDbChanged(Sender: TComponent): Boolean;
begin
  result := false;
end;

function TMi_rtl_ui_Form_abstract.TextWidthChar(AFont: TPersistent): Integer;
begin
  result := 12;
end;

function TMi_rtl_ui_Form_abstract.TextHeightChar(AFont: TPersistent): Byte;
begin
  result := 12;
end;

procedure TMi_rtl_ui_Form_abstract.ShowHtml(URL: string);
begin

end;

function TMi_rtl_ui_Form_abstract.SetHelpCtx_Hint(aFldNum: Integer;  a_HelpCtx_Hint: AnsiString): pDmxFieldRec;
begin
  result := UiDmxScroller.SetHelpCtx_Hint(aFldNum,a_HelpCtx_Hint);
end;

procedure TMi_rtl_ui_Form_abstract.SetHelpCtx_Hint(apDmxFieldRec: pDmxFieldRec; a_HelpCtx_Hint: AnsiString);
begin
  UiDmxScroller.SetHelpCtx_Hint(apDmxFieldRec,a_HelpCtx_Hint);
end;

//function TMi_rtl_ui_Form_abstract.getFldRadioButtonsAdicionados: TStringList;
//begin
//  result := _FldRadioButtonsAdicionados;
//end;

constructor TMi_rtl_ui_Form_abstract.Create(AOwner: TComponent);
begin
  inherited Create(aOwner);
  UiDmxScroller := nil;
end;

function TMi_rtl_ui_Form_abstract.GetAlias: AnsiString;
begin
  result := UiDmxScroller.Alias;
end;

procedure TMi_rtl_ui_Form_abstract.SetAlias(const aAlias: AnsiString);
begin

  if aAlias<>''
  then UiDmxScroller.Alias :=aAlias
  else UiDmxScroller.Alias :='TMi_rtl_ui_Form_abstract';
end;



//procedure TMi_rtl_ui_Form_abstract.ShowControlState;
//begin
//
//end;
//
//procedure TMi_rtl_ui_Form_abstract.Scroll_it_inview( AScrollWindow: TComponent; AControl: TComponent);
//begin
//
//end;
//
//procedure TMi_rtl_ui_Form_abstract.Scroll_it_inview(AControl: pDmxFieldRec);
//begin
//
//end;
//
//procedure TMi_rtl_ui_Form_abstract.DoBeforeSetActiveTarget;
//begin
//
//end;
//
//procedure TMi_rtl_ui_Form_abstract.CreateForm(aaOwner: TComponent);
//begin
//
//end;
//
//procedure TMi_rtl_ui_Form_abstract.DestroyStruct;
//begin
//
//end;
//
//procedure TMi_rtl_ui_Form_abstract.UpdateBuffers_Controls;
//begin
//
//end;
//
//procedure TMi_rtl_ui_Form_abstract.UpdateBuffers;
//begin
//                                  //procedure TMi_rtl_ui_Form_abstract.ShowControlState;
//begin
//
//end;
//
//procedure TMi_rtl_ui_Form_abstract.Scroll_it_inview( AScrollWindow: TComponent; AControl: TComponent);
//begin
//
//end;
//
//procedure TMi_rtl_ui_Form_abstract.Scroll_it_inview(AControl: pDmxFieldRec);
//begin
//
//end;
//
//procedure TMi_rtl_ui_Form_abstract.DoBeforeSetActiveTarget;
//begin
//
//end;
//
//procedure TMi_rtl_ui_Form_abstract.CreateForm(aaOwner: TComponent);
//begin
//
//end;
//
//procedure TMi_rtl_ui_Form_abstract.DestroyStruct;
//begin
//
//end;
//
//procedure TMi_rtl_ui_Form_abstract.UpdateBuffers_Controls;
//begin
//
//end;
//
//procedure TMi_rtl_ui_Form_abstract.UpdateBuffers;
//begin
//
//end;
//
//procedure TMi_rtl_ui_Form_abstract.Refresh;
//begin
//
//end;
//
//procedure TMi_rtl_ui_Form_abstract.ModifyFontsAll(ctrl_WinControl: TComponent; aFontName: String; aSize: integer);
//begin
//
//end;
//
//procedure TMi_rtl_ui_Form_abstract.ModifyFontsAll(ctrl_WinControl: TComponent; aFontName: String);
//begin
//
//end;
//
//function TMi_rtl_ui_Form_abstract.GetWidthChar(): integer;
//begin
//
//end;
//
//class function TMi_rtl_ui_Form_abstract.isValueDbChanged(Sender: TComponent): Boolean;
//begin
//end;
//
//class function TMi_rtl_ui_Form_abstract.TextWidthChar(AFont: TPersistent): Integer;
//begin
//
//end;
//
//class procedure TMi_rtl_ui_Form_abstract.ShowHtml(URL: string);
//begin
//
//end;
//
//function TMi_rtl_ui_Form_abstract.SetHelpCtx_Hint(aFldNum: Integer;
//  a_HelpCtx_Hint: AnsiString): pDmxFieldRec;
//begin
//
//end;
//
//procedure TMi_rtl_ui_Form_abstract.SetHelpCtx_Hint(apDmxFieldRec: pDmxFieldRec;
//  a_HelpCtx_Hint: AnsiString);
//begin
//
//end;

//end;
//
//procedure TMi_rtl_ui_Form_abstract.Refresh;
//begin
//
//end;
//
//procedure TMi_rtl_ui_Form_abstract.ModifyFontsAll(ctrl_WinControl: TComponent; aFontName: String; aSize: integer);
//begin
//
//end;
//
//procedure TMi_rtl_ui_Form_abstract.ModifyFontsAll(ctrl_WinControl: TComponent; aFontName: String);
//begin
//
//end;
//
//function TMi_rtl_ui_Form_abstract.GetWidthChar(): integer;
//begin
//
//end;
//
//function TMi_rtl_ui_Form_abstract.isValueDbChanged(Sender: TComponent): Boolean;
//begin
//end;
//
//function TMi_rtl_ui_Form_abstract.TextWidthChar(AFont: TPersistent): Integer;
//begin
//
//end;
//
//class procedure TMi_rtl_ui_Form_abstract.ShowHtml(URL: string);
//begin
//
//end;
//
//function TMi_rtl_ui_Form_abstract.SetHelpCtx_Hint(aFldNum: Integer;
//  a_HelpCtx_Hint: AnsiString): pDmxFieldRec;
//begin
//
//end;
//
//procedure TMi_rtl_ui_Form_abstract.SetHelpCtx_Hint(apDmxFieldRec: pDmxFieldRec;
//  a_HelpCtx_Hint: AnsiString);
//begin
//
//end;

end.

