unit uDmxScroller_Form_Lcl_add_test;
{:< A unit **@name** implementa a classe TTForm1 do pacote mi.ui.}

{$IFDEF FPC}
  {$MODE Delphi} {$H-}
{$ENDIF}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, LMessages, StdCtrls,
  DBCtrls, ExtCtrls, ButtonPanel, uMi_ui_DmxScroller_Form_Lcl,
  uMi_ui_scrollbox_lcl, mi_rtl_ui_Dmxscroller;

type
  {: A unit **@name** é usada para testar o pacote mi.ui}

  { TDmxScroller_Form_Lcl_add_test }

  TDmxScroller_Form_Lcl_add_test = class(TForm)
    ButtonPanel1: TButtonPanel;
    DmxScroller_Form_Lcl1: TDmxScroller_Form_Lcl;
    Mi_ScrollBox_LCL1: TMi_ScrollBox_LCL;

    procedure DmxScroller_Form_Lcl1AddTemplate(const aUiDmxScroller: TUiDmxScroller     );
    procedure DmxScroller_Form_Lcl1Enter(aDmxScroller: TUiDmxScroller);
    procedure DmxScroller_Form_Lcl1EnterField(aField: pDmxFieldRec);
    procedure FormCreate(Sender: TObject);
//  protected procedure WMDESTROY(var Message: TLMDESTROY); message LM_DESTROY;
  private

  public
   destructor destroy;override;
  end;

var
  DmxScroller_Form_Lcl_add_test: TDmxScroller_Form_Lcl_add_test;

implementation

{$R *.lfm}

Resourcestring
  fld04h  ='Alfanumérico que só aceita os caracteres 0 a 9. Mask: (##) # #### ####';
  fld041h ='Alfanumérico Maiuscula Mask: SS';

{ TDmxScroller_Form_Lcl_add_test }


procedure TDmxScroller_Form_Lcl_add_test.FormCreate(Sender: TObject);
begin
  DmxScroller_Form_Lcl1.ParentLCL := Mi_ScrollBox_LCL1;
  DmxScroller_Form_Lcl1.Active:= true;
//  writeLn(Mi_ScrollBox_LCL1.WidthChar);
end;




Procedure AddTemplateHeader(const aUiDmxScroller:TUiDmxScroller);
begin
  with aUiDmxScroller do
  begin

    add('~EXEMPLO DE TEMPLATE~');
    add('');
    add('~ Teste do campo~');
    add('~     enumerado:~\'
            + CreateEnumField(TRUE, accNormal, 1,
                    NewSItem('item 00',
                    NewSItem('Item 01',
                            nil)))+ChFN+'Campo01'+ChH+'Campo Longint com as opções na lista supensa.');

    add('~    Vencimento:~\Ssssss'+ChFN+'Vencimento'+CreateOptions(1,NewSItem('Dia 10',
                                                                 NewSItem('Dia 15',
                                                                 NewSItem('Dia 20',
                                                                 NewSItem('Dia 25',
                                                                 nil)))))+
                                ChH+'Campo string com 6 posições com as opções na lista suspensa.');

    add('~         Prazo:~\BB'+ChFN+'Dias'+CreateOptions(2,NewSItem('30',
                                                       NewSItem('60',
                                                       NewSItem('90',
                                                       NewSItem('120',
                                                       nil)))))+
                             ChH+'Campo do tipo byte 2 caracteres numerico criado com função CreateOptions');
    add('');
  end;
end;

Procedure AddTemplateAlfanumericos(const aUiDmxScroller:TUiDmxScroller);
begin
  with aUiDmxScroller do
  begin
    add('~CAMPOS ALFANUMÉRICOS~');
    add('~ Alfanumerico 01:~\SSSSSSSSSSSSSSS'+ChFN+'Fld01'+ChH+'Campo alfanumérico com 15 posições maiúsculas.');
    add('~ Alfanumérico 02:~');
    add('~~\sssssssssssssssssssssssssssssss`sssssss'+ChFN+'fld02'+chH+'Alfanumérico maiúscula e minuscula com 30 posições.');
    add('~ Alfanumérico 03:~\Sssssssssssssss'+ChFN+'fld03'+chH+'Alfanumérico com a primeira letra maiúscula.');
    add('~ Alfanumérico 04:~\(##) # #### ####'+ChFN+'fld04' +chH+fld04h+'~Estado:~\SS' );
    add('~ Alfanumérico 05:~\SS'+ChFN+'fld041'+chH+fld041h+'~        Cidade natal:~\Ssssssssssssssssss');
    add('');
  end;
end;

