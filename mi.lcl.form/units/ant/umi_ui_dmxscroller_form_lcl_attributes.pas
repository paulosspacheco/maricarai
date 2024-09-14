unit umi_ui_dmxscroller_form_lcl_attributes;
{:< A unit **@name** implementa a classe TDmxScroller_Form.

  - Primeiro autor: Paulo Sérgio da Silva Pacheco paulosspacheco@@yahoo.com.br)

  - **VERSÃO**
    - Alpha - 0.9.0

  - **CÓDIGO FONTE**:
    - @html(<a href="../units/umi_ui_dmxscroller_form_base.pas">uMi_rtl_ui_Dmxscroller_form_base.pas</a>)

  - **HISTÓRICO**:
    - T12 Criado unit com objetivo de separar o pacote **mi.rtl** do pacote **LCL** com objetivo de criar
      aplicação web independente de gráficos locais.

  - **PENDÊNCIAS**
    - T12 Documentar a unit.
    - T12 Criado unit com objetivo de separar o pacote **mi.rtl** do pacote **LCL** com objetivo de criar
      aplicação web independente de gráficos locais.
    - T12 Criar classe **TDmxScroller_Form_Lcl_attributes** e mover todos os atributos da classe
      TDmxScroller_Form_Lcl para ela.


}

{$mode Delphi}

interface

uses
  Classes, SysUtils,controls,StdCtrls,forms,typInfo,types,Graphics,ActnList,Dialogs
  ,mi.rtl.Consts
  ,mi_rtl_ui_DmxScroller_Form
  ,uMi_ui_scrollbox_lcl

  ;

type
  { TDmxScroller_Form_Lcl_attributes }
  {: A classe ** @name ** conscentra os atibutos comuns do pacote para construção
     da classe **TDmxScroller_Form_Lcl**
  }
  TDmxScroller_Form_Lcl_attributes = class(TDmxScroller_Form)
  {$REGION ' ---> Property ActionList : TActionList '}

   protected _ActionList : TActionList;

   {: A propriedade **@name** permite que ações do formulário LCL possam
      ser executados a partir do componente **TDmxScroller**.

      - **NOTA**
        - O interpretador de Template inicia o campo **TDmxFieldRec.ExecAction** e
          o campo LinkExecAction.
        - O gerador de formulário ao encontrar **TDmxFieldRec.ExecAction** cria um botão
          para que se possa executar a ação.

      - **EXEMPLO**

        ```pascal

          with DmxScroller_Form1 do
          begin
            Result := NewSItem('~     ~~⏭️&Primeiro~'+CharExecAction+Novo.Name+
                               '~⏩ P&róximo~'+CharExecAction+(Gravar.Name)+
                               '~⏪️&Anterior~'+CharExecAction+Pesquisar.Name+
                               '~⏮️ &Ultimo~'+CharExecAction+(Excluir.Name),nil);
          end;

        ```
   }
   published property ActionList : TActionList Read _ActionList   Write  _ActionList;
  {$ENDREGION ' <--- Property ActionList : TActionList '}


  {$REGION '--> Property ParentLCL'}
    private _ParentLCL : TScrollingWinControl;
    private procedure SetParentLCL(aParentLCL : TScrollingWinControl);virtual;

    {: A propriedade **@name** informa a janela que será desenhada o formulário}
    published Property ParentLCL : TScrollingWinControl Read _ParentLCL write SetParentLCL;
  {$ENDREGION '<-- Property ParentLCL'}


  end;

implementation

{ TDmxScroller_Form_Lcl_attributes }

procedure TDmxScroller_Form_Lcl_attributes.SetParentLCL(aParentLCL: TScrollingWinControl);
begin
    _ParentLCL := aParentLCL;
    if Assigned(_ParentLCL) and ( _ParentLCL.Caption = '')
    then _ParentLCL.Caption:= Alias;
    if Assigned(_ParentLCL)
    then begin
           with _ParentLCL do
           begin
  //           Font.name := 'Courier New';
  //           if Font.name <> 'Courier New'
  //           then Font.name := 'DejaVu Sans Mono';
  ////           Font.name := 'FreeMono';
  //           Font.Style:= [];  //estilo normal
  //           Font.PixelsPerInch := 96;
  //           Font.Size := -13;
  //           font.Height := 17;

             if _ParentLCL is TMi_ScrollBox_LCL
             Then WidthChar  := (_ParentLCL as TMi_ScrollBox_LCL).WidthChar
             else WidthChar  := (Canvas.TextWidth(CharAlfanumeric) div Length(CharAlfanumeric));

             HeightChar := Canvas.TextHeight(CharAlfanumeric)+5;
           end;
         end;

  end;

end.