Procedure AddTemplateNumericos(const aUiDmxScroller:TUiDmxScroller);
begin
  with aUiDmxScroller do
  begin
    add('~CAMPOS NUMÉRICOS~');
    add('~ Valor double.......:~\RRR,RRR,RRR,RRR.RRRR'+ChFN+'fld05'+ChH+'Número real com 8 bytes. (15–16 digitos significativos). Mask: RRR,RRR,RRR,RRR,RRR.RR');
    add('~ Valor Longint......:~\L,LLL,LLL,LLL'+ChFN+'fld06'+ChH+'Número inteiro longo com 4 bytes. Faixa: (-2,147,483,648 .. 2,147,483,647) Mask: L,LLL,LLL,LLL');
    add('~ Valor SmalInt......:~\II,III'+ChFN+'fld07'+ChH+'Número inteiro curdo com 2 bytes Faixa:(-32768 .. 32767). Mask: III,III');
    add('~ Valor Byte.........:~\BBB'+ChFN+'fld08'+ChH+'Número byte com 1 bytes. Faixa(0..255) Mask: BBB');
    add('~ Valor Smallword....:~\WW,WWW'+ChFN+'fld09'+ChH+'Número ineiro curto só positivo com 2 bytes. Faixa: (0..65535) . Mask: WW,WWW');
    add('');
  end;
end;


Procedure AddTemplateComplexo(const aUiDmxScroller:TUiDmxScroller);
begin
  with aUiDmxScroller do
  begin
    add('~CAMPOS COMPLEXOS~');
    add('~ Sexo...............:~'+ CreateEnumField(TRUE, accNormal, 1,
                                  NewSItem(' indefinido ',
                                  NewSItem(' Masculino',
                                  NewSItem(' Feminino',
                                          nil))))+ChFN+'fld10');

    add('~ Estado Civil              ~\KA Indefinido  '+chFN+'Sexo2'+ChFN+'fld11');
    add('~~\X Casado?                '+ChFN+'fld12'+'\KA Masculino    ');
    add('~~\X Pretende se divorciar? '+ChFN+'fld13'+'\KA Feminino     ');
    add('~~\X Tens filhos?           '+ChFN+'fld14');
    add('');
  end;
end;


procedure TDmxScroller_Form_Lcl_add_test.DmxScroller_Form_Lcl1AddTemplate(const aUiDmxScroller: TUiDmxScroller);
begin
  with aUiDmxScroller do
    AlignmentLabels:= taRightJustify;//taCenter;//taLeftJustify;

  AddTemplateHeader(aUiDmxScroller);
  AddTemplateAlfanumericos(aUiDmxScroller);
  AddTemplateNumericos(aUiDmxScroller);
  AddTemplateComplexo(aUiDmxScroller);
end;


procedure TDmxScroller_Form_Lcl_add_test.DmxScroller_Form_Lcl1Enter( aDmxScroller: TUiDmxScroller);
begin
  ShowMessage('OnEnter ');
end;

procedure TDmxScroller_Form_Lcl_add_test.DmxScroller_Form_Lcl1EnterField(  aField: pDmxFieldRec);
begin
  ShowMessage('Campo %s digitado.'+aField.FieldName);
end;

destructor TDmxScroller_Form_Lcl_add_test.destroy;
begin
  inherited destroy;
end;

end.

//~EXEMPLO DE TEMPLATE~
//
//~Alfanumérico maiúscula com 15 posições:~\SSSSSSSSSSSSSSS
//~Alfanumérico maiúscula com 25 posições:~\SSSSSSSSSSSSSSS`ssssssssss
//~Alfanumérico maiúscula e minuscula com 30 posições:~
//~~\ssssssssssssssssssssssssssssssssssssss
//~~
//~Alfanumérico com a~
//~primeira letra maiúscula:~\Sssssssssssssss
//~Telefone................:~\(##) # #### ####
//~Valor double............:~\RRR,RRR.RR
//~Valor SmalInt...........:~\II,III
//~Valor Byte..............:~\BBB
//~Valor Smallword.........:~\WW,WWW



//~EXEMPLO DE TEMPLATE~
//
//~Alfanumérico maiúscula com 15 posições:~\SSSSSSSSSSSSSSS
//~Alfanumérico maiúscula e minuscula com 30 posições:~
//~~\ssssssssssssssssssssssssssssssssssssss
//~Alfanumérico com a primeira letra maiúscula:~\Sssssssssssssss
//~Telefone...........:~\(##) # #### ####
//~Valor double.......:~\RRR,RRR.RR
//~Valor SmalInt......:~\II,III
//~Valor Byte.........:~\BBB
//~Valor Smallword....:~\WW,WWW




